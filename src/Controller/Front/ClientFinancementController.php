<?php

namespace App\Controller\Front;

use App\Entity\Financement;
use App\Entity\Offre;
use App\Repository\FinancementRepository;
use App\Repository\OffreRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/client/financement')]
#[IsGranted('ROLE_USER')]
class ClientFinancementController extends AbstractController
{
    #[Route('/', name: 'client_financement_index')]
    public function index(FinancementRepository $financementRepository): Response
    {
        $user = $this->getUser();
        
        $request = $this->container->get('request_stack')->getCurrentRequest();
        $query = $request->query->get('q');
        
        $qb = $financementRepository->createQueryBuilder('f')
            ->where('f.client = :client')
            ->setParameter('client', $user)
            ->orderBy('f.date_demande', 'DESC');

        if ($query) {
            $qb->andWhere('f.objetFinancement LIKE :query OR f.montant_demande LIKE :query')
               ->setParameter('query', '%' . $query . '%');
        }

        $financements = $qb->getQuery()->getResult();

        if ($request->isXmlHttpRequest()) {
            return $this->render('front/financement/_table.html.twig', [
                'financements' => $financements
            ]);
        }

        return $this->render('front/financement/index.html.twig', [
            'financements' => $financements,
        ]);
    }

    #[Route('/simulation', name: 'client_financement_simulation')]
    public function simulation(OffreRepository $offreRepository): Response
    {
        // Get active credit offers for simulation dropdown
        $offres = $offreRepository->createQueryBuilder('o')
            ->where('o.type_offre LIKE :type')
            ->setParameter('type', '%Crédit%')
            ->andWhere('o.statut = :statut')
            ->setParameter('statut', 'Active')
            ->getQuery()
            ->getResult();

        return $this->render('front/financement/simulation.html.twig', [
            'offres' => $offres
        ]);
    }

    #[Route('/new', name: 'client_financement_new')]
    public function new(Request $request, EntityManagerInterface $entityManager, OffreRepository $offreRepository, \Symfony\Component\Validator\Validator\ValidatorInterface $validator): Response
    {
        $user = $this->getUser();
        $banque = $user->getBanque(); 
        
        if (!$banque) {
            $this->addFlash('error', 'Veuillez rejoindre une banque avant de demander un financement.');
            return $this->redirectToRoute('app_home');
        }

        if ($request->isMethod('POST')) {
            $financement = new Financement();
            $financement->setClient($user);
            $financement->setBanque($banque);
            $financement->setMontantDemande($request->request->get('montant'));
            $financement->setDureeMois((int)$request->request->get('duree'));
            $financement->setObjetFinancement($request->request->get('objet'));
            $financement->setTypeDmd($request->request->get('type_dmd'));

            // Handle File Uploads
            $files = $request->files->get('documents');
            if ($files) {
                foreach ($files as $file) {
                    $originalFilename = pathinfo($file->getClientOriginalName(), PATHINFO_FILENAME);
                    $newFilename = $originalFilename . '-' . uniqid() . '.' . $file->guessExtension();

                    try {
                        $file->move(
                            $this->getParameter('kernel.project_dir') . '/public/uploads/documents',
                            $newFilename
                        );

                        $document = new \App\Entity\Document();
                        $document->setNomFichier($originalFilename);
                        $document->setCheminStockage('/uploads/documents/' . $newFilename);
                        $document->setTypeDocument($file->getClientMimeType() ?? 'application/pdf');
                        $document->setDateDepot(new \DateTime());
                        $document->setStatutVerification('pending');
                        
                        $financement->addDocument($document);
                        $entityManager->persist($document);

                    } catch (\Exception $e) {
                        $this->addFlash('error', 'Erreur lors de l\'upload du fichier: ' . $e->getMessage());
                    }
                }
            }
            
            $offreId = $request->request->get('offre_id');
            if ($offreId) {
                $offre = $offreRepository->find($offreId);
                if ($offre) {
                    $financement->setOffre($offre);
                }
            }

            // Validate the entity
            $errors = $validator->validate($financement);
            if (count($errors) > 0) {
                foreach ($errors as $error) {
                    $this->addFlash('error', $error->getMessage());
                }
            } else {
                try {
                    $entityManager->persist($financement);
                    $entityManager->flush();

                    $this->addFlash('success', 'Votre demande de financement a été soumise avec succès.');
                    return $this->redirectToRoute('client_financement_index');
                } catch (\Exception $e) {
                    $this->addFlash('error', 'Erreur lors de la soumission: ' . $e->getMessage());
                }
            }
        }

        $offreId = $request->query->get('offre_id');
        $selectedOffre = null;
        if ($offreId) {
            $selectedOffre = $offreRepository->find($offreId);
        }

        return $this->render('front/financement/new.html.twig', [
            'selected_offre' => $selectedOffre
        ]);
    }
}
