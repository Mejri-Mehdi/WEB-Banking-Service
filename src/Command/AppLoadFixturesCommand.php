<?php

namespace App\Command;

use App\Entity\Banque;
use App\Entity\Offre;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Console\Attribute\AsCommand;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;

#[AsCommand(
    name: 'app:load-offers',
    description: 'Creates dummy bank offers for testing',
)]
class AppLoadFixturesCommand extends Command
{
    private $entityManager;

    public function __construct(EntityManagerInterface $entityManager)
    {
        parent::__construct();
        $this->entityManager = $entityManager;
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $io = new SymfonyStyle($input, $output);

        $banqueRepo = $this->entityManager->getRepository(Banque::class);
        $banque = $banqueRepo->findOneBy([]);

        if (!$banque) {
            $io->error('No bank found. Please create a bank first.');
            return Command::FAILURE;
        }

        $io->note('Creating offers for bank: ' . $banque->getNomBq());

        $offersData = [
            [
                'titre' => 'Crédit Immobilier Jeune',
                'desc' => 'Taux préférentiel pour les moins de 30 ans. Financez votre premier logement avec des conditions avantageuses.',
                'type' => 'Crédit Immobilier',
                'taux' => '5.5',
                'min' => '50000',
                'max' => '500000',
                'fin' => '+1 year'
            ],
            [
                'titre' => 'Prêt Personnel Express',
                'desc' => 'Réponse en 24h pour vos projets personnels. Sans justificatif d\'utilisation.',
                'type' => 'Prêt Personnel',
                'taux' => '8.9',
                'min' => '1000',
                'max' => '30000',
                'fin' => '+6 months'
            ],
            [
                'titre' => 'Crédit Auto Écolo',
                'desc' => 'Pour l\'achat d\'un véhicule hybride ou électrique. Bonus écologique inclus.',
                'type' => 'Crédit Auto',
                'taux' => '4.2',
                'min' => '10000',
                'max' => '80000',
                'fin' => '+2 years'
            ],
            [
                'titre' => 'Prêt Travaux & Rénovation',
                'desc' => 'Financez vos travaux d\'aménagement ou d\'économie d\'énergie.',
                'type' => 'Crédit Travaux',
                'taux' => '6.1',
                'min' => '5000',
                'max' => '100000',
                'fin' => '+1 year'
            ]
        ];

        foreach ($offersData as $data) {
            $offre = new Offre();
            $offre->setTitre($data['titre']);
            $offre->setDescription($data['desc']);
            $offre->setTypeOffre($data['type']);
            $offre->setTaux($data['taux']);
            $offre->setMontantMin($data['min']);
            $offre->setMontantMax($data['max']);
            $offre->setBanque($banque);
            $offre->setStatut('Active');
            $offre->setDateDebut(new \DateTime());
            $offre->setDateFin(new \DateTime($data['fin']));

            $this->entityManager->persist($offre);
        }

        $this->entityManager->flush();

        $io->success('Successfully created ' . count($offersData) . ' offers.');

        return Command::SUCCESS;
    }
}
