<?php

namespace App\Controller\Admin;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/admin/offre')]
#[IsGranted('ROLE_ADMIN')]
class AdminOffreController extends AbstractController
{
    #[Route('/', name: 'admin_offre_index')]
    public function index(\App\Repository\OffreRepository $offreRepository): Response
    {
        $request = $this->container->get('request_stack')->getCurrentRequest();
        $query = $request->query->get('q');

        if ($query) {
            $offres = $offreRepository->createQueryBuilder('o')
                ->where('o.titre LIKE :query OR o.description LIKE :query OR o.type_offre LIKE :query')
                ->setParameter('query', '%' . $query . '%')
                ->getQuery()
                ->getResult();
        } else {
            $offres = $offreRepository->findAll();
        }

        if ($request->isXmlHttpRequest() || $request->query->get('ajax')) {
            return $this->render('admin/offre/_table.html.twig', [
                'offres' => $offres
            ]);
        }

        return $this->render('admin/offre/index.html.twig', [
            'offres' => $offres,
        ]);
    }
}
