<?php

namespace App\Repository;

use App\Entity\Utilisateur;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Component\Security\Core\Exception\UnsupportedUserException;
use Symfony\Component\Security\Core\User\PasswordAuthenticatedUserInterface;
use Symfony\Component\Security\Core\User\PasswordUpgraderInterface;

/**
 * @extends ServiceEntityRepository<Utilisateur>
 */
class UtilisateurRepository extends ServiceEntityRepository implements PasswordUpgraderInterface
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Utilisateur::class);
    }

    /**
     * Used to upgrade (rehash) the user's password automatically over time.
     */
    public function upgradePassword(PasswordAuthenticatedUserInterface $user, string $newHashedPassword): void
    {
        if (!$user instanceof Utilisateur) {
            throw new UnsupportedUserException(sprintf('Instances of "%s" are not supported.', $user::class));
        }

        $user->setPassword($newHashedPassword);
        $this->getEntityManager()->persist($user);
        $this->getEntityManager()->flush();
    }

    /**
     * Find users by role
     * (roles stored as JSON string in DB, so we use LIKE)
     */
    public function findByRole(string $role): array
    {
        return $this->createQueryBuilder('u')
            ->andWhere('u.roles LIKE :role')
            ->setParameter('role', '%"' . $role . '"%')
            ->getQuery()
            ->getResult();
    }

    /**
     * Find pending users (for admin approval)
     */
    public function findPendingUsers(): array
    {
        return $this->createQueryBuilder('u')
            ->andWhere('u.statut_compte = :statut')
            ->setParameter('statut', 'pending')
            ->orderBy('u.id', 'DESC')
            ->getQuery()
            ->getResult();
    }

    /**
     * Find clients by bank (banque_id) + ROLE_CLIENT
     */
    public function findClientsByBanque(int $banqueId): array
    {
        return $this->createQueryBuilder('u')
            ->andWhere('IDENTITY(u.banque) = :banqueId')
            ->andWhere('u.roles LIKE :role')
            ->setParameter('banqueId', $banqueId)
            ->setParameter('role', '%"ROLE_CLIENT"%')
            ->getQuery()
            ->getResult();
    }
}