<?php

namespace App\Entity;

use App\Repository\AgenceRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;

#[ORM\Entity(repositoryClass: AgenceRepository::class)]
#[ORM\Table(name: 'agence')]
class Agence
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    #[Assert\NotBlank(message: "Le nom de l'agence est obligatoire.")]
    #[Assert\Length(
        min: 2,
        max: 100,
        minMessage: "Le nom de l'agence doit contenir au moins {{ limit }} caractères.",
        maxMessage: "Le nom de l'agence ne peut pas dépasser {{ limit }} caractères."
    )]
    #[Assert\Regex(
        pattern: "/^[\p{L}\p{M}0-9 ]+$/u",
        message: "Le nom de l'agence ne peut contenir que des lettres, des chiffres et des espaces."
    )]
    private ?string $nom_ag = null;

    #[ORM\Column(type: Types::TEXT, nullable: true)]
    #[Assert\NotBlank(message: "L'adresse de l'agence est obligatoire.")]
    #[Assert\Length(
        min: 3,
        max: 150,
        minMessage: "L'adresse doit contenir au moins {{ limit }} caractères.",
        maxMessage: "L'adresse ne peut pas dépasser {{ limit }} caractères."
    )]
    private ?string $adresse_ag = null;

    #[ORM\Column(length: 20, nullable: true)]
    #[Assert\NotBlank(message: "Le numéro de téléphone est obligatoire.")]
    #[Assert\Length(
        min: 8,
        max: 15,
        minMessage: "Le numéro de téléphone doit contenir au moins {{ limit }} caractères.",
        maxMessage: "Le numéro de téléphone ne peut pas dépasser {{ limit }} caractères (espaces inclus)."
    )]
    #[Assert\Regex(
        pattern: "/^\+?[0-9 ]+$/",
        message: "Numéro invalide: utilisez uniquement des chiffres, des espaces, et éventuellement un + au début."
    )]
    private ?string $telephone = null;

    #[ORM\Column(length: 255, nullable: true)]
    #[Assert\NotBlank(message: "L'email est obligatoire.")]
    #[Assert\Length(
        min: 5,
        max: 100,
        minMessage: "L'email doit contenir au moins {{ limit }} caractères.",
        maxMessage: "L'email ne peut pas dépasser {{ limit }} caractères."
    )]
    #[Assert\Email(message: "L'email n'est pas valide (ex: contact@banque.tn).")]
    private ?string $email = null;

    #[ORM\Column(type: Types::TEXT, nullable: true)]
    #[Assert\Length(
        max: 150,
        maxMessage: "Les horaires ne peuvent pas dépasser {{ limit }} caractères."
    )]
    private ?string $horaires = null;

    #[ORM\Column(type: Types::INTEGER, options: ['default' => 3])]
    #[Assert\Positive(message: "Le nombre de guichets doit être positif.")]
    private ?int $nombre_guichets = 3;

    #[ORM\ManyToOne(targetEntity: Banque::class, inversedBy: 'agences')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Banque $banque = null;

    #[ORM\OneToMany(mappedBy: 'agence', targetEntity: RendezVous::class)]
    private Collection $rendezVous;

    public function __construct()
    {
        $this->rendezVous = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getNomAg(): ?string
    {
        return $this->nom_ag;
    }

    /**
     * IMPORTANT:
     * On accepte null pour que le Form puisse hydrater l'entité même si champ vidé.
     * Les Assert se chargent ensuite de dire "vide interdit".
     */
    public function setNomAg(?string $nom_ag): static
    {
        $this->nom_ag = $nom_ag;
        return $this;
    }

    public function getAdresseAg(): ?string
    {
        return $this->adresse_ag;
    }

    public function setAdresseAg(?string $adresse_ag): static
    {
        $this->adresse_ag = $adresse_ag;
        return $this;
    }

    public function getTelephone(): ?string
    {
        return $this->telephone;
    }

    public function setTelephone(?string $telephone): static
    {
        $this->telephone = $telephone;
        return $this;
    }

    public function getEmail(): ?string
    {
        return $this->email;
    }

    public function setEmail(?string $email): static
    {
        $this->email = $email;
        return $this;
    }

    public function getHoraires(): ?string
    {
        return $this->horaires;
    }

    public function setHoraires(?string $horaires): static
    {
        $this->horaires = $horaires;
        return $this;
    }

    public function getNombreGuichets(): ?int
    {
        return $this->nombre_guichets;
    }

    public function setNombreGuichets(int $nombre_guichets): static
    {
        $this->nombre_guichets = $nombre_guichets;
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
            $rendezVous->setAgence($this);
        }

        return $this;
    }

    public function removeRendezVous(RendezVous $rendezVous): static
    {
        if ($this->rendezVous->removeElement($rendezVous)) {
            if ($rendezVous->getAgence() === $this) {
                $rendezVous->setAgence(null);
            }
        }

        return $this;
    }

    public function __toString(): string
    {
        return $this->nom_ag ?? '';
    }
}