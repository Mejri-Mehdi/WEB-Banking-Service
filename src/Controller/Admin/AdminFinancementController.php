<?php

namespace App\Controller\Admin;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/admin/financement')]
#[IsGranted('ROLE_ADMIN')]
class AdminFinancementController extends AbstractController
{
    #[Route('/', name: 'admin_financement_index')]
    public function index(\App\Repository\FinancementRepository $financementRepository): Response
    {
        $request = $this->container->get('request_stack')->getCurrentRequest();
        $query = $request->query->get('q');
        
        $qb = $financementRepository->createQueryBuilder('f')
            ->orderBy('f.date_demande', 'DESC');

        if ($query) {
            $qb->leftJoin('f.client', 'c')
               ->leftJoin('f.banque', 'b')
               ->where('c.nom LIKE :query OR c.prenom LIKE :query OR c.email LIKE :query OR b.nom_bq LIKE :query')
               ->setParameter('query', '%' . $query . '%');
        }

        $financements = $qb->getQuery()->getResult();

        if ($request->isXmlHttpRequest()) {
            return $this->render('admin/financement/_table.html.twig', [
                'financements' => $financements
            ]);
        }

        return $this->render('admin/financement/index.html.twig', [
            'financements' => $financements,
        ]);
    }
}
