<?php

namespace App\Controller\Back;

use App\Entity\Offre;
use App\Repository\OffreRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;
use Symfony\Component\Validator\Validator\ValidatorInterface;

#[Route('/agent/offre')]
#[IsGranted('ROLE_AGENT')]
class AgentOffreController extends AbstractController
{
    #[Route('/', name: 'agent_offre_index')]
    public function index(Request $request, OffreRepository $offreRepository): Response
    {
        $user = $this->getUser();
        $banque = $user->getBanque();

        if (!$banque) {
            $this->addFlash('error', 'Vous devez être associé à une banque.');
            return $this->redirectToRoute('app_home');
        }

        $query = $request->query->get('q');
        
        if ($query) {
            $offres = $offreRepository->createQueryBuilder('o')
                ->where('o.banque = :banque')
                ->andWhere('o.titre LIKE :query OR o.description LIKE :query OR o.type_offre LIKE :query')
                ->setParameter('banque', $banque)
                ->setParameter('query', '%' . $query . '%')
                ->getQuery()
                ->getResult();
        } else {
            $offres = $offreRepository->findBy(['banque' => $banque]);
        }

        if ($request->isXmlHttpRequest()) {
            return $this->render('back/offre/_table.html.twig', [
                'offres' => $offres
            ]);
        }

        return $this->render('back/offre/index.html.twig', [
            'offres' => $offres,
            'banque' => $banque,
        ]);
    }

    #[Route('/new', name: 'agent_offre_new')]
    public function new(Request $request, EntityManagerInterface $entityManager, ValidatorInterface $validator): Response
    {
        $user = $this->getUser();
        $banque = $user->getBanque();

        if (!$banque) {
            $this->addFlash('error', 'Vous devez être associé à une banque.');
            return $this->redirectToRoute('app_home');
        }

        if ($request->isMethod('POST')) {
            $offre = new Offre();
            $offre->setBanque($banque);
            $offre->setTitre($request->request->get('titre'));
            $offre->setDescription($request->request->get('description'));
            $offre->setTypeOffre($request->request->get('type_offre'));
            $offre->setTaux($request->request->get('taux'));
            $offre->setMontantMin($request->request->get('montant_min'));
            $offre->setMontantMax($request->request->get('montant_max'));
            
            // Dates
            try {
                if ($request->request->get('date_debut')) {
                    $offre->setDateDebut(new \DateTime($request->request->get('date_debut')));
                }
                if ($request->request->get('date_fin')) {
                    $offre->setDateFin(new \DateTime($request->request->get('date_fin')));
                }
            } catch (\Exception $e) {
                $this->addFlash('error', 'Format de date invalide.');
            }

            $offre->setStatut($request->request->has('active') ? 'Active' : 'Inactive');

            $errors = $validator->validate($offre);

            if (count($errors) > 0) {
                foreach ($errors as $error) {
                    $this->addFlash('error', $error->getMessage());
                }
            } else {
                try {
                    $entityManager->persist($offre);
                    $entityManager->flush();

                    $this->addFlash('success', 'L\'offre a été créée avec succès.');
                    return $this->redirectToRoute('agent_offre_index');
                } catch (\Exception $e) {
                    $this->addFlash('error', 'Une erreur s\'est produite: ' . $e->getMessage());
                }
            }
        }

        return $this->render('back/offre/new.html.twig', [
            'banque' => $banque,
        ]);
    }

    #[Route('/edit/{id}', name: 'agent_offre_edit')]
    public function edit(Offre $offre, Request $request, EntityManagerInterface $entityManager, ValidatorInterface $validator): Response
    {
        // Security check
        if ($offre->getBanque() !== $this->getUser()->getBanque()) {
            throw $this->createAccessDeniedException();
        }

        if ($request->isMethod('POST')) {
            $offre->setTitre($request->request->get('titre'));
            $offre->setDescription($request->request->get('description'));
            $offre->setTypeOffre($request->request->get('type_offre'));
            $offre->setTaux($request->request->get('taux'));
            $offre->setMontantMin($request->request->get('montant_min'));
            $offre->setMontantMax($request->request->get('montant_max'));

             // Dates
             try {
                if ($request->request->get('date_debut')) {
                    $offre->setDateDebut(new \DateTime($request->request->get('date_debut')));
                }
                if ($request->request->get('date_fin')) {
                    $offre->setDateFin(new \DateTime($request->request->get('date_fin')));
                }
            } catch (\Exception $e) {
                $this->addFlash('error', 'Format de date invalide.');
            }

            $offre->setStatut($request->request->has('active') ? 'Active' : 'Inactive');

            $errors = $validator->validate($offre);

            if (count($errors) > 0) {
                foreach ($errors as $error) {
                    $this->addFlash('error', $error->getMessage());
                }
            } else {
                try {
                    $entityManager->flush();
                    $this->addFlash('success', 'L\'offre a été modifiée avec succès.');
                    return $this->redirectToRoute('agent_offre_index');
                } catch (\Exception $e) {
                    $this->addFlash('error', 'Une erreur s\'est produite: ' . $e->getMessage());
                }
            }
        }

        return $this->render('back/offre/edit.html.twig', [
            'offre' => $offre,
        ]);
    }

    #[Route('/delete/{id}', name: 'agent_offre_delete', methods: ['POST'])]
    public function delete(Offre $offre, EntityManagerInterface $entityManager): Response
    {
        if ($offre->getBanque() !== $this->getUser()->getBanque()) {
            throw $this->createAccessDeniedException();
        }

        try {
            $entityManager->remove($offre);
            $entityManager->flush();
            $this->addFlash('success', 'L\'offre a été supprimée.');
        } catch (\Exception $e) {
            $this->addFlash('error', 'Erreur lors de la suppression.');
        }

        return $this->redirectToRoute('agent_offre_index');
    }
}
