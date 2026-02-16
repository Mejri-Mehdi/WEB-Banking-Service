<?php

namespace App\Controller\Admin;

use App\Repository\RendezVousRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/admin/rendez-vous')]
#[IsGranted('ROLE_ADMIN')]
class AdminRendezVousController extends AbstractController
{
    #[Route('/', name: 'admin_rendez_vous_index')]
    public function index(Request $request, RendezVousRepository $rendezVousRepository): Response
    {
        $search = $request->query->get('search');
        $statut = $request->query->get('statut');
        $date = $request->query->get('date');

        $criteria = [
            'search' => $search,
            'statut' => $statut,
            'date' => $date
        ];

        $rendezVous = $rendezVousRepository->search($criteria);

        if ($request->isXmlHttpRequest()) {
            return $this->render('admin/rendez_vous/_table.html.twig', [
                'rendez_vous' => $rendezVous,
            ]);
        }

        return $this->render('admin/rendez_vous/index.html.twig', [
            'rendez_vous' => $rendezVous,
        ]);
    }
}
