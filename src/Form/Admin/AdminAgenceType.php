<?php

namespace App\Form\Admin;

use App\Entity\Agence;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\EmailType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class AdminAgenceType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('nomAg', TextType::class, [
                'label' => 'Nom de l’agence',
            ])
            ->add('adresseAg', TextareaType::class, [
                'label' => 'Adresse',
                'required' => false,
            ])
            ->add('telephone', TextType::class, [
                'label' => 'Téléphone',
                'required' => false,
            ])
            ->add('email', EmailType::class, [
                'label' => 'Email',
                'required' => false,
            ])
            ->add('horaires', TextareaType::class, [
                'label' => 'Horaires',
                'required' => false,
            ]);
        // banque injectée dans le controller
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Agence::class,
        ]);
    }
}