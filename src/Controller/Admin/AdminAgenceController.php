<?php

namespace App\Controller\Admin;

use App\Entity\Agence;
use App\Entity\Banque;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Form\Extension\Core\Type\EmailType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/admin/banques')]
#[IsGranted('ROLE_ADMIN')]
class AdminAgenceController extends AbstractController
{
    #[Route('/{banque<\d+>}/agence/new', name: 'admin_banque_agence_new', methods: ['GET', 'POST'])]
    public function new(Banque $banque, Request $request, EntityManagerInterface $em): Response
    {
        $agence = new Agence();
        $agence->setBanque($banque);

        $form = $this->buildAgenceForm($agence);

        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid()) {
            $em->persist($agence);
            $em->flush();

            $this->addFlash('success', 'Agence ajoutée.');
            return $this->redirectToRoute('admin_banques_index', ['banque' => $banque->getId()]);
        }

        return $this->render('admin/agence/new.html.twig', [
            'banque' => $banque,
            'form' => $form->createView(),
        ]);
    }

    #[Route('/{banque<\d+>}/agence/{agence<\d+>}', name: 'admin_banque_agence_show', methods: ['GET'])]
    public function show(Banque $banque, Agence $agence): Response
    {
        $this->assertAgenceBelongsToBanque($banque, $agence);

        return $this->render('admin/agence/show.html.twig', [
            'banque' => $banque,
            'agence' => $agence,
        ]);
    }

    #[Route('/{banque<\d+>}/agence/{agence<\d+>}/edit', name: 'admin_banque_agence_edit', methods: ['GET', 'POST'])]
    public function edit(Banque $banque, Agence $agence, Request $request, EntityManagerInterface $em): Response
    {
        $this->assertAgenceBelongsToBanque($banque, $agence);

        $form = $this->buildAgenceForm($agence);

        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid()) {
            $em->flush();

            $this->addFlash('success', 'Agence modifiée.');
            return $this->redirectToRoute('admin_banques_index', ['banque' => $banque->getId()]);
        }

        return $this->render('admin/agence/edit.html.twig', [
            'banque' => $banque,
            'agence' => $agence,
            'form' => $form->createView(),
        ]);
    }

    #[Route('/{banque<\d+>}/agence/{agence<\d+>}/delete', name: 'admin_banque_agence_delete', methods: ['POST'])]
    public function delete(Banque $banque, Agence $agence, Request $request, EntityManagerInterface $em): Response
    {
        $this->assertAgenceBelongsToBanque($banque, $agence);

        $token = (string) $request->request->get('_token', '');
        if (!$this->isCsrfTokenValid('delete_agence_' . $agence->getId(), $token)) {
            $this->addFlash('error', 'Token CSRF invalide.');
            return $this->redirectToRoute('admin_banques_index', ['banque' => $banque->getId()]);
        }

        try {
            $em->remove($agence);
            $em->flush();
            $this->addFlash('success', 'Agence supprimée.');
        } catch (\Throwable $e) {
            $this->addFlash('error', 'Impossible de supprimer cette agence: ' . $e->getMessage());
        }

        return $this->redirectToRoute('admin_banques_index', ['banque' => $banque->getId()]);
    }

    private function assertAgenceBelongsToBanque(Banque $banque, Agence $agence): void
    {
        if ($agence->getBanque() === null || $agence->getBanque()->getId() !== $banque->getId()) {
            throw $this->createNotFoundException("Agence introuvable pour cette banque.");
        }
    }

    private function buildAgenceForm(Agence $agence)
    {
        // IMPORTANT:
        // - champs nommés comme les PROPRIÉTÉS validées (nom_ag, adresse_ag, etc.)
        // - required=false pour éviter HTML5
        // - validation = Assert via Entity
        return $this->createFormBuilder($agence)
            ->add('nom_ag', TextType::class, [
                'label' => "Nom de l'agence",
                'required' => false,
            ])
            ->add('telephone', TextType::class, [
                'label' => "Téléphone",
                'required' => false,
            ])
            ->add('email', EmailType::class, [
                'label' => "Email",
                'required' => false,
            ])
            ->add('adresse_ag', TextareaType::class, [
                'label' => "Adresse",
                'required' => false,
                'attr' => ['rows' => 3],
            ])
            ->add('horaires', TextareaType::class, [
                'label' => "Horaires",
                'required' => false,
                'attr' => ['rows' => 3],
            ])
            ->getForm();
    }
}