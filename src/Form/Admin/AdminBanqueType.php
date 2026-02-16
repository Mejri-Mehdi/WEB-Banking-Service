<?php

namespace App\Form\Admin;

use App\Entity\Banque;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class AdminBanqueType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('nomBq', TextType::class, [
                'label' => 'Nom de la banque',
            ])
            ->add('emailBq', TextType::class, [
                'label' => 'Email',
                'required' => false,
            ])
            ->add('telephoneBq', TextType::class, [
                'label' => 'Téléphone',
                'required' => false,
            ])
            ->add('siteWeb', TextType::class, [
                'label' => 'Site web',
                'required' => false,
            ])
            ->add('statut', ChoiceType::class, [
                'label' => 'Statut',
                'choices' => [
                    'En attente' => 'pending',
                    'Active' => 'active',
                    'Rejetée' => 'rejected',
                ],
            ])
            ->add('description', TextareaType::class, [
                'label' => 'Description',
                'required' => false,
            ]);
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Banque::class,
        ]);
    }
}