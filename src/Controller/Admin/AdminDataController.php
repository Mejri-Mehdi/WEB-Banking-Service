<?php

namespace App\Controller\Admin;

use App\Repository\RendezVousRepository;
use App\Repository\OffreRepository;
use App\Repository\FinancementRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/admin')]
#[IsGranted('ROLE_ADMIN')]
class AdminDataController extends AbstractController
{
    #[Route('/rendez-vous', name: 'admin_rdv_index')]
    public function rendezVous(\Symfony\Component\HttpFoundation\Request $request, RendezVousRepository $rendezVousRepository): Response
    {
        $search = $request->query->get('search');
        $statut = $request->query->get('statut');
        $date = $request->query->get('date');

        if ($search || $statut || $date) {
            $criteria = [
                'search' => $search,
                'statut' => $statut,
                'date' => $date
            ];
            // Fix: Repository expects 'date' parameter, but the search method handles it.
            // We need to double check the repository search method logic.
            // Based on previous view_file, repository has search method.
            $rendezVous = $rendezVousRepository->search($criteria);
        } else {
            $rendezVous = $rendezVousRepository->findBy([], ['date_rdv' => 'DESC', 'heure_rdv' => 'DESC']);
        }

        if ($request->isXmlHttpRequest()) {
            return $this->render('admin/rendez_vous/_table.html.twig', [
                'rendez_vous' => $rendezVous,
            ]);
        }

        return $this->render('admin/rendez_vous/index.html.twig', [
            'rendez_vous' => $rendezVous,
        ]);
    }

    // Deprecated methods removed to use dedicated controllers


    #[Route('/services', name: 'admin_services_index')]
    public function services(\App\Repository\ServiceRepository $serviceRepository): Response
    {
        $services = $serviceRepository->findAll();

        return $this->render('admin/service/index.html.twig', [
            'services' => $services,
        ]);
    }
}
