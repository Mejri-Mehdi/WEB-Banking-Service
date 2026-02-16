<?php

namespace App\Entity;

use App\Repository\BanqueRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Component\Validator\Constraints as Assert;

#[ORM\Entity(repositoryClass: BanqueRepository::class)]
#[ORM\Table(name: 'banque')]
class Banque
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    #[Assert\NotBlank(message: "Le nom de la banque est obligatoire.")]
    #[Assert\Length(
        min: 4,
        max: 100,
        minMessage: "Le nom de la banque doit contenir au moins {{ limit }} caractères.",
        maxMessage: "Le nom de la banque ne peut pas dépasser {{ limit }} caractères."
    )]
    #[Assert\Regex(
        pattern: "/^[\p{L}\p{M}0-9 ]+$/u",
        message: "Le nom de la banque ne peut contenir que des lettres, des chiffres et des espaces (pas de caractères spéciaux)."
    )]
    private ?string $nom_bq = null;

    #[ORM\Column(length: 255, nullable: true)]
    #[Assert\NotBlank(message: "Le site web est obligatoire.")]
    #[Assert\Length(
        min: 10,
        max: 150,
        minMessage: "Le site web doit contenir au moins {{ limit }} caractères.",
        maxMessage: "Le site web ne peut pas dépasser {{ limit }} caractères."
    )]
    #[Assert\Regex(
        pattern: "/^[A-Za-z0-9\/:\.\-_]+$/",
        message: "Le site web ne peut contenir que des lettres, chiffres et uniquement ces caractères: / : . - _ (sans espaces)."
    )]
    private ?string $site_web = null;

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
        message: "Le numéro de téléphone est invalide: utilisez uniquement des chiffres, des espaces, et éventuellement un + au début."
    )]
    private ?string $telephone_bq = null;

    #[ORM\Column(length: 255, nullable: true)]
    #[Assert\NotBlank(message: "L'email est obligatoire.")]
    #[Assert\Length(
        min: 5,
        max: 100,
        minMessage: "L'email doit contenir au moins {{ limit }} caractères.",
        maxMessage: "L'email ne peut pas dépasser {{ limit }} caractères."
    )]
    #[Assert\Email(message: "L'email n'est pas valide (ex: contact@banque.tn).")]
    private ?string $email_bq = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $logo = null;

    /**
     * Fichier uploadé (non persisté en DB).
     * Obligatoire en ajout ET en modification, selon tes règles.
     */
    #[Assert\NotNull(message: "Le logo est obligatoire. Veuillez uploader un fichier.")]
    #[Assert\File(
        maxSize: "2M",
        maxSizeMessage: "Le logo ne doit pas dépasser 2MB.",
        mimeTypes: [
            "image/png",
            "image/jpeg",
            "image/webp",
            "image/svg+xml"
        ],
        mimeTypesMessage: "Format de logo invalide. Formats acceptés: PNG, JPG/JPEG, WEBP, SVG."
    )]
    private ?UploadedFile $logoFile = null;

    #[ORM\Column(length: 20)]
    #[Assert\NotBlank(message: "Le statut est obligatoire.")]
    #[Assert\Choice(
        choices: ["pending", "active", "rejected"],
        message: "Statut invalide. Choisissez: En attente, Active, ou Rejetée."
    )]
    private ?string $statut = 'pending'; // pending, active, rejected

    #[ORM\Column(type: Types::TEXT, nullable: true)]
    #[Assert\Length(
        max: 500,
        maxMessage: "La description ne peut pas dépasser {{ limit }} caractères."
    )]
    private ?string $description = null;

    #[ORM\OneToMany(mappedBy: 'banque', targetEntity: Agence::class, orphanRemoval: true, cascade: ['persist', 'remove'])]
    private Collection $agences;

    #[ORM\OneToMany(mappedBy: 'banque', targetEntity: Utilisateur::class)]
    private Collection $utilisateurs;

    #[ORM\OneToMany(mappedBy: 'banque', targetEntity: Service::class, orphanRemoval: true, cascade: ['persist', 'remove'])]
    private Collection $services;

    #[ORM\OneToMany(mappedBy: 'banque', targetEntity: Offre::class, orphanRemoval: true, cascade: ['persist', 'remove'])]
    private Collection $offres;

    #[ORM\OneToMany(mappedBy: 'banque', targetEntity: RendezVous::class, orphanRemoval: true)]
    private Collection $rendezVous;

    #[ORM\OneToMany(mappedBy: 'banque', targetEntity: Financement::class, orphanRemoval: true)]
    private Collection $financements;

    public function __construct()
    {
        $this->agences = new ArrayCollection();
        $this->utilisateurs = new ArrayCollection();
        $this->services = new ArrayCollection();
        $this->offres = new ArrayCollection();
        $this->rendezVous = new ArrayCollection();
        $this->financements = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getNomBq(): ?string
    {
        return $this->nom_bq;
    }

    public function setNomBq(string $nom_bq): static
    {
        $this->nom_bq = $nom_bq;
        return $this;
    }

    public function getSiteWeb(): ?string
    {
        return $this->site_web;
    }

    public function setSiteWeb(?string $site_web): static
    {
        $this->site_web = $site_web;
        return $this;
    }

    public function getTelephoneBq(): ?string
    {
        return $this->telephone_bq;
    }

    public function setTelephoneBq(?string $telephone_bq): static
    {
        $this->telephone_bq = $telephone_bq;
        return $this;
    }

    public function getEmailBq(): ?string
    {
        return $this->email_bq;
    }

    public function setEmailBq(?string $email_bq): static
    {
        $this->email_bq = $email_bq;
        return $this;
    }

    public function getLogo(): ?string
    {
        return $this->logo;
    }

    public function setLogo(?string $logo): static
    {
        $this->logo = $logo;
        return $this;
    }

    public function getLogoFile(): ?UploadedFile
    {
        return $this->logoFile;
    }

    public function setLogoFile(?UploadedFile $logoFile): static
    {
        $this->logoFile = $logoFile;
        return $this;
    }

    public function getStatut(): ?string
    {
        return $this->statut;
    }

    public function setStatut(string $statut): static
    {
        $this->statut = $statut;
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

    /**
     * @return Collection<int, Agence>
     */
    public function getAgences(): Collection
    {
        return $this->agences;
    }

    public function addAgence(Agence $agence): static
    {
        if (!$this->agences->contains($agence)) {
            $this->agences->add($agence);
            $agence->setBanque($this);
        }

        return $this;
    }

    public function removeAgence(Agence $agence): static
    {
        if ($this->agences->removeElement($agence)) {
            if ($agence->getBanque() === $this) {
                $agence->setBanque(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Utilisateur>
     */
    public function getUtilisateurs(): Collection
    {
        return $this->utilisateurs;
    }

    public function addUtilisateur(Utilisateur $utilisateur): static
    {
        if (!$this->utilisateurs->contains($utilisateur)) {
            $this->utilisateurs->add($utilisateur);
            $utilisateur->setBanque($this);
        }

        return $this;
    }

    public function removeUtilisateur(Utilisateur $utilisateur): static
    {
        if ($this->utilisateurs->removeElement($utilisateur)) {
            if ($utilisateur->getBanque() === $this) {
                $utilisateur->setBanque(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Service>
     */
    public function getServices(): Collection
    {
        return $this->services;
    }

    public function addService(Service $service): static
    {
        if (!$this->services->contains($service)) {
            $this->services->add($service);
            $service->setBanque($this);
        }

        return $this;
    }

    public function removeService(Service $service): static
    {
        if ($this->services->removeElement($service)) {
            if ($service->getBanque() === $this) {
                $service->setBanque(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Offre>
     */
    public function getOffres(): Collection
    {
        return $this->offres;
    }

    public function addOffre(Offre $offre): static
    {
        if (!$this->offres->contains($offre)) {
            $this->offres->add($offre);
            $offre->setBanque($this);
        }

        return $this;
    }

    public function removeOffre(Offre $offre): static
    {
        if ($this->offres->removeElement($offre)) {
            if ($offre->getBanque() === $this) {
                $offre->setBanque(null);
            }
        }

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
            $rendezVous->setBanque($this);
        }

        return $this;
    }

    public function removeRendezVous(RendezVous $rendezVous): static
    {
        if ($this->rendezVous->removeElement($rendezVous)) {
            if ($rendezVous->getBanque() === $this) {
                $rendezVous->setBanque(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Financement>
     */
    public function getFinancements(): Collection
    {
        return $this->financements;
    }

    public function addFinancement(Financement $financement): static
    {
        if (!$this->financements->contains($financement)) {
            $this->financements->add($financement);
            $financement->setBanque($this);
        }

        return $this;
    }

    public function removeFinancement(Financement $financement): static
    {
        if ($this->financements->removeElement($financement)) {
            if ($financement->getBanque() === $this) {
                $financement->setBanque(null);
            }
        }

        return $this;
    }

    public function __toString(): string
    {
        return $this->nom_bq ?? '';
    }
}