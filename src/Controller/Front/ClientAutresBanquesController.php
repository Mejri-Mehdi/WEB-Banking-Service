<?php

namespace App\Controller\Front;

use App\Entity\Banque;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/client/autres-banques')]
#[IsGranted('ROLE_CLIENT')]
class ClientAutresBanquesController extends AbstractController
{
    #[Route('/', name: 'client_autres_banques_legacy', methods: ['GET'])]
    public function index(): Response
    {
        // Redirection vers la vraie page: /client/banque/autres
        return $this->redirectToRoute('client_autres_banques');
    }

    #[Route('/{id}', name: 'client_autre_banque_view', requirements: ['id' => '\d+'], methods: ['GET'])]
    public function view(Banque $banque): Response
    {
        $user = $this->getUser();
        $userBanque = $user?->getBanque();

        // "Autres banques" ne doit pas afficher sa propre banque.
        if ($userBanque && $banque->getId() === $userBanque->getId()) {
            return $this->redirectToRoute('client_banque');
        }

        return $this->render('front/banque/show.html.twig', [
            'banque' => $banque,
            'userBanque' => $userBanque,
        ]);
    }
}