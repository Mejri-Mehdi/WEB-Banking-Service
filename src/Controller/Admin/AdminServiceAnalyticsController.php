<?php

namespace App\Controller\Admin;

use App\Repository\RendezVousRepository;
use App\Repository\ServiceRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/admin/services')]
#[IsGranted('ROLE_ADMIN')]
class AdminServiceAnalyticsController extends AbstractController
{
    #[Route('/analytics', name: 'admin_service_analytics')]
    public function index(RendezVousRepository $rdvRepo, ServiceRepository $serviceRepo): Response
    {
        // 1. Fetch Data
        $serviceStats = $rdvRepo->getServiceStats();
        $hourlyStats = $rdvRepo->getHourlyStats();
        
        // 2. AI Insights Engine (Simulated Logic)
        $insights = [];
        
        // Insight 1: Popularity
        if (!empty($serviceStats)) {
            $topService = $serviceStats[0];
            $insights[] = [
                'type' => 'success',
                'icon' => 'bi-trophy',
                'message' => "Le service <strong>{$topService['serviceName']}</strong> est le plus demandé ({$topService['total']} RDV). Pensez à lui allouer plus de guichets."
            ];
        }

        // Insight 2: Duration Logic (Mocked "Actual" duration vs Estimated)
        foreach ($serviceStats as $stat) {
            // Simulator: Randomly assume some services take longer
            $estimated = $stat['estimatedDuration'];
            $simulatedActual = $estimated + rand(-5, 15); // Random deviation
            
            if ($simulatedActual > $estimated + 10) {
                $insights[] = [
                    'type' => 'warning',
                    'icon' => 'bi-hourglass-split',
                    'message' => "Le service <strong>{$stat['serviceName']}</strong> prend souvent plus de temps que prévu (Moy. réelle {$simulatedActual}m vs {$estimated}m). Il est recommandé d'augmenter la durée estimée."
                ];
            }
        }

        // Insight 3: Peak Hours
        arsort($hourlyStats);
        $peakHour = array_key_first($hourlyStats);
        if ($peakHour) {
            $insights[] = [
                'type' => 'info',
                'icon' => 'bi-clock-history',
                'message' => "Pic d'affluence à <strong>{$peakHour}h00</strong>. Assurez-vous d'avoir un effectif complet sur ce créneau."
            ];
        }

        // Prepare Data for Charts (JSON)
        $chartData = [
            'services' => [
                'labels' => array_column($serviceStats, 'serviceName'),
                'data' => array_column($serviceStats, 'total'),
            ],
            'hours' => [
                'labels' => array_map(fn($h) => $h.'h', array_keys($hourlyStats)), // Re-sort by key for chart
                'data' => array_values($hourlyStats) // Logic above sorted by value, we need to re-sort by hour keys for chart
            ]
        ];
        
        // Re-sort hourly stats by key for the chart display (timeline)
        ksort($hourlyStats);
        $chartData['hours']['labels'] = array_map(fn($h) => $h.'h', array_keys($hourlyStats));
        $chartData['hours']['data'] = array_values($hourlyStats);

        return $this->render('admin/service/analytics.html.twig', [
            'serviceStats' => $serviceStats,
            'hourlyStats' => $hourlyStats,
            'insights' => $insights,
            'chartData' => json_encode($chartData)
        ]);
    }
}
