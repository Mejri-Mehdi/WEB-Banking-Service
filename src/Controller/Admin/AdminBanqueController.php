<?php

namespace App\Controller\Admin;

use App\Entity\Banque;
use App\Repository\AgenceRepository;
use App\Repository\BanqueRepository;
use Doctrine\ORM\EntityManagerInterface;
use Knp\Component\Pager\PaginatorInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;
use Symfony\Component\Validator\Validator\ValidatorInterface;

#[Route('/admin/banques')]
#[IsGranted('ROLE_ADMIN')]
class AdminBanqueController extends AbstractController
{
    private const LOGO_UPLOAD_SUBDIR = 'uploads/banque_logos';
    private const PER_PAGE = 5;

    #[Route('/', name: 'admin_banques_index', methods: ['GET'])]
    public function index(
        Request $request,
        BanqueRepository $banqueRepository,
        AgenceRepository $agenceRepository,
        PaginatorInterface $paginator
    ): Response {
        // ----------------------------
        // Banques: recherche + tri + pagination
        // ----------------------------
        $q = trim((string) $request->query->get('q', ''));

        $sort = (string) $request->query->get('sort', 'id');
        $dir  = strtolower((string) $request->query->get('dir', 'asc'));

        $allowedSort = ['id', 'nom', 'statut'];
        if (!in_array($sort, $allowedSort, true)) {
            $sort = 'id';
        }
        if (!in_array($dir, ['asc', 'desc'], true)) {
            $dir = 'asc';
        }

        $banquesQb = $banqueRepository->searchAndSortQb($q, $sort, $dir);

        // IMPORTANT: désactiver le tri automatique KNP (sinon il tente sort=id sans alias et ça casse)
        $banques = $paginator->paginate(
            $banquesQb,
            max(1, $request->query->getInt('bp', 1)),
            self::PER_PAGE,
            [
                'pageParameterName' => 'bp',
                'sortFieldParameterName' => null,
                'sortDirectionParameterName' => null,
                'query_parameters' => $request->query->all(),
            ]
        );

        // ----------------------------
        // Agences: uniquement si banque sélectionnée
        // ----------------------------
        $selectedBanque = null;
        $agences = null;

        $banqueId = $request->query->getInt('banque');
        if ($banqueId > 0) {
            $selectedBanque = $banqueRepository->find($banqueId);

            if ($selectedBanque) {
                $aq = trim((string) $request->query->get('aq', ''));

                $asort = (string) $request->query->get('asort', 'id');
                $adir  = strtolower((string) $request->query->get('adir', 'asc'));

                $allowedASort = ['id', 'nom'];
                if (!in_array($asort, $allowedASort, true)) {
                    $asort = 'id';
                }
                if (!in_array($adir, ['asc', 'desc'], true)) {
                    $adir = 'asc';
                }

                $agencesQb = $agenceRepository->searchByBanqueQb($selectedBanque, $aq, $asort, $adir);

                // IMPORTANT: pareil, on désactive le tri automatique KNP
                $agences = $paginator->paginate(
                    $agencesQb,
                    max(1, $request->query->getInt('ap', 1)),
                    self::PER_PAGE,
                    [
                        'pageParameterName' => 'ap',
                        'sortFieldParameterName' => null,
                        'sortDirectionParameterName' => null,
                        'query_parameters' => $request->query->all(),
                    ]
                );
            }
        }

        return $this->render('admin/banque/index.html.twig', [
            'banques' => $banques, // Pagination object
            'selected_banque' => $selectedBanque,
            'agences' => $agences, // Pagination object ou null
        ]);
    }

    #[Route('/new', name: 'admin_banque_new', methods: ['GET', 'POST'])]
    public function new(
        Request $request,
        EntityManagerInterface $entityManager,
        ValidatorInterface $validator
    ): Response {
        $banque = new Banque();
        $errorsByField = [];
        $old = [];

        if ($request->isMethod('POST')) {
            if (!$this->isCsrfTokenValid('banque_new', (string) $request->request->get('_token'))) {
                $this->addFlash('error', 'Token CSRF invalide.');
                return $this->redirectToRoute('admin_banque_new');
            }

            $old = $this->buildOldFromRequest($request);

            $this->hydrateBanqueFromRequest($banque, $request);

            /** @var UploadedFile|null $logoFile */
            $logoFile = $request->files->get('logo');
            $banque->setLogoFile($logoFile instanceof UploadedFile ? $logoFile : null);

            $violations = $validator->validate($banque);
            if (count($violations) > 0) {
                $errorsByField = $this->violationsToTwigErrors($violations);

                return $this->render('admin/banque/new.html.twig', [
                    'banque' => $banque,
                    'errors' => $errorsByField,
                    'old' => $old,
                ]);
            }

            try {
                $this->handleLogoUpload($banque, $request);
            } catch (\Throwable $e) {
                $errorsByField['logoFile'][] = 'Logo invalide: ' . $e->getMessage();

                return $this->render('admin/banque/new.html.twig', [
                    'banque' => $banque,
                    'errors' => $errorsByField,
                    'old' => $old,
                ]);
            }

            $entityManager->persist($banque);
            $entityManager->flush();

            $this->addFlash('success', 'Banque ajoutée avec succès.');
            return $this->redirectToRoute('admin_banque_show', ['id' => $banque->getId()]);
        }

        return $this->render('admin/banque/new.html.twig', [
            'banque' => $banque,
            'errors' => $errorsByField,
            'old' => $old,
        ]);
    }

    #[Route('/{id}', name: 'admin_banque_show', requirements: ['id' => '\d+'], methods: ['GET'])]
    public function show(Banque $banque): Response
    {
        return $this->render('admin/banque/show.html.twig', [
            'banque' => $banque,
        ]);
    }

    #[Route('/{id}/edit', name: 'admin_banque_edit', requirements: ['id' => '\d+'], methods: ['GET', 'POST'])]
    public function edit(
        Request $request,
        Banque $banque,
        EntityManagerInterface $entityManager,
        ValidatorInterface $validator
    ): Response {
        $errorsByField = [];
        $old = [];

        if ($request->isMethod('POST')) {
            if (!$this->isCsrfTokenValid('banque_edit_' . $banque->getId(), (string) $request->request->get('_token'))) {
                $this->addFlash('error', 'Token CSRF invalide.');
                return $this->redirectToRoute('admin_banque_edit', ['id' => $banque->getId()]);
            }

            $old = $this->buildOldFromRequest($request);

            $this->hydrateBanqueFromRequest($banque, $request);

            /** @var UploadedFile|null $logoFile */
            $logoFile = $request->files->get('logo');
            $banque->setLogoFile($logoFile instanceof UploadedFile ? $logoFile : null);

            $violations = $validator->validate($banque);
            if (count($violations) > 0) {
                $errorsByField = $this->violationsToTwigErrors($violations);

                return $this->render('admin/banque/edit.html.twig', [
                    'banque' => $banque,
                    'errors' => $errorsByField,
                    'old' => $old,
                ]);
            }

            try {
                $this->handleLogoUpload($banque, $request);
            } catch (\Throwable $e) {
                $errorsByField['logoFile'][] = 'Logo invalide: ' . $e->getMessage();

                return $this->render('admin/banque/edit.html.twig', [
                    'banque' => $banque,
                    'errors' => $errorsByField,
                    'old' => $old,
                ]);
            }

            $entityManager->flush();

            $this->addFlash('success', 'Banque mise à jour.');
            return $this->redirectToRoute('admin_banque_show', ['id' => $banque->getId()]);
        }

        return $this->render('admin/banque/edit.html.twig', [
            'banque' => $banque,
            'errors' => $errorsByField,
            'old' => $old,
        ]);
    }

    #[Route('/approve/{id}', name: 'admin_banque_approve', requirements: ['id' => '\d+'], methods: ['POST'])]
    public function approve(Banque $banque, EntityManagerInterface $entityManager): Response
    {
        $banque->setStatut('active');
        $entityManager->flush();

        $this->addFlash('success', 'La banque a été approuvée.');
        return $this->redirectToRoute('admin_dashboard');
    }

    #[Route('/reject/{id}', name: 'admin_banque_reject', requirements: ['id' => '\d+'], methods: ['POST'])]
    public function reject(Banque $banque, EntityManagerInterface $entityManager): Response
    {
        $banque->setStatut('rejected');
        $entityManager->flush();

        $this->addFlash('success', 'La banque a été rejetée.');
        return $this->redirectToRoute('admin_dashboard');
    }

    #[Route('/delete/{id}', name: 'admin_banque_delete', requirements: ['id' => '\d+'], methods: ['POST'])]
    public function delete(Request $request, Banque $banque, EntityManagerInterface $entityManager): Response
    {
        if (!$this->isCsrfTokenValid('delete_banque_' . $banque->getId(), (string) $request->request->get('_token'))) {
            $this->addFlash('error', 'Token CSRF invalide.');
            return $this->redirectToRoute('admin_banques_index');
        }

        $conn = $entityManager->getConnection();
        $conn->beginTransaction();

        try {
            $entityManager->createQuery(
                'UPDATE App\Entity\Utilisateur u SET u.banque = NULL WHERE u.banque = :banque'
            )->setParameter('banque', $banque)->execute();

            $entityManager->remove($banque);
            $entityManager->flush();

            $conn->commit();
            $this->addFlash('success', 'La banque a été supprimée (les utilisateurs ont été détachés).');
        } catch (\Throwable $e) {
            $conn->rollBack();
            $entityManager->clear();
            $this->addFlash('error', 'Impossible de supprimer cette banque: ' . $e->getMessage());
        }

        return $this->redirectToRoute('admin_banques_index');
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

        $statut = (string) $request->request->get('statut', '');
        $banque->setStatut($statut);

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
            'statut' => (string) $request->request->get('statut', 'pending'),
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

    private function handleLogoUpload(Banque $banque, Request $request): void
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