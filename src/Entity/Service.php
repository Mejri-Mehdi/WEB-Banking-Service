<?php

namespace App\Entity;

use App\Repository\ServiceRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;

#[ORM\Entity(repositoryClass: ServiceRepository::class)]
#[ORM\Table(name: 'service')]
class Service
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    #[Assert\NotBlank(message: "Le nom du service est obligatoire.")]
    #[Assert\Length(min: 3, minMessage: "Le nom du service doit contenir au moins 3 caractères.")]
    private ?string $nom_service = null;

    #[ORM\Column(type: Types::TEXT, nullable: true)]
    #[Assert\Length(min: 10, minMessage: "La description doit être plus détaillée.")]
    private ?string $description = null;

    #[ORM\Column(nullable: true)]
    #[Assert\NotBlank(message: "La durée estimée est obligatoire.")]
    #[Assert\Positive(message: "La durée doit être un nombre positif.")]
    private ?int $duree_estimee = null; // Duration in minutes

    #[ORM\Column(length: 20, nullable: true)]
    private ?string $priorite_defaut = 'medium';

    #[ORM\Column(type: Types::TEXT, nullable: true)]
    private ?string $admin_feedback = null;

    #[ORM\Column]
    private ?bool $disponible = true;

    #[ORM\ManyToOne(targetEntity: Banque::class, inversedBy: 'services')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Banque $banque = null;

    #[ORM\OneToMany(mappedBy: 'service', targetEntity: RendezVous::class)]
    private Collection $rendezVous;

    public function __construct()
    {
        $this->rendezVous = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getNomService(): ?string
    {
        return $this->nom_service;
    }

    public function setNomService(string $nom_service): static
    {
        $this->nom_service = $nom_service;
        return $this;
    }

    public function getDescription(): ?string
    {
        return $this->description;
    }

    public function setDescription(?string $description): static
    {
        $this->description = $description;
        return $this;
    }

    public function getDureeEstimee(): ?int
    {
        return $this->duree_estimee;
    }

    public function setDureeEstimee(?int $duree_estimee): static
    {
        $this->duree_estimee = $duree_estimee;
        return $this;
    }

    public function isDisponible(): ?bool
    {
        return $this->disponible;
    }

    public function setDisponible(bool $disponible): static
    {
        $this->disponible = $disponible;
        return $this;
    }

    public function getBanque(): ?Banque
    {
        return $this->banque;
    }

    public function setBanque(?Banque $banque): static
    {
        $this->banque = $banque;
        return $this;
    }

    /**
     * @return Collection<int, RendezVous>
     */
    public function getRendezVous(): Collection
    {
        return $this->rendezVous;
    }

    public function addRendezVous(RendezVous $rendezVous): static
    {
        if (!$this->rendezVous->contains($rendezVous)) {
            $this->rendezVous->add($rendezVous);
            $rendezVous->setService($this);
        }

        return $this;
    }

    public function removeRendezVous(RendezVous $rendezVous): static
    {
        if ($this->rendezVous->removeElement($rendezVous)) {
            if ($rendezVous->getService() === $this) {
                $rendezVous->setService(null);
            }
        }

        return $this;
    }

    public function __toString(): string
    {
        return $this->nom_service ?? '';
    }

    public function getPrioriteDefaut(): ?string
    {
        return $this->priorite_defaut;
    }

    public function setPrioriteDefaut(?string $priorite_defaut): static
    {
        $this->priorite_defaut = $priorite_defaut;
        return $this;
    }

    #[ORM\Column(type: Types::DECIMAL, precision: 10, scale: 2, nullable: true)]
    #[Assert\PositiveOrZero(message: "Les frais doivent être positifs ou nuls.")]
    private ?string $frais = null;

    #[ORM\Column(type: Types::TEXT, nullable: true)]
    #[Assert\NotBlank(message: "Veuillez préciser les documents requis (ou mentionner 'Aucun').")]
    private ?string $documents_requis = null;

    #[ORM\Column(length: 50, nullable: true)]
    #[Assert\NotBlank(message: "La catégorie est obligatoire.")]
    #[Assert\Choice(choices: ['Compte', 'Crédit', 'Epargne', 'Assurance', 'Autre'], message: "Catégorie invalide.")]
    private ?string $categorie = 'Autre';

    public function getFrais(): ?string
    {
        return $this->frais;
    }

    public function setFrais(?string $frais): static
    {
        $this->frais = $frais;
        return $this;
    }

    public function getDocumentsRequis(): ?string
    {
        return $this->documents_requis;
    }

    public function setDocumentsRequis(?string $documents_requis): static
    {
        $this->documents_requis = $documents_requis;
        return $this;
    }

    public function getCategorie(): ?string
    {
        return $this->categorie;
    }

    public function setCategorie(?string $categorie): static
    {
        $this->categorie = $categorie;
        return $this;
    }

    public function getAdminFeedback(): ?string
    {
        return $this->admin_feedback;
    }

    public function setAdminFeedback(?string $admin_feedback): static
    {
        $this->admin_feedback = $admin_feedback;
        return $this;
    }
}
