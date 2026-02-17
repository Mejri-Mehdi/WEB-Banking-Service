<?php

namespace App\Controller\Admin;

use App\Entity\Utilisateur;
use App\Repository\UtilisateurRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/admin/utilisateurs')]
#[IsGranted('ROLE_ADMIN')]
class AdminUtilisateurController extends AbstractController
{
    #[Route('/', name: 'admin_users_index')]
    public function index(UtilisateurRepository $utilisateurRepository, \Knp\Component\Pager\PaginatorInterface $paginator, Request $request): Response
    {
        $queryBuilder = $utilisateurRepository->createQueryBuilder('u')
            ->orderBy('u.id', 'DESC');

        $users = $paginator->paginate(
            $queryBuilder,
            $request->query->getInt('page', 1),
            10 // Limit per page
        );

        return $this->render('admin/utilisateur/index.html.twig', [
            'users' => $users,
        ]);
    }

    #[Route('/{id}', name: 'admin_user_show', methods: ['GET'], requirements: ['id' => '\d+'])]
    public function show(Utilisateur $utilisateur, \App\Service\QrCodeService $qrCodeService): Response
    {
        // VCard Data
        $vCard = "BEGIN:VCARD\nVERSION:3.0\n";
        $vCard .= "FN:" . $utilisateur->getFullName() . "\n";
        $vCard .= "EMAIL:" . $utilisateur->getEmail() . "\n";
        if ($utilisateur->getTelephone()) {
            $vCard .= "TEL:" . $utilisateur->getTelephone() . "\n";
        }
        $vCard .= "ROLE:" . implode(', ', $utilisateur->getRoles()) . "\n";
        $vCard .= "END:VCARD";

        $qrCode = $qrCodeService->generateQrCode($vCard);

        return $this->render('admin/utilisateur/show.html.twig', [
            'user' => $utilisateur,
            'qrCode' => $qrCode,
        ]);
    }

    #[Route('/approve/{id}', name: 'admin_user_approve', methods: ['POST'])]
    public function approve(Utilisateur $utilisateur, EntityManagerInterface $entityManager, \Symfony\Component\Mailer\MailerInterface $mailer): Response
    {
        $utilisateur->setStatutCompte('active');
        $entityManager->flush();

        // Send Email
        $email = (new \Symfony\Component\Mime\Email())
            ->from('admin@beeline.tn')
            ->to($utilisateur->getEmail())
            ->subject('Compte Approuvé - Beeline Banking')
            ->text("Bonjour " . $utilisateur->getPrenom() . ",\n\nVotre compte a été approuvé par l'administrateur. Vous pouvez maintenant vous connecter.\n\nCordialement,\nL'équipe Beeline.");

        try {
            $mailer->send($email);
        } catch (\Exception $e) {
            // Log error but don't stop flow
        }

        $this->addFlash('success', 'L\'utilisateur a été approuvé et notifié.');
        return $this->redirectToRoute('admin_dashboard');
    }

    #[Route('/reject/{id}', name: 'admin_user_reject', methods: ['POST'])]
    public function reject(Utilisateur $utilisateur, EntityManagerInterface $entityManager, \Symfony\Component\Mailer\MailerInterface $mailer): Response
    {
        $utilisateur->setStatutCompte('blocked');
        $entityManager->flush();

        // Send Email
        $email = (new \Symfony\Component\Mime\Email())
            ->from('admin@beeline.tn')
            ->to($utilisateur->getEmail())
            ->subject('Inscription Rejetée - Beeline Banking')
            ->text("Bonjour " . $utilisateur->getPrenom() . ",\n\nVotre demande d'inscription a été rejetée. Veuillez contacter le support pour plus d'informations.\n\nCordialement,\nL'équipe Beeline.");

        try {
            $mailer->send($email);
        } catch (\Exception $e) {
            // Log error
        }

        $this->addFlash('success', 'L\'utilisateur a été rejeté et notifié.');
        return $this->redirectToRoute('admin_dashboard');
    }

    #[Route('/block/{id}', name: 'admin_user_block', methods: ['POST'])]
    public function block(Utilisateur $utilisateur, EntityManagerInterface $entityManager, \Symfony\Component\Mailer\MailerInterface $mailer): Response
    {
        $utilisateur->setStatutCompte('blocked');
        $entityManager->flush();

        // Send Email
        $email = (new \Symfony\Component\Mime\Email())
            ->from('admin@beeline.tn')
            ->to($utilisateur->getEmail())
            ->subject('Compte Bloqué - Beeline Banking')
            ->text("Bonjour " . $utilisateur->getPrenom() . ",\n\nVotre compte a été temporairement bloqué suite à une action administrative.\n\nCordialement,\nL'équipe Beeline.");

        try {
            $mailer->send($email);
        } catch (\Exception $e) {
            // Log error
        }

        $this->addFlash('success', 'L\'utilisateur a été bloqué et notifié.');
        return $this->redirectToRoute('admin_users_index');
    }

    #[Route('/unblock/{id}', name: 'admin_user_unblock', methods: ['POST'])]
    public function unblock(Utilisateur $utilisateur, EntityManagerInterface $entityManager, \Symfony\Component\Mailer\MailerInterface $mailer): Response
    {
        $utilisateur->setStatutCompte('active');
        $entityManager->flush();

        // Send Email
        $email = (new \Symfony\Component\Mime\Email())
            ->from('admin@beeline.tn')
            ->to($utilisateur->getEmail())
            ->subject('Compte Débloqué - Beeline Banking')
            ->text("Bonjour " . $utilisateur->getPrenom() . ",\n\nVotre compte a été réactivé. Vous pouvez de nouveau accéder à nos services.\n\nCordialement,\nL'équipe Beeline.");

        try {
            $mailer->send($email);
        } catch (\Exception $e) {
            // Log error
        }

        $this->addFlash('success', 'L\'utilisateur a été débloqué et notifié.');
        return $this->redirectToRoute('admin_users_index');
    }

    #[Route('/delete/{id}', name: 'admin_user_delete', methods: ['POST'])]
    public function delete(Utilisateur $utilisateur, EntityManagerInterface $entityManager): Response
    {
        // Prevent deleting self
        if ($utilisateur === $this->getUser()) {
            $this->addFlash('error', 'Vous ne pouvez pas supprimer votre propre compte.');
            return $this->redirectToRoute('admin_users_index');
        }

        try {
            $entityManager->remove($utilisateur);
            $entityManager->flush();
            $this->addFlash('success', 'L\'utilisateur a été supprimé.');
        } catch (\Exception $e) {
            $this->addFlash('error', 'Impossible de supprimer cet utilisateur: ' . $e->getMessage());
        }

        return $this->redirectToRoute('admin_users_index');
    }
}
