<?php

namespace App\Repository;

use App\Entity\Service;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Service>
 */
class ServiceRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Service::class);
    }

    /**
     * Find available services by bank
     */
    public function findAvailableByBanque(int $banqueId): array
    {
        return $this->createQueryBuilder('s')
            ->where('s.banque = :banque')
            ->andWhere('s.disponible = :disponible')
            ->setParameter('banque', $banqueId)
            ->setParameter('disponible', true)
            ->orderBy('s.nom_service', 'ASC')
            ->getQuery()
            ->getResult();
    }

    /**
     * Find all services by bank (including unavailable)
     */
    public function findByBanque(int $banqueId): array
    {
        return $this->createQueryBuilder('s')
            ->where('s.banque = :banque')
            ->setParameter('banque', $banqueId)
            ->orderBy('s.nom_service', 'ASC')
            ->getQuery()
            ->getResult();
    }

    public function search(array $criteria): array
    {
        $qb = $this->createQueryBuilder('s')
            ->orderBy('s.nom_service', 'ASC');

        if (!empty($criteria['banque_id'])) {
            $qb->andWhere('s.banque = :banque')
               ->setParameter('banque', $criteria['banque_id']);
        }

        if (!empty($criteria['disponible'])) {
            $isAvailable = $criteria['disponible'] === '1';
            $qb->andWhere('s.disponible = :disponible')
               ->setParameter('disponible', $isAvailable);
        }

        if (!empty($criteria['search'])) {
            $qb->andWhere('s.nom_service LIKE :search OR s.description LIKE :search')
               ->setParameter('search', '%' . $criteria['search'] . '%');
        }

        return $qb->getQuery()->getResult();
    }
}
