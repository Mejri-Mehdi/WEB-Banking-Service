<?php

namespace App\Controller\Back;

use App\Entity\Banque;
use App\Repository\AgenceRepository;
use Doctrine\ORM\EntityManagerInterface;
use Knp\Component\Pager\PaginatorInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;
use Symfony\Component\Validator\Validator\ValidatorInterface;

#[Route('/agent/banque')]
#[IsGranted('ROLE_AGENT')]
class AgentBanqueController extends AbstractController
{
    private const LOGO_UPLOAD_SUBDIR = 'uploads/banque_logos';
    private const AGENCES_PER_PAGE = 5;

    #[Route('/', name: 'agent_banque_view', methods: ['GET'])]
    public function view(
        Request $request,
        AgenceRepository $agenceRepository,
        PaginatorInterface $paginator
    ): Response {
        $user = $this->getUser();
        $banque = $user?->getBanque();

        if (!$banque) {
            $this->addFlash('error', 'Vous devez être associé à une banque.');
            return $this->redirectToRoute('app_home');
        }

        // ----------------------------
        // Recherche + tri (agences)
        // ----------------------------
        $q = trim((string) $request->query->get('q', ''));

        $sort = (string) $request->query->get('sort', 'id');         // id | nom
        $dir  = strtolower((string) $request->query->get('dir', 'desc')); // asc | desc

        $allowedSort = ['id', 'nom'];
        if (!in_array($sort, $allowedSort, true)) {
            $sort = 'id';
        }
        if (!in_array($dir, ['asc', 'desc'], true)) {
            $dir = 'desc';
        }

        // IMPORTANT:
        // Doctrine QueryBuilder utilise les NOMS DES PROPRIÉTÉS de l'entité, pas les getters Twig.
        // Chez toi c'est manifestement "nom_ag" et "adresse_ag".
        $qb = $agenceRepository->createQueryBuilder('a')
            ->andWhere('a.banque = :banque')
            ->setParameter('banque', $banque);

        if ($q !== '') {
            $qb->andWhere(
                'LOWER(COALESCE(a.nom_ag, \'\')) LIKE :q OR LOWER(COALESCE(a.adresse_ag, \'\')) LIKE :q'
            )
            ->setParameter('q', '%' . mb_strtolower($q) . '%');
        }

        if ($sort === 'nom') {
            $qb->orderBy('a.nom_ag', $dir);
        } else {
            $qb->orderBy('a.id', $dir);
        }

        $agences = $paginator->paginate(
            $qb,
            max(1, $request->query->getInt('ap', 1)),
            self::AGENCES_PER_PAGE,
            [
                'pageParameterName' => 'ap',
                'query_parameters' => $request->query->all(),
                'sortFieldParameterName' => null,
                'sortDirectionParameterName' => null,
            ]
        );

        return $this->render('back/banque/index.html.twig', [
            'banque' => $banque,
            'agences' => $agences,
            'q' => $q,
            'sort' => $sort,
            'dir' => $dir,
        ]);
    }

    #[Route('/edit', name: 'agent_banque_edit', methods: ['GET', 'POST'])]
    public function edit(
        Request $request,
        EntityManagerInterface $entityManager,
        ValidatorInterface $validator
    ): Response {
        $user = $this->getUser();
        $banque = $user?->getBanque();

        if (!$banque) {
            $this->addFlash('error', 'Vous devez être associé à une banque.');
            return $this->redirectToRoute('app_home');
        }

        $errorsByField = [];
        $old = [];

        if ($request->isMethod('POST')) {
            if (!$this->isCsrfTokenValid('agent_banque_edit_' . $banque->getId(), (string) $request->request->get('_token'))) {
                $this->addFlash('error', 'Token CSRF invalide.');
                return $this->redirectToRoute('agent_banque_edit');
            }

            $old = $this->buildOldFromRequest($request);
            $this->hydrateBanqueFromRequest($banque, $request);

            /** @var UploadedFile|null $logoFile */
            $logoFile = $request->files->get('logo');
            $banque->setLogoFile($logoFile instanceof UploadedFile ? $logoFile : null);

            $violations = $validator->validate($banque);
            if (count($violations) > 0) {
                $errorsByField = $this->violationsToTwigErrors($violations);
                $banque->setLogoFile(null);

                return $this->render('back/banque/edit.html.twig', [
                    'banque' => $banque,
                    'errors' => $errorsByField,
                    'old' => $old,
                ]);
            }

            try {
                $this->handleLogoUploadRequired($banque, $request);
            } catch (\Throwable $e) {
                $errorsByField['logoFile'][] = 'Logo invalide: ' . $e->getMessage();
                $banque->setLogoFile(null);

                return $this->render('back/banque/edit.html.twig', [
                    'banque' => $banque,
                    'errors' => $errorsByField,
                    'old' => $old,
                ]);
            }

            $banque->setLogoFile(null);

            try {
                $entityManager->flush();
                $this->addFlash('success', 'Les informations de la banque ont été mises à jour.');
                return $this->redirectToRoute('agent_banque_view');
            } catch (\Throwable $e) {
                $this->addFlash('error', 'Une erreur s’est produite: ' . $e->getMessage());
            }
        }

        return $this->render('back/banque/edit.html.twig', [
            'banque' => $banque,
            'errors' => $errorsByField,
            'old' => $old,
        ]);
    }

    private function hydrateBanqueFromRequest(Banque $banque, Request $request): void
    {
        $banque->setNomBq(trim((string) $request->request->get('nom_bq', '')));

        $site = trim((string) $request->request->get('site_web', ''));
        $banque->setSiteWeb($site);

        $tel = trim((string) $request->request->get('telephone_bq', ''));
        $banque->setTelephoneBq($tel);

        $email = trim((string) $request->request->get('email_bq', ''));
        $banque->setEmailBq($email);

        $desc = trim((string) $request->request->get('description', ''));
        $banque->setDescription($desc !== '' ? $desc : null);
    }

    private function buildOldFromRequest(Request $request): array
    {
        return [
            'nom_bq' => (string) $request->request->get('nom_bq', ''),
            'site_web' => (string) $request->request->get('site_web', ''),
            'telephone_bq' => (string) $request->request->get('telephone_bq', ''),
            'email_bq' => (string) $request->request->get('email_bq', ''),
            'description' => (string) $request->request->get('description', ''),
        ];
    }

    private function violationsToTwigErrors(\Traversable $violations): array
    {
        $errors = [];
        foreach ($violations as $violation) {
            $field = (string) $violation->getPropertyPath();
            $errors[$field][] = $violation->getMessage();
        }
        return $errors;
    }

    private function handleLogoUploadRequired(Banque $banque, Request $request): void
    {
        /** @var UploadedFile|null $file */
        $file = $request->files->get('logo');

        if (!$file instanceof UploadedFile) {
            throw new \RuntimeException('Aucun fichier de logo n’a été fourni.');
        }

        if (!$file->isValid()) {
            throw new \RuntimeException('Upload échoué.');
        }

        $maxBytes = 2 * 1024 * 1024;
        if ($file->getSize() !== null && $file->getSize() > $maxBytes) {
            throw new \RuntimeException('Fichier trop volumineux (max 2MB).');
        }

        $ext = strtolower($file->guessExtension() ?: $file->getClientOriginalExtension() ?: '');
        $allowedExt = ['png', 'jpg', 'jpeg', 'webp', 'svg'];
        if (!in_array($ext, $allowedExt, true)) {
            throw new \RuntimeException('Extensions autorisées: PNG, JPG, JPEG, WEBP, SVG.');
        }

        $projectDir = (string) $this->getParameter('kernel.project_dir');
        $targetDir = $projectDir . '/public/' . self::LOGO_UPLOAD_SUBDIR;

        if (!is_dir($targetDir) && !@mkdir($targetDir, 0775, true) && !is_dir($targetDir)) {
            throw new \RuntimeException('Impossible de créer le dossier d’upload: ' . self::LOGO_UPLOAD_SUBDIR);
        }

        $base = pathinfo($file->getClientOriginalName(), PATHINFO_FILENAME);
        $base = preg_replace('/[^a-zA-Z0-9_-]+/', '_', (string) $base);
        $newFilename = $base . '-' . bin2hex(random_bytes(6)) . '.' . $ext;

        $file->move($targetDir, $newFilename);

        $old = $banque->getLogo();
        if ($old && str_starts_with($old, self::LOGO_UPLOAD_SUBDIR . '/')) {
            $oldPath = $projectDir . '/public/' . $old;
            if (is_file($oldPath)) {
                @unlink($oldPath);
            }
        }

        $banque->setLogo(self::LOGO_UPLOAD_SUBDIR . '/' . $newFilename);
    }
}