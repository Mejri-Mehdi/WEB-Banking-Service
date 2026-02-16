<?php

namespace App\Controller\Back;

use App\Entity\Financement;
use App\Repository\FinancementRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/agent/financement')]
#[IsGranted('ROLE_AGENT')]
class AgentFinancementController extends AbstractController
{
    #[Route('/', name: 'agent_financement_index')]
    public function index(Request $request, FinancementRepository $financementRepository): Response
    {
        $user = $this->getUser();
        $banque = $user->getBanque();

        if (!$banque) {
            $this->addFlash('error', 'Vous devez être associé à une banque.');
            return $this->redirectToRoute('app_home');
        }

        $query = $request->query->get('q');
        $statut = $request->query->get('statut');
        
        $qb = $financementRepository->createQueryBuilder('f')
            ->where('f.banque = :banque')
            ->setParameter('banque', $banque)
            ->orderBy('f.date_demande', 'DESC');

        if ($statut) {
            $qb->andWhere('f.statut = :statut')
               ->setParameter('statut', $statut);
        }

        if ($query) {
            $qb->leftJoin('f.client', 'c')
               ->andWhere('c.nom LIKE :query OR c.prenom LIKE :query OR c.email LIKE :query OR f.montant_demande LIKE :query')
               ->setParameter('query', '%' . $query . '%');
        }

        $financements = $qb->getQuery()->getResult();

        if ($request->isXmlHttpRequest()) {
            return $this->render('back/financement/_table.html.twig', [
                'financements' => $financements
            ]);
        }

        return $this->render('back/financement/index.html.twig', [
            'financements' => $financements,
            'statut_actuel' => $statut
        ]);
    }

    #[Route('/{id}', name: 'agent_financement_show', methods: ['GET'])]
    public function show(Financement $financement): Response
    {
        if ($financement->getBanque() !== $this->getUser()->getBanque()) {
            throw $this->createAccessDeniedException();
        }

        return $this->render('back/financement/show.html.twig', [
            'financement' => $financement,
        ]);
    }

    #[Route('/{id}/traiter', name: 'agent_financement_traiter', methods: ['POST'])]
    public function traiter(Request $request, Financement $financement, EntityManagerInterface $entityManager): Response
    {
        if ($financement->getBanque() !== $this->getUser()->getBanque()) {
            throw $this->createAccessDeniedException();
        }

        $action = $request->request->get('action'); // 'approve' or 'reject'
        $commentaire = $request->request->get('commentaire');

        if ($action === 'approve') {
            $financement->setStatut('approved');
            $this->addFlash('success', 'La demande a été approuvée.');
        } elseif ($action === 'reject') {
            $financement->setStatut('rejected');
            $this->addFlash('warning', 'La demande a été refusée.');
        }

        $financement->setCommentaireAgent($commentaire);
        $financement->setDateReponse(new \DateTime());

        $entityManager->flush();

        return $this->redirectToRoute('agent_financement_show', ['id' => $financement->getId()]);
    }
}
