<?php

namespace App\Repository;

use App\Entity\RendezVous;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<RendezVous>
 */
class RendezVousRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, RendezVous::class);
    }

    /**
     * Find appointments by client
     */
    public function findByClient(int $clientId): array
    {
        return $this->createQueryBuilder('r')
            ->where('r.client = :client')
            ->setParameter('client', $clientId)
            ->orderBy('r.date_rdv', 'DESC')
            ->addOrderBy('r.heure_rdv', 'DESC')
            ->getQuery()
            ->getResult();
    }

    /**
     * Find appointments by bank
     */
    public function findByBanque(int $banqueId): array
    {
        return $this->createQueryBuilder('r')
            ->where('r.banque = :banque')
            ->setParameter('banque', $banqueId)
            ->orderBy('r.date_rdv', 'DESC')
            ->addOrderBy('r.heure_rdv', 'DESC')
            ->getQuery()
            ->getResult();
    }

    /**
     * Find today's appointments for a bank
     */
    public function findTodayByBanque(int $banqueId): array
    {
        $today = new \DateTime();
        $today->setTime(0, 0, 0);
        
        $tomorrow = clone $today;
        $tomorrow->modify('+1 day');

        return $this->createQueryBuilder('r')
            ->where('r.banque = :banque')
            ->andWhere('r.date_rdv >= :today')
            ->andWhere('r.date_rdv < :tomorrow')
            ->setParameter('banque', $banqueId)
            ->setParameter('today', $today)
            ->setParameter('tomorrow', $tomorrow)
            ->orderBy('r.heure_rdv', 'ASC')
            ->getQuery()
            ->getResult();
    }

    /**
     * Find upcoming appointments by client
     */
    public function findUpcomingByClient(int $clientId): array
    {
        $now = new \DateTime();

        return $this->createQueryBuilder('r')
            ->where('r.client = :client')
            ->andWhere('r.date_rdv >= :now')
            ->andWhere('r.statut != :cancelled')
            ->setParameter('client', $clientId)
            ->setParameter('now', $now)
            ->setParameter('cancelled', 'cancelled')
            ->orderBy('r.date_rdv', 'ASC')
            ->addOrderBy('r.heure_rdv', 'ASC')
            ->getQuery()
            ->getResult();
    }

    /**
     * Count appointments by status for a bank
     */
    public function countByStatutAndBanque(string $statut, int $banqueId): int
    {
        return $this->createQueryBuilder('r')
            ->select('COUNT(r.id)')
            ->where('r.banque = :banque')
            ->andWhere('r.statut = :statut')
            ->setParameter('banque', $banqueId)
            ->setParameter('statut', $statut)
            ->getQuery()
            ->getSingleScalarResult();
    }
    /**
     * Find active appointments for a specific agency and date
     */
    public function findActiveByDateAndAgence(int $agenceId, \DateTimeInterface $date): array
    {
        return $this->createQueryBuilder('r')
            ->where('r.agence = :agence')
            ->andWhere('r.date_rdv = :date')
            ->andWhere('r.statut != :cancelled')
            ->setParameter('agence', $agenceId)
            ->setParameter('date', $date->format('Y-m-d'))
            ->setParameter('cancelled', 'cancelled')
            ->orderBy('r.heure_rdv', 'ASC')
            ->getQuery()
            ->getResult();
    }

    public function search(array $criteria): array
    {
        $qb = $this->createQueryBuilder('r')
            ->join('r.client', 'c')
            ->join('r.service', 's')
            ->orderBy('r.date_rdv', 'DESC')
            ->addOrderBy('r.heure_rdv', 'ASC');

        if (!empty($criteria['banque_id'])) {
            $qb->andWhere('r.banque = :banque')
               ->setParameter('banque', $criteria['banque_id']);
        }

        if (!empty($criteria['statut'])) {
            $qb->andWhere('r.statut = :statut')
               ->setParameter('statut', $criteria['statut']);
        }

        if (!empty($criteria['date'])) {
            $qb->andWhere('r.date_rdv = :date')
               ->setParameter('date', $criteria['date']);
        }

        if (!empty($criteria['search'])) {
            $qb->andWhere('c.nom LIKE :search OR c.prenom LIKE :search OR c.email LIKE :search OR r.ticket_reference LIKE :search')
               ->setParameter('search', '%' . $criteria['search'] . '%');
        }

        return $qb->getQuery()->getResult();
    }
    public function getServiceStats(): array
    {
        $qb = $this->createQueryBuilder('r')
            ->select('s.nom_service as serviceName', 'COUNT(r.id) as total', 's.duree_estimee as estimatedDuration')
            ->join('r.service', 's')
            ->groupBy('s.id')
            ->orderBy('total', 'DESC');

        return $qb->getQuery()->getResult();
    }

    public function getHourlyStats(): array
    {
        $qb = $this->createQueryBuilder('r')
             ->select('r.heure_rdv')
             ->where('r.statut != :cancelled')
             ->setParameter('cancelled', 'cancelled');
             
        $results = $qb->getQuery()->getResult();
        
        $stats = [];
        foreach ($results as $row) {
            $hour = $row['heure_rdv']->format('H');
            if (!isset($stats[$hour])) $stats[$hour] = 0;
            $stats[$hour]++;
        }
        
        ksort($stats);
        return $stats;
    }
}
