<?php

namespace App\Repository;

use App\Entity\Banque;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\QueryBuilder;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Banque>
 */
class BanqueRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Banque::class);
    }

    public function findActiveBanques(): array
    {
        return $this->createQueryBuilder('b')
            ->where('b.statut = :statut')
            ->setParameter('statut', 'active')
            ->orderBy('b.nom_bq', 'ASC')
            ->getQuery()
            ->getResult();
    }

    public function findPendingBanques(): array
    {
        return $this->createQueryBuilder('b')
            ->where('b.statut = :statut')
            ->setParameter('statut', 'pending')
            ->orderBy('b.id', 'DESC')
            ->getQuery()
            ->getResult();
    }

    public function getBanqueStatistics(int $banqueId): array
    {
        return $this->createQueryBuilder('b')
            ->select('COUNT(DISTINCT a.id) as total_agences')
            ->addSelect('COUNT(DISTINCT u.id) as total_clients')
            ->addSelect('COUNT(DISTINCT s.id) as total_services')
            ->addSelect('COUNT(DISTINCT o.id) as total_offres')
            ->addSelect('COUNT(DISTINCT r.id) as total_rendez_vous')
            ->leftJoin('b.agences', 'a')
            ->leftJoin('b.utilisateurs', 'u')
            ->leftJoin('b.services', 's')
            ->leftJoin('b.offres', 'o')
            ->leftJoin('b.rendezVous', 'r')
            ->where('b.id = :banqueId')
            ->setParameter('banqueId', $banqueId)
            ->getQuery()
            ->getSingleResult();
    }

    /**
     * Retourne un QueryBuilder pour permettre la pagination.
     * $sort: id|nom|statut
     * $dir: asc|desc
     */
    public function searchAndSortQb(string $q, string $sort, string $dir): QueryBuilder
    {
        $qb = $this->createQueryBuilder('b');

        $q = trim($q);
        if ($q !== '') {
            $qb->andWhere(
                'LOWER(b.nom_bq) LIKE :q
                 OR LOWER(b.email_bq) LIKE :q
                 OR LOWER(b.telephone_bq) LIKE :q
                 OR LOWER(b.site_web) LIKE :q'
            )
            ->setParameter('q', '%' . mb_strtolower($q) . '%');
        }

        $map = [
            'id' => 'b.id',
            'nom' => 'b.nom_bq',
            'statut' => 'b.statut',
        ];

        $sortField = $map[$sort] ?? 'b.id';
        $dir = strtolower($dir) === 'desc' ? 'DESC' : 'ASC';

        $qb->orderBy($sortField, $dir);

        if ($sortField !== 'b.id') {
            $qb->addOrderBy('b.id', 'ASC');
        }

        return $qb;
    }
}