<?php

namespace App\Controller\Front;

use App\Entity\RendezVous;
use App\Repository\RendezVousRepository;
use App\Repository\ServiceRepository;
use App\Repository\AgenceRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;
use App\Service\QrCodeGenerator;

#[Route('/client/ai')]
#[IsGranted('ROLE_USER')]
class ClientAiController extends AbstractController
{
    #[Route('/config', name: 'client_ai_config', methods: ['GET'])]
    public function config(ServiceRepository $serviceRepository, AgenceRepository $agenceRepository): JsonResponse
    {
        $user = $this->getUser();
        $banque = $user->getBanque();

        if (!$banque) {
            return $this->json(['error' => 'Aucune banque associée'], 400);
        }

        // Fetch services for fuzzy matching
        $services = $serviceRepository->findAvailableByBanque($banque->getId());
        $serviceData = array_map(function($s) {
            return [
                'id' => $s->getId(),
                'nom' => $s->getNomService(),
                'keywords' => strtolower($s->getNomService()) // Simplified for now
            ];
        }, $services);

        // Fetch primary agency (or all)
        $agences = $agenceRepository->findByBanque($banque->getId());
        $agenceData = array_map(function($a) {
            return [
                'id' => $a->getId(),
                'nom' => $a->getNomAg(),
                'address' => $a->getAdresseAg()
            ];
        }, $agences);

        return $this->json([
            'services' => $serviceData,
            'agences' => $agenceData,
            'user_name' => $user->getPrenom()
        ]);
    }

    #[Route('/check-availability', name: 'client_ai_check', methods: ['POST'])]
    public function checkAvailability(
        Request $request, 
        RendezVousRepository $rendezVousRepository,
        ServiceRepository $serviceRepository,
        AgenceRepository $agenceRepository
    ): JsonResponse {
        $data = json_decode($request->getContent(), true);
        
        $dateStr = $data['date'] ?? null; // YYYY-MM-DD
        $timeStr = $data['time'] ?? null; // HH:mm
        $serviceId = $data['service_id'] ?? null;
        $agenceId = $data['agence_id'] ?? null;

        if (!$dateStr || !$timeStr || !$serviceId || !$agenceId) {
            return $this->json(['available' => false, 'message' => 'Données incomplètes']);
        }

        try {
            $date = new \DateTime($dateStr);
            $time = new \DateTime($timeStr);
            
            // Check if date is in past
            $rdvStart = new \DateTime($dateStr . ' ' . $timeStr);
            if ($rdvStart < new \DateTime()) {
                return $this->json(['available' => false, 'message' => 'Cette date est déjà passée.']);
            }

            // Check Agency Hours (Basic 8h-17h check for POC)
            $hour = (int)$time->format('H');
            if ($hour < 8 || $hour >= 17) {
                return $this->json(['available' => false, 'message' => 'L\'agence est fermée à cette heure (8h-17h).']);
            }

            $service = $serviceRepository->find($serviceId);
            $agence = $agenceRepository->find($agenceId);
            
            if (!$service || !$agence) {
                return $this->json(['available' => false, 'message' => 'Service ou Agence introuvable']);
            }

            // --- GUICHET LOGIC ---
            $dureeMinutes = $service->getDureeEstimee() ?: 30;
            $newEnd = (clone $rdvStart)->modify("+$dureeMinutes minutes");

            $existingRdvs = $rendezVousRepository->findActiveByDateAndAgence($agence->getId(), $rdvStart);
            $totalGuichets = $agence->getNombreGuichets() ?: 3;
            
            $assignedGuichet = null;
            for ($i = 1; $i <= $totalGuichets; $i++) {
                $isGuichetFree = true;
                foreach ($existingRdvs as $rdv) {
                    if (($rdv->getNumeroGuichet() ?: 1) !== $i) continue;
                    
                    $rStart = new \DateTime($rdv->getDateRdv()->format('Y-m-d') . ' ' . $rdv->getHeureRdv()->format('H:i:s'));
                    $rEnd = (clone $rStart)->modify("+{$rdv->getDuree()} minutes");

                    if ($rdvStart < $rEnd && $newEnd > $rStart) {
                        $isGuichetFree = false; 
                        break;
                    }
                }
                if ($isGuichetFree) {
                    $assignedGuichet = $i;
                    break;
                }
            }

            if ($assignedGuichet !== null) {
                return $this->json([
                    'available' => true, 
                    'message' => "Le créneau de {$timeStr} est disponible.",
                    'guichet' => $assignedGuichet
                ]);
            } else {
                return $this->json([
                    'available' => false, 
                    'message' => "Désolé, tous les guichets sont occupés à {$timeStr}."
                ]);
            }

        } catch (\Exception $e) {
            return $this->json(['available' => false, 'message' => 'Erreur de vérification: ' . $e->getMessage()]);
        }
    }

    #[Route('/book', name: 'client_ai_book', methods: ['POST'])]
    public function book(
        Request $request,
        RendezVousRepository $rendezVousRepository,
        ServiceRepository $serviceRepository,
        AgenceRepository $agenceRepository,
        EntityManagerInterface $em,
        QrCodeGenerator $qrCodeGenerator
    ): JsonResponse {
        $data = json_decode($request->getContent(), true);
        $user = $this->getUser();

        $dateStr = $data['date'];
        $timeStr = $data['time'];
        $serviceId = $data['service_id'];
        $agenceId = $data['agence_id'];
        $guichet = $data['guichet'] ?? 1;

        $service = $serviceRepository->find($serviceId);
        $agence = $agenceRepository->find($agenceId);
        $banque = $user->getBanque();

        $rdv = new RendezVous();
        $rdv->setClient($user);
        $rdv->setBanque($banque);
        $rdv->setAgence($agence);
        $rdv->setService($service);
        $rdv->setDateRdv(new \DateTime($dateStr));
        $rdv->setHeureRdv(new \DateTime($timeStr));
        $rdv->setDuree($service->getDureeEstimee() ?: 30);
        $rdv->setStatut('pending');
        $rdv->setPriorite($service->getPrioriteDefaut() ?? 'medium');
        $rdv->setNumeroGuichet($guichet);

        $qrData = $rdv->getTicketReference() . ' - ' . $user->getFullName() . ' - ' . $dateStr . ' ' . $timeStr;
        $rdv->setQrCode($qrCodeGenerator->generate($qrData));

        $em->persist($rdv);
        $em->flush();

        return $this->json([
            'success' => true,
            'redirect_url' => $this->generateUrl('client_rdv_ticket', ['id' => $rdv->getId()])
        ]);
    }
}
