<?php

namespace App\Controller\Back;

use App\Entity\Agence;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Form\Extension\Core\Type\EmailType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/agent/agences')]
#[IsGranted('ROLE_AGENT')]
class AgentAgenceController extends AbstractController
{
    #[Route('/new', name: 'agent_agence_new', methods: ['GET', 'POST'])]
    public function new(Request $request, EntityManagerInterface $em): Response
    {
        $banque = $this->getUser()?->getBanque();
        if (!$banque) {
            $this->addFlash('error', 'Vous devez être associé à une banque.');
            return $this->redirectToRoute('app_home');
        }

        $agence = new Agence();
        $agence->setBanque($banque);

        $form = $this->buildAgenceForm($agence);

        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid()) {
            $em->persist($agence);
            $em->flush();

            $this->addFlash('success', 'Agence créée avec succès.');
            return $this->redirectToRoute('agent_banque_view');
        }

        return $this->render('back/agence/new.html.twig', [
            'banque' => $banque,
            'form' => $form->createView(),
        ]);
    }

    #[Route('/{id}', name: 'agent_agence_view', requirements: ['id' => '\d+'], methods: ['GET'])]
    public function view(Agence $agence): Response
    {
        $this->denyAccessUnlessAgenceBelongsToAgentBank($agence);

        return $this->render('back/agence/view.html.twig', [
            'agence' => $agence,
        ]);
    }

    #[Route('/{id}/edit', name: 'agent_agence_edit', requirements: ['id' => '\d+'], methods: ['GET', 'POST'])]
    public function edit(Agence $agence, Request $request, EntityManagerInterface $em): Response
    {
        $this->denyAccessUnlessAgenceBelongsToAgentBank($agence);

        $form = $this->buildAgenceForm($agence);

        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid()) {
            $em->flush();

            $this->addFlash('success', 'Agence modifiée avec succès.');
            return $this->redirectToRoute('agent_agence_view', ['id' => $agence->getId()]);
        }

        return $this->render('back/agence/edit.html.twig', [
            'agence' => $agence,
            'form' => $form->createView(),
        ]);
    }

    #[Route('/{id}/delete', name: 'agent_agence_delete', requirements: ['id' => '\d+'], methods: ['POST'])]
    public function delete(Agence $agence, Request $request, EntityManagerInterface $em): Response
    {
        $this->denyAccessUnlessAgenceBelongsToAgentBank($agence);

        $token = (string) $request->request->get('_token', '');
        if (!$this->isCsrfTokenValid('agent_agence_delete_' . $agence->getId(), $token)) {
            $this->addFlash('error', 'Token CSRF invalide.');
            return $this->redirectToRoute('agent_banque_view');
        }

        $em->remove($agence);
        $em->flush();

        $this->addFlash('success', 'Agence supprimée avec succès.');
        return $this->redirectToRoute('agent_banque_view');
    }

    private function denyAccessUnlessAgenceBelongsToAgentBank(Agence $agence): void
    {
        $banque = $this->getUser()?->getBanque();
        if (!$banque || $agence->getBanque()?->getId() !== $banque->getId()) {
            throw $this->createAccessDeniedException();
        }
    }

    private function buildAgenceForm(Agence $agence)
    {
        // IMPORTANT: comme admin
        // - champs = propriétés validées (nom_ag, adresse_ag, ...)
        // - required=false pour éviter HTML5
        // - validation = Assert dans l'entité Agence
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