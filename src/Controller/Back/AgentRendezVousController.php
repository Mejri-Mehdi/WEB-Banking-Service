<?php

namespace App\Controller\Back;

use App\Repository\RendezVousRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;
use App\Entity\RendezVous;

#[Route('/agent/rendez-vous')]
#[IsGranted('ROLE_AGENT')]
class AgentRendezVousController extends AbstractController
{
    #[Route('/', name: 'agent_rdv_index')]
    public function index(Request $request, RendezVousRepository $rendezVousRepository): Response
    {
        $user = $this->getUser();
        $banque = $user->getBanque();

        if (!$banque) {
            $this->addFlash('error', 'Vous devez être associé à une banque.');
            return $this->redirectToRoute('app_home');
        }

        $search = $request->query->get('search');
        $statut = $request->query->get('statut');
        $date = $request->query->get('date');

        $criteria = [
            'banque_id' => $banque->getId(),
            'search' => $search,
            'statut' => $statut,
            'date' => $date
        ];

        $rendezVous = $rendezVousRepository->search($criteria);

        if ($request->isXmlHttpRequest()) {
            return $this->render('back/rendez_vous/_table.html.twig', [
                'rendez_vous' => $rendezVous,
            ]);
        }

        return $this->render('back/rendez_vous/index.html.twig', [
            'rendez_vous' => $rendezVous,
            'banque' => $banque,
        ]);
    }

    #[Route('/today', name: 'agent_rdv_today')]
    public function today(RendezVousRepository $rendezVousRepository): Response
    {
        $user = $this->getUser();
        $banque = $user->getBanque();

        if (!$banque) {
            $this->addFlash('error', 'Vous devez être associé à une banque.');
            return $this->redirectToRoute('app_home');
        }

        $rendezVous = $rendezVousRepository->findTodayByBanque($banque->getId());

        return $this->render('back/rendez_vous/today.html.twig', [
            'rendez_vous' => $rendezVous,
            'banque' => $banque,
        ]);
    }

    #[Route('/update-status/{id}', name: 'agent_rdv_update_status', methods: ['POST'])]
    public function updateStatus(
        RendezVous $rendezVous,
        Request $request,
        EntityManagerInterface $entityManager
    ): Response {
        if ($rendezVous->getBanque() !== $this->getUser()->getBanque()) {
            throw $this->createAccessDeniedException();
        }

        $newStatut = $request->request->get('statut');
        $validStatuts = ['pending', 'confirmed', 'cancelled', 'completed'];

        if (in_array($newStatut, $validStatuts)) {
            $rendezVous->setStatut($newStatut);
            $entityManager->flush();

            $this->addFlash('success', 'Statut mis à jour.');
        }

        return $this->redirectToRoute('agent_rdv_index');
    }

    #[Route('/delay/{id}', name: 'agent_rdv_delay', methods: ['POST'])]
    public function delay(
        RendezVous $rendezVous,
        Request $request,
        EntityManagerInterface $entityManager
    ): Response {
        if ($rendezVous->getBanque() !== $this->getUser()->getBanque()) {
            throw $this->createAccessDeniedException();
        }

        $dateStr = $request->request->get('date_rdv');
        $timeStr = $request->request->get('heure_rdv');
        
        if ($dateStr && $timeStr) {
            $date = \DateTime::createFromFormat('Y-m-d', $dateStr);
            $time = \DateTime::createFromFormat('H:i', $timeStr);
            
            $rendezVous->setDateRdv($date);
            $rendezVous->setHeureRdv($time);
            // Optionally set status back to confirmed or keep as is
            
            $entityManager->flush();
            $this->addFlash('success', 'Rendez-vous reporté avec succès.');
        } else {
            $this->addFlash('error', 'Date ou heure invalide.');
        }

        return $this->redirectToRoute('agent_rdv_index');
    }
}
