<?php

namespace App\Controller\Front;

use App\Repository\OffreRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/client/offres')]
#[IsGranted('ROLE_CLIENT')]
class ClientOffreController extends AbstractController
{
    #[Route('/', name: 'client_offres')]
    public function index(OffreRepository $offreRepository): Response
    {
        $user = $this->getUser();
        $banque = $user->getBanque();

        if (!$banque) {
            $this->addFlash('warning', 'Vous devez être associé à une banque pour voir les offres.');
            return $this->redirectToRoute('client_dashboard');
        }

        $request = $this->container->get('request_stack')->getCurrentRequest();
        $query = $request->query->get('q');
        
        if ($query) {
             $offres = $offreRepository->createQueryBuilder('o')
                ->where('o.banque = :banque')
                ->andWhere('o.statut = :statut')
                ->andWhere('(o.titre LIKE :query OR o.description LIKE :query OR o.type_offre LIKE :query)')
                ->setParameter('banque', $banque->getId())
                ->setParameter('statut', 'Active')
                ->setParameter('query', '%' . $query . '%')
                ->orderBy('o.date_debut', 'DESC')
                ->getQuery()
                ->getResult();
        } else {
            $offres = $offreRepository->findActiveByBanque($banque->getId());
        }

        if ($request->isXmlHttpRequest()) {
            return $this->render('front/offre/_list.html.twig', [
                'offres' => $offres,
            ]);
        }

        return $this->render('front/offre/index.html.twig', [
            'offres' => $offres,
            'banque' => $banque,
        ]);
    }
}
