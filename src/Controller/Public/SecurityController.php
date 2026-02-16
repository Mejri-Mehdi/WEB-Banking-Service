<?php

namespace App\Controller\Public;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Authentication\AuthenticationUtils;

class SecurityController extends AbstractController
{
    #[Route('/login', name: 'app_login')]
    public function login(AuthenticationUtils $authenticationUtils): Response
    {
        // Redirect if already logged in
        if ($this->getUser()) {
            return $this->redirectToRoute('app_dashboard_redirect');
        }

        $error = $authenticationUtils->getLastAuthenticationError();
        $lastUsername = $authenticationUtils->getLastUsername();

        return $this->render('public/security/login.html.twig', [
            'last_username' => $lastUsername,
            'error' => $error,
        ]);
    }

    #[Route('/logout', name: 'app_logout')]
    public function logout(): void
    {
        throw new \LogicException('This method can be blank - it will be intercepted by the logout key on your firewall.');
    }

    #[Route('/dashboard/redirect', name: 'app_dashboard_redirect')]
    public function dashboardRedirect(): Response
    {
        $user = $this->getUser();

        if (!$user) {
            return $this->redirectToRoute('app_login');
        }

        // Check user account status
        if ($user->getStatutCompte() === 'blocked') {
            $this->addFlash('error', 'Votre compte a été bloqué. Veuillez contacter l\'administrateur.');
            return $this->redirectToRoute('app_logout');
        }

        if ($user->getStatutCompte() === 'pending') {
            $this->addFlash('warning', 'Votre compte est en attente d\'approbation par un administrateur.');
            return $this->redirectToRoute('app_logout');
        }

        // Redirect based on role
        if ($user->isAdmin()) {
            return $this->redirectToRoute('admin_dashboard');
        }

        if ($user->isAgent()) {
            // ✅ IMPORTANT: éviter la boucle si l'agent n'a pas de banque
            if (!$user->getBanque()) {
                $this->addFlash('error', 'Votre compte agent n’est associé à aucune banque. Contactez l’administrateur.');
                return $this->redirectToRoute('app_logout');
            }

            return $this->redirectToRoute('agent_dashboard');
        }

        if ($user->isClient()) {
            return $this->redirectToRoute('client_dashboard');
        }

        // Default redirect
        return $this->redirectToRoute('app_home');
    }
}