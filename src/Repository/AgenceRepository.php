<?php

namespace App\Repository;

use App\Entity\Agence;
use App\Entity\Banque;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\QueryBuilder;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Agence>
 */
class AgenceRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Agence::class);
    }

    public function findByBanque(int $banqueId): array
    {
        return $this->createQueryBuilder('a')
            ->andWhere('IDENTITY(a.banque) = :banqueId')
            ->setParameter('banqueId', $banqueId)
            ->orderBy('a.nom_ag', 'ASC')
            ->getQuery()
            ->getResult();
    }

    /**
     * Retourne un QueryBuilder pour permettre la pagination.
     * $sort: id|nom
     * $dir: asc|desc
     */
    public function searchByBanqueQb(Banque $banque, string $q, string $sort, string $dir): QueryBuilder
    {
        $qb = $this->createQueryBuilder('a')
            ->andWhere('a.banque = :banque')
            ->setParameter('banque', $banque);

        $q = trim($q);
        if ($q !== '') {
            $qb->andWhere(
                'LOWER(a.nom_ag) LIKE :q
                 OR LOWER(a.email) LIKE :q
                 OR LOWER(a.telephone) LIKE :q
                 OR LOWER(a.adresse_ag) LIKE :q'
            )
            ->setParameter('q', '%' . mb_strtolower($q) . '%');
        }

        $map = [
            'id' => 'a.id',
            'nom' => 'a.nom_ag',
        ];

        $sortField = $map[$sort] ?? 'a.id';
        $dir = strtolower($dir) === 'desc' ? 'DESC' : 'ASC';

        $qb->orderBy($sortField, $dir);

        if ($sortField !== 'a.id') {
            $qb->addOrderBy('a.id', 'ASC');
        }

        return $qb;
    }
}