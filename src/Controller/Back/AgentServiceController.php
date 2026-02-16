<?php

namespace App\Controller\Back;

use App\Entity\Service;
use App\Repository\ServiceRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/agent/service')]
#[IsGranted('ROLE_AGENT')]
class AgentServiceController extends AbstractController
{
    #[Route('/', name: 'agent_service_index')]
    public function index(Request $request, ServiceRepository $serviceRepository): Response
    {
        $user = $this->getUser();
        $banque = $user->getBanque();

        if (!$banque) {
            $this->addFlash('error', 'Vous devez être associé à une banque.');
            return $this->redirectToRoute('app_home');
        }

        $search = $request->query->get('search');
        $disponible = $request->query->get('disponible');

        $criteria = [
            'banque_id' => $banque->getId(),
            'search' => $search,
            'disponible' => $disponible
        ];

        $services = $serviceRepository->search($criteria);

        if ($request->isXmlHttpRequest()) {
            return $this->render('back/service/_table.html.twig', [
                'services' => $services,
            ]);
        }

        return $this->render('back/service/index.html.twig', [
            'services' => $services,
            'banque' => $banque,
        ]);
    }

    #[Route('/new', name: 'agent_service_new')]
    public function new(Request $request, EntityManagerInterface $entityManager, \Symfony\Component\Validator\Validator\ValidatorInterface $validator): Response
    {
        $user = $this->getUser();
        $banque = $user->getBanque();

        if (!$banque) {
            $this->addFlash('error', 'Vous devez être associé à une banque.');
            return $this->redirectToRoute('app_home');
        }

        if ($request->isMethod('POST')) {
            $service = new Service();
            $service->setBanque($banque);
            $service->setNomService($request->request->get('nom_service'));
            $service->setDescription($request->request->get('description'));
            $service->setDureeEstimee((int)$request->request->get('duree_estimee'));
            $service->setDisponible($request->request->has('disponible'));
            $service->setFrais($request->request->get('frais'));
            $service->setDocumentsRequis($request->request->get('documents_requis'));
            $service->setCategorie($request->request->get('categorie'));
            $service->setPrioriteDefaut($request->request->get('priorite_defaut'));

            $errors = $validator->validate($service);

            if (count($errors) > 0) {
                foreach ($errors as $error) {
                    $this->addFlash('error', $error->getMessage());
                }
            } else {
                try {
                    $entityManager->persist($service);
                    $entityManager->flush();

                    $this->addFlash('success', 'Le service a été créé avec succès.');
                    return $this->redirectToRoute('agent_service_index');
                } catch (\Exception $e) {
                    $this->addFlash('error', 'Une erreur s\'est produite: ' . $e->getMessage());
                }
            }
        }

        return $this->render('back/service/new.html.twig', [
            'banque' => $banque,
        ]);
    }

    #[Route('/edit/{id}', name: 'agent_service_edit')]
    public function edit(Service $service, Request $request, EntityManagerInterface $entityManager, \Symfony\Component\Validator\Validator\ValidatorInterface $validator): Response
    {
        // Ensure the service belongs to the agent's bank
        if ($service->getBanque() !== $this->getUser()->getBanque()) {
            throw $this->createAccessDeniedException();
        }

        if ($request->isMethod('POST')) {
            $service->setNomService($request->request->get('nom_service'));
            $service->setDescription($request->request->get('description'));
            $service->setDureeEstimee((int)$request->request->get('duree_estimee'));
            $service->setDisponible($request->request->has('disponible'));
            $service->setFrais($request->request->get('frais'));
            $service->setDocumentsRequis($request->request->get('documents_requis'));
            $service->setCategorie($request->request->get('categorie'));
            $service->setPrioriteDefaut($request->request->get('priorite_defaut'));

            $errors = $validator->validate($service);

            if (count($errors) > 0) {
                foreach ($errors as $error) {
                    $this->addFlash('error', $error->getMessage());
                }
            } else {
                try {
                    $entityManager->flush();
                    $this->addFlash('success', 'Le service a été modifié avec succès.');
                    return $this->redirectToRoute('agent_service_index');
                } catch (\Exception $e) {
                    $this->addFlash('error', 'Une erreur s\'est produite: ' . $e->getMessage());
                }
            }
        }

        return $this->render('back/service/edit.html.twig', [
            'service' => $service,
        ]);
    }

    #[Route('/delete/{id}', name: 'agent_service_delete', methods: ['POST'])]
    public function delete(Service $service, EntityManagerInterface $entityManager): Response
    {
        // Ensure the service belongs to the agent's bank
        if ($service->getBanque() !== $this->getUser()->getBanque()) {
            throw $this->createAccessDeniedException();
        }

        try {
            $entityManager->remove($service);
            $entityManager->flush();
            $this->addFlash('success', 'Le service a été supprimé avec succès.');
        } catch (\Exception $e) {
            $this->addFlash('error', 'Impossible de supprimer ce service: ' . $e->getMessage());
        }

        return $this->redirectToRoute('agent_service_index');
    }
}
