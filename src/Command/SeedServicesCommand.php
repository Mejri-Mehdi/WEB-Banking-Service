<?php

namespace App\Command;

use App\Entity\Banque;
use App\Entity\Service;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Console\Attribute\AsCommand;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;

#[AsCommand(
    name: 'app:seed-services',
    description: 'Seeds the database with sample services',
)]
class SeedServicesCommand extends Command
{
    public function __construct(
        private EntityManagerInterface $entityManager
    ) {
        parent::__construct();
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $io = new SymfonyStyle($input, $output);

        // Find the first available bank to attach services to
        $banque = $this->entityManager->getRepository(Banque::class)->findOneBy([]);

        if (!$banque) {
            $io->error('No bank found. Please create a bank first.');
            return Command::FAILURE;
        }

        $io->note('Seeding services for bank: ' . $banque->getNomBq());

        $servicesData = [
            [
                'nom' => 'Compte Courant',
                'desc' => 'Ouverture de compte courant avec chéquier et carte bancaire.',
                'duree' => 30,
                'frais' => 0,
                'docs' => 'CIN, Justificatif de domicile, Fiche de paie',
                'cat' => 'Compte',
                'prio' => 'high'
            ],
            [
                'nom' => 'Crédit Consommation',
                'desc' => 'Demande de crédit personnel pour vos projets.',
                'duree' => 45,
                'frais' => 50,
                'docs' => 'CIN, 3 dernières fiches de paie, Relevés bancaires 3 mois',
                'cat' => 'Crédit',
                'prio' => 'medium'
            ],
            [
                'nom' => 'Assurance Vie',
                'desc' => 'Souscription à une assurance vie pour protéger vos proches.',
                'duree' => 60,
                'frais' => 20,
                'docs' => 'CIN, Questionnaire médical',
                'cat' => 'Assurance',
                'prio' => 'low'
            ],
            [
                'nom' => 'Epargne Logement',
                'desc' => 'Plan d\'épargne pour votre futur logement.',
                'duree' => 30,
                'frais' => 10,
                'docs' => 'CIN',
                'cat' => 'Epargne',
                'prio' => 'medium'
            ]
        ];

        foreach ($servicesData as $data) {
            $service = new Service();
            $service->setBanque($banque);
            $service->setNomService($data['nom']);
            $service->setDescription($data['desc']);
            $service->setDureeEstimee($data['duree']);
            $service->setFrais((string)$data['frais']);
            $service->setDocumentsRequis($data['docs']);
            $service->setCategorie($data['cat']);
            $service->setPrioriteDefaut($data['prio']);
            $service->setDisponible(true);

            $this->entityManager->persist($service);
        }

        $this->entityManager->flush();

        $io->success('Services seeded successfully!');

        return Command::SUCCESS;
    }
}
