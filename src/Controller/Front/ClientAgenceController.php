<?php

namespace App\Controller\Front;

use App\Entity\Agence;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/client/agences')]
#[IsGranted('ROLE_CLIENT')]
class ClientAgenceController extends AbstractController
{
    #[Route('/{id}', name: 'client_agence_view', requirements: ['id' => '\d+'], methods: ['GET'])]
    public function view(Agence $agence): Response
    {
        $user = $this->getUser();
        if (!$user) {
            return $this->redirectToRoute('app_login');
        }

        $banque = $user->getBanque();
        if (!$banque) {
            $this->addFlash('warning', 'Vous n\'êtes pas associé à une banque.');
            return $this->redirectToRoute('client_dashboard');
        }

        // Protection: l’agence doit appartenir à la banque du client
        if ($agence->getBanque() === null || $agence->getBanque()->getId() !== $banque->getId()) {
            throw $this->createAccessDeniedException();
        }

        return $this->render('front/agence/view.html.twig', [
            'banque' => $banque,
            'agence' => $agence,
        ]);
    }
}