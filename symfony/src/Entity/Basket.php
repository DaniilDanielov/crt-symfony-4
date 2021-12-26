<?php

namespace App\Entity;

use App\Repository\BasketRepository;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * @ORM\Entity(repositoryClass=BasketRepository::class)
 *  @ORM\HasLifecycleCallbacks()
 */
class Basket
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $sessionId;

    /**
     * @ORM\ManyToOne(targetEntity=Pizzas::class, inversedBy="baskets",fetch="EAGER")
     * @ORM\JoinColumn(nullable=false)
     */
    private $item;

    /**
     * @ORM\Column(type="integer")
     * @Assert\Positive()
     */
    private $count;

    public function __toString(): string
    {
        return $this->id;
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getSessionId(): ?string
    {
        return $this->sessionId;
    }

    public function setSessionId(string $sessionId): self
    {
        $this->sessionId = $sessionId;

        return $this;
    }

    public function getItem(): ?Pizzas
    {
        return $this->item;
    }

    public function setItem(?Pizzas $item): self
    {
        $this->item = $item;

        return $this;
    }

    public function getCount(): ?int
    {
        return $this->count;
    }

    public function setCount(int $count): self
    {
        $this->count = $count;

        return $this;
    }
}
