<?php

namespace App\Controller\Back;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/agent/ai')]
#[IsGranted('ROLE_AGENT')]
class AgentAiController extends AbstractController
{
    #[Route('/suggest-service', name: 'agent_ai_suggest', methods: ['POST'])]
    public function suggestService(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);
        $prompt = strtolower($data['prompt'] ?? '');

        // Sanitize Prompt
        $prompt = trim(str_replace('.', '', $prompt)); // Remove dots

        // Default Values
        $suggestion = [
            'nom' => ucfirst($prompt),
            'description' => 'Service bancaire sur mesure adapté aux besoins spécifiques de nos clients.',
            'duree' => 30,
            'disponible' => 1,
            'categorie' => 'Autre',
            'priorite_defaut' => 'medium',
            'documents_requis' => 'CIN, Justificatif de domicile récent, Formulaire de demande signé.',
            'frais' => 10.00
        ];

        // 1. Detect Category & Specifics
        if (str_contains(strtolower($prompt), 'crédit') || str_contains(strtolower($prompt), 'pret') || str_contains(strtolower($prompt), 'logement') || str_contains(strtolower($prompt), 'immo')) {
            $suggestion['nom'] = 'Crédit Immobilier / Logement';
            $suggestion['description'] = "Financement pour l'acquisition, la construction ou la rénovation de votre logement. Taux avantageux et durée flexible.";
            $suggestion['duree'] = 60;
            $suggestion['categorie'] = 'Crédit';
            $suggestion['documents_requis'] = "CIN, Fiches de paie (3 mois), Relevés bancaires, Promesse de vente, Titre de propriété.";
            $suggestion['frais'] = 150.00;
        } elseif (str_contains(strtolower($prompt), 'voyage') || str_contains(strtolower($prompt), 'vacance')) {
            $suggestion['nom'] = 'Crédit Loisirs & Voyage';
            $suggestion['description'] = "Prêt personnel pour financer vos voyages et loisirs. Réponse rapide et déblocage express.";
            $suggestion['duree'] = 30;
            $suggestion['categorie'] = 'Crédit';
            $suggestion['documents_requis'] = "CIN, Dernière fiche de paie, Devis agence de voyage (optionnel).";
            $suggestion['frais'] = 50.00;
        } elseif (str_contains(strtolower($prompt), 'compte') || str_contains(strtolower($prompt), 'ouverture')) {
            $suggestion['nom'] = 'Ouverture de Compte';
            $suggestion['description'] = "Ouverture de compte courant ou épargne avec accès e-banking immédiat et commande de carte bancaire.";
            $suggestion['duree'] = 45;
            $suggestion['categorie'] = 'Compte';
            $suggestion['documents_requis'] = "CIN, Justificatif de domicile (STEG/SONEDE).";
            $suggestion['frais'] = 20.00;
        } elseif (str_contains($prompt, 'carte') || str_contains($prompt, 'visa') || str_contains($prompt, 'retrait')) {
            $suggestion['nom'] = 'Gestion Carte Bancaire';
            $suggestion['description'] = "Commande, renouvellement ou opposition de carte bancaire. Modification des plafonds de retrait et paiement.";
            $suggestion['duree'] = 20;
            $suggestion['categorie'] = 'Compte';
            $suggestion['documents_requis'] = "CIN, Ancienne carte (si renouvellement).";
            $suggestion['frais'] = 15.00;
        } elseif (str_contains($prompt, 'epargne') || str_contains($prompt, 'placement')) {
            $suggestion['nom'] = 'Plan Epargne';
            $suggestion['description'] = "Souscription à un plan d'épargne rémunéré avec conditions avantageuses et disponibilité des fonds.";
            $suggestion['duree'] = 40;
            $suggestion['categorie'] = 'Epargne';
            $suggestion['priorite_defaut'] = 'low'; // Savings usually less urgent
            $suggestion['documents_requis'] = "CIN.";
        } elseif (str_contains($prompt, 'assurance')) {
            $suggestion['nom'] = 'Souscription Assurance';
            $suggestion['description'] = "Protection complète (Vie, Auto, Habitation) avec garanties personnalisées.";
            $suggestion['duree'] = 30;
            $suggestion['categorie'] = 'Assurance';
            $suggestion['documents_requis'] = "CIN, Carte Grise (Auto), Titre propriété (Habitation).";
        } elseif (str_contains($prompt, 'virement') || str_contains($prompt, 'transfert')) {
            $suggestion['nom'] = 'Opérations de Virement';
            $suggestion['description'] = "Exécution de virements nationaux ou internationaux urgents.";
            $suggestion['duree'] = 15;
            $suggestion['categorie'] = 'Autre';
            $suggestion['priorite_defaut'] = 'high';
            $suggestion['frais'] = 5.00;
        }

        // 2. Detect Priority Overrides
        if (str_contains($prompt, 'urgent') || str_contains($prompt, 'haute')) {
            $suggestion['priorite_defaut'] = 'high';
            if (str_contains($prompt, 'très urgent')) $suggestion['priorite_defaut'] = 'urgent';
        } elseif (str_contains($prompt, 'basse') || str_contains($prompt, 'faible')) {
            $suggestion['priorite_defaut'] = 'low';
        }

        // 3. Detect Availability
        if (str_contains($prompt, 'indisponible') || str_contains($prompt, 'pas disponible') || str_contains($prompt, 'bientôt')) {
            $suggestion['disponible'] = 0;
        } elseif (str_contains($prompt, 'immédiatement') || str_contains($prompt, 'disponible')) {
            $suggestion['disponible'] = 1;
        }

        return $this->json($suggestion);
    }
}
