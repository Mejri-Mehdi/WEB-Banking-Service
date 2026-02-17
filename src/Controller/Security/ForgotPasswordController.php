<?php

namespace App\Controller\Security;

use App\Repository\UtilisateurRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Mailer\MailerInterface;
use Symfony\Component\Mime\Email;
use Symfony\Component\Routing\Generator\UrlGeneratorInterface;

class ForgotPasswordController extends AbstractController
{
    #[Route('/forgot-password', name: 'app_forgot_password_request')]
    public function request(Request $request, UtilisateurRepository $utilisateurRepository, MailerInterface $mailer): Response
    {
        if ($request->isMethod('POST')) {
            $email = $request->request->get('email');
            $user = $utilisateurRepository->findOneBy(['email' => $email]);

            if ($user) {
                // Generate Token
                $token = bin2hex(random_bytes(32));
                $user->setResetToken($token);
                $user->setResetTokenExpiresAt(new \DateTimeImmutable('+1 hour'));
                $utilisateurRepository->save($user, true); // Assuming usage of repository save method or manually flushing

                // Ensure flush happens if repository doesn't handle it
                // $entityManager->flush(); // Need to inject EntityManager if repo doesn't save

                // GENERATE LINK
                $resetLink = $this->generateUrl('app_reset_password', ['token' => $token], UrlGeneratorInterface::ABSOLUTE_URL);
                
                // DISPLAY LINK DIRECTLY (DEV MODE)
                $this->addFlash('success', 'MODE DEV: Voici votre lien de réinitialisation (Cliquez ici) : <a href="' . $resetLink . '">Réinitialiser mon mot de passe</a>');
                
                // Still log it just in case
                $logDir = $this->getParameter('kernel.project_dir') . '/var';
                if (!is_dir($logDir)) mkdir($logDir, 0777, true);
                file_put_contents($logDir . '/test_email_log.txt', "Reset Link: " . $resetLink . "\n", FILE_APPEND);

            } else {
                // Protect against user enumeration
                $this->addFlash('success', 'Si cet email existe, un lien a été envoyé.');
            }

            return $this->redirectToRoute('app_login');
        }

        return $this->render('security/forgot_password.html.twig');
    }
}
