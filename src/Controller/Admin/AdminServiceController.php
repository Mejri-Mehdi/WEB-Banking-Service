<?php

namespace App\Controller\Admin;

use App\Entity\Service;
use App\Repository\ServiceRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/admin/service')]
#[IsGranted('ROLE_ADMIN')]
class AdminServiceController extends AbstractController
{
    #[Route('/', name: 'admin_service_index')]
    public function index(Request $request, ServiceRepository $serviceRepository): Response
    {
        $search = $request->query->get('search');
        $disponible = $request->query->get('disponible');
        // Admin might want to filter by bank too, assuming search method handles it if I pass it
        // RendezVousRepository::search handles 'banque_id'.
        // ServiceRepository::search handles 'banque_id'.
        
        $criteria = [
            'search' => $search,
            'disponible' => $disponible
        ];

        $services = $serviceRepository->search($criteria);

        if ($request->isXmlHttpRequest()) {
            return $this->render('admin/service/_table.html.twig', [
                'services' => $services,
            ]);
        }

        return $this->render('admin/service/index.html.twig', [
            'services' => $services,
        ]);
    }

    #[Route('/feedback/{id}', name: 'admin_service_feedback', methods: ['POST'])]
    public function feedback(
        Service $service,
        Request $request,
        EntityManagerInterface $entityManager
    ): Response {
        $feedback = $request->request->get('feedback');
        
        $service->setAdminFeedback($feedback);
        $entityManager->flush();

        $this->addFlash('success', 'Feedback envoyé avec succès.');

        return $this->redirectToRoute('admin_service_index');
    }
}
