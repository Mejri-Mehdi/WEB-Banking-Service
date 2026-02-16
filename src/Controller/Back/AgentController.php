<?php

namespace App\Controller\Back;

use App\Repository\RendezVousRepository;
use App\Repository\FinancementRepository;
use App\Repository\BanqueRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/agent')]
#[IsGranted('ROLE_AGENT')]
class AgentController extends AbstractController
{
    #[Route('/dashboard', name: 'agent_dashboard')]
    public function dashboard(
        RendezVousRepository $rendezVousRepository,
        FinancementRepository $financementRepository,
        BanqueRepository $banqueRepository
    ): Response {
        $user = $this->getUser();

        // Sécurité: normalement impossible ici, mais on évite les surprises
        if (!$user) {
            return $this->redirectToRoute('app_login');
        }

        $banque = $user->getBanque();

        // ✅ IMPORTANT: éviter la boucle home -> redirect -> agent_dashboard -> home...
        if (!$banque) {
            $this->addFlash('error', 'Vous devez être associé à une banque pour accéder à l’espace agent.');
            return $this->redirectToRoute('app_logout');
        }

        $stats = $banqueRepository->getBanqueStatistics($banque->getId());

        $todayRdv = $rendezVousRepository->findTodayByBanque($banque->getId());
        $pendingFinancements = $financementRepository->findPendingByBanque($banque->getId());

        $stats['pending_rdv'] = $rendezVousRepository->countByStatutAndBanque('pending', $banque->getId());
        $stats['pending_financements'] = count($pendingFinancements);
        $stats['today_rdv'] = count($todayRdv);

        return $this->render('back/dashboard/index.html.twig', [
            'user' => $user,
            'stats' => $stats,
            'today_rdv' => $todayRdv,
            'pending_financements' => array_slice($pendingFinancements, 0, 5),
            'banque' => $banque,
        ]);
    }
}