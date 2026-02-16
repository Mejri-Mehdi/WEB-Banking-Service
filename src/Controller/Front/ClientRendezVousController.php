<?php

namespace App\Controller\Front;

use App\Entity\RendezVous;
use App\Repository\RendezVousRepository;
use App\Repository\ServiceRepository;
use App\Repository\AgenceRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;
use App\Service\QrCodeGenerator;
use App\Service\PdfGenerator;

#[Route('/client/rendez-vous')]
#[IsGranted('ROLE_CLIENT')]
class ClientRendezVousController extends AbstractController
{
    #[Route('/new', name: 'client_rdv_book')]
    public function book(
        Request $request,
        ServiceRepository $serviceRepository,
        AgenceRepository $agenceRepository,
        RendezVousRepository $rendezVousRepository,
        EntityManagerInterface $entityManager,
        QrCodeGenerator $qrCodeGenerator
    ): Response {
        $user = $this->getUser();
        $banque = $user->getBanque();

        if (!$banque) {
            $this->addFlash('error', 'Vous devez être associé à une banque pour prendre un rendez-vous.');
            return $this->redirectToRoute('client_dashboard');
        }

        $services = $serviceRepository->findAvailableByBanque($banque->getId());
        $agences = $agenceRepository->findByBanque($banque->getId());

        if ($request->isMethod('POST')) {
            $serviceId = $request->request->get('service_id');
            $service = $serviceRepository->find($serviceId);
            
            $agenceId = $request->request->get('agence_id');
            $agence = $agenceRepository->find($agenceId);

            $dateStr = $request->request->get('date_rdv');
            $heureStr = $request->request->get('heure_rdv');

            if (!$agence || !$service || !$dateStr || !$heureStr) {
                $this->addFlash('error', 'Veuillez remplir tous les champs (Service, Agence, Date, Heure).');
                return $this->redirectToRoute('client_rdv_book');
            }

            // --- GUICHET ALLOCATION LOGIC ---

            $newStart = new \DateTime($dateStr . ' ' . $heureStr);
            $dureeMinutes = $service->getDureeEstimee() ?: 30;
            $newEnd = (clone $newStart)->modify("+$dureeMinutes minutes");

            // 1. Get all active appointments for this agency on this date
            $existingRdvs = $rendezVousRepository->findActiveByDateAndAgence($agence->getId(), $newStart);
            
            $assignedGuichet = null;
            $totalGuichets = $agence->getNombreGuichets() ?: 3;

            // 2. Iterate through each guichet to find a free slot
            for ($i = 1; $i <= $totalGuichets; $i++) {
                $isGuichetFree = true;

                foreach ($existingRdvs as $rdv) {
                    // Check if this RDV is assigned to the current guichet we are checking
                    $rdvGuichet = $rdv->getNumeroGuichet() ?: 1;

                    if ($rdvGuichet !== $i) {
                        continue; // Skip RDVs not on this guichet
                    }

                    // Check for Time Overlap
                    $rdvStart = $rdv->getDateRdv();
                    $rdvFullStart = new \DateTime($rdv->getDateRdv()->format('Y-m-d') . ' ' . $rdv->getHeureRdv()->format('H:i:s'));
                    
                    $rdvDuration = $rdv->getDuree() ?: 30;
                    $rdvFullEnd = (clone $rdvFullStart)->modify("+$rdvDuration minutes");

                    // Overlap condition: (StartA < EndB) and (EndA > StartB)
                    if ($newStart < $rdvFullEnd && $newEnd > $rdvFullStart) {
                        $isGuichetFree = false;
                        break; // This guichet is busy
                    }
                }

                if ($isGuichetFree) {
                    $assignedGuichet = $i;
                    break; // Found a free guichet!
                }
            }

            if ($assignedGuichet === null) {
                $this->addFlash('error', 'Aucun guichet disponible pour ce créneau. Veuillez choisir une autre heure.');
                return $this->render('front/rendez_vous/book.html.twig', [
                    'services' => $services,
                    'agences' => $agences,
                    'banque' => $banque,
                ]);
            }

            // --- END GUICHET LOGIC ---

            $rdv = new RendezVous();
            $rdv->setClient($user);
            $rdv->setBanque($banque);
            $rdv->setService($service);
            $rdv->setAgence($agence);
            $rdv->setDateRdv(new \DateTime($dateStr));
            $rdv->setHeureRdv(new \DateTime($heureStr));
            $rdv->setDuree($dureeMinutes);
            $rdv->setStatut('pending');
            $rdv->setPriorite($service->getPrioriteDefaut() ?? 'medium');
            $rdv->setNumeroGuichet($assignedGuichet);
            
            // Generate QR data (ticket reference)
            $qrData = $rdv->getTicketReference() . ' - ' . $user->getFullName() . ' - ' . $dateStr . ' ' . $heureStr . ' - Guichet ' . $assignedGuichet;
            $qrCode = $qrCodeGenerator->generate($qrData);
            $rdv->setQrCode($qrCode);

            try {
                $entityManager->persist($rdv);
                $entityManager->flush();

                $this->addFlash('success', 'Votre rendez-vous a été confirmé au Guichet ' . $assignedGuichet . ' !');
                return $this->redirectToRoute('client_rdv_ticket', ['id' => $rdv->getId()]);
            } catch (\Exception $e) {
                $this->addFlash('error', 'Erreur lors de la réservation : ' . $e->getMessage());
            }
        }

        return $this->render('front/rendez_vous/book.html.twig', [
            'services' => $services,
            'agences' => $agences,
            'banque' => $banque,
        ]);
    }

    #[Route('/my-appointments', name: 'client_rdv_list')]
    public function myAppointments(RendezVousRepository $rendezVousRepository): Response
    {
        $user = $this->getUser();
        $rendezVous = $rendezVousRepository->findByClient($user->getId());

        return $this->render('front/rendez_vous/my_appointments.html.twig', [
            'rendez_vous' => $rendezVous,
        ]);
    }

    #[Route('/ticket/{id}', name: 'client_rdv_ticket')]
    public function ticket(RendezVous $rendezVous): Response
    {
        if ($rendezVous->getClient() !== $this->getUser()) {
            throw $this->createAccessDeniedException();
        }

        return $this->render('front/rendez_vous/ticket.html.twig', [
            'rdv' => $rendezVous,
        ]);
    }

    #[Route('/ticket/{id}/download', name: 'client_rdv_download_ticket')]
    public function downloadTicket(RendezVous $rendezVous, PdfGenerator $pdfGenerator): Response
    {
        if ($rendezVous->getClient() !== $this->getUser()) {
            throw $this->createAccessDeniedException();
        }

        $html = $this->renderView('front/rendez_vous/ticket_pdf.html.twig', [
            'rendez_vous' => $rendezVous,
        ]);

        $pdfContent = $pdfGenerator->generate($html);

        return new Response($pdfContent, 200, [
            'Content-Type' => 'application/pdf',
            'Content-Disposition' => 'attachment; filename="ticket-' . $rendezVous->getTicketReference() . '.pdf"',
        ]);
    }

    #[Route('/cancel/{id}', name: 'client_rdv_cancel', methods: ['POST'])]
    public function cancel(RendezVous $rendezVous, EntityManagerInterface $entityManager): Response
    {
        if ($rendezVous->getClient() !== $this->getUser()) {
            throw $this->createAccessDeniedException();
        }

        $rendezVous->setStatut('cancelled');
        $entityManager->flush();

        $this->addFlash('success', 'Rendez-vous annulé.');
        return $this->redirectToRoute('client_rdv_list');
    }
}
