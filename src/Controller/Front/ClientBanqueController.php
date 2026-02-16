<?php

namespace App\Controller\Front;

use App\Repository\AgenceRepository;
use App\Repository\BanqueRepository;
use Knp\Component\Pager\PaginatorInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/client/banque')]
#[IsGranted('ROLE_CLIENT')]
class ClientBanqueController extends AbstractController
{
    private const AGENCES_PER_PAGE = 5;
    private const BANQUES_PER_PAGE = 6;

    #[Route('/', name: 'client_banque', methods: ['GET'])]
    public function view(
        Request $request,
        AgenceRepository $agenceRepository,
        PaginatorInterface $paginator
    ): Response {
        $user = $this->getUser();
        $banque = $user?->getBanque();

        if (!$banque) {
            $this->addFlash('warning', "Vous n'êtes pas encore associé à une banque.");
            return $this->redirectToRoute('client_dashboard');
        }

        // --- Recherche + Tri (GET) ---
        $q = trim((string) $request->query->get('q', ''));
        $t = (string) $request->query->get('t', 'nom_asc'); // nom_asc | nom_desc

        // Whitelist tri (sécurité / anti-injection)
        $orderBy = 'a.nom_ag';
        $direction = 'ASC';

        if ($t === 'nom_desc') {
            $direction = 'DESC';
        }

        $qb = $agenceRepository->createQueryBuilder('a')
            ->andWhere('a.banque = :banque')
            ->setParameter('banque', $banque);

        if ($q !== '') {
            $qb->andWhere('LOWER(a.nom_ag) LIKE :q')
               ->setParameter('q', '%' . mb_strtolower($q) . '%');
        }

        $qb->orderBy($orderBy, $direction);

        $agences = $paginator->paginate(
            $qb,
            max(1, $request->query->getInt('p', 1)),
            self::AGENCES_PER_PAGE,
            [
                'pageParameterName' => 'p',
                'query_parameters' => $request->query->all(),
            ]
        );

        return $this->render('front/banque/view.html.twig', [
            'banque' => $banque,
            'agences' => $agences,
            'q' => $q,
            't' => $t,
        ]);
    }

    #[Route('/autres', name: 'client_autres_banques', methods: ['GET'])]
    public function autresBanques(
        Request $request,
        BanqueRepository $banqueRepository,
        PaginatorInterface $paginator
    ): Response {
        $user = $this->getUser();
        $userBanque = $user?->getBanque();

        // --- Recherche + Tri (GET) ---
        $q = trim((string) $request->query->get('q', ''));
        $t = (string) $request->query->get('t', 'nom_asc'); // nom_asc | nom_desc

        // Whitelist tri (anti injection)
        // IMPORTANT: dans Doctrine, le champ Banque est très probablement "nom_bq"
        // (vu tes getters/setters: getNomBq(), setNomBq()).
        $orderBy = 'b.nom_bq';
        $direction = 'ASC';

        if ($t === 'nom_desc') {
            $direction = 'DESC';
        }

        $qb = $banqueRepository->createQueryBuilder('b');

        // Exclure la banque du client
        if ($userBanque) {
            $qb->andWhere('b != :userBanque')
               ->setParameter('userBanque', $userBanque);
        }

        // Recherche sur le nom
        if ($q !== '') {
            $qb->andWhere('LOWER(b.nom_bq) LIKE :q')
               ->setParameter('q', '%' . mb_strtolower($q) . '%');
        }

        $qb->orderBy($orderBy, $direction);

        // Pagination: 6 banques / page
        // Param de page: bp (Bank Page)
        $banques = $paginator->paginate(
            $qb,
            max(1, $request->query->getInt('bp', 1)),
            self::BANQUES_PER_PAGE,
            [
                'pageParameterName' => 'bp',
                // conserve q + t dans les liens pagination
                'query_parameters' => $request->query->all(),
            ]
        );

        return $this->render('front/banque/autres.html.twig', [
            'banques' => $banques,   // Pagination object
            'userBanque' => $userBanque,
            'q' => $q,
            't' => $t,
        ]);
    }
}