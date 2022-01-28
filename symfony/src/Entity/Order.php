<?php

namespace App\Entity;

use ApiPlatform\Core\Annotation\ApiResource;
use App\Repository\OrderRepository;
use Doctrine\ORM\Mapping as ORM;
use phpDocumentor\Reflection\Types\Integer;

/**
 * @ORM\Entity(repositoryClass=OrderRepository::class)
 * @ORM\Table(name="`order`")
 */
class Order
{
    public const STATUS_NEW_ORDER = 1;
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private string $sessionId;

    /**
     * @ORM\Column(type="integer")
     */
    private int $status = 1;

    private string $state="draft";

    /**
     * @return string
     */


    /**
     * @ORM\Column(type="string", length=255)
     */
    private ?string $username;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private ?string $userPhone;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private ?string $UserAddress;

    public function __toString(): string
    {
        return $this->username;
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

    public function getStatus(): ?int
    {
        return $this->status;
    }

    public function setStatus(int $status): self
    {
        $this->status = $status;

        return $this;
    }

    public function getUsername(): ?string
    {
        return $this->username;
    }

    public function setUsername(string $username): self
    {
        $this->username = $username;

        return $this;
    }

    public function getUserPhone(): ?string
    {
        return $this->userPhone;
    }

    public function setUserPhone(string $userPhone): self
    {
        $this->userPhone = $userPhone;

        return $this;
    }

    public function getUserAddress(): ?string
    {
        return $this->UserAddress;
    }

    public function setUserAddress(string $UserAddress): self
    {
        $this->UserAddress = $UserAddress;

        return $this;
    }
    public function getState(): string
    {
        return $this->state;
    }

    /**
     * @param string $state
     */
    public function setState(string $state,$context= []): void
    {
        $this->state = $state;
    }
}
