<?php

namespace App\Entity;

use ApiPlatform\Core\Annotation\ApiResource;
use App\Dto\BasketInput;
use App\Repository\BasketRepository;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;
use App\Dto\BasketPutInput;

/**
 * @ORM\Entity(repositoryClass=BasketRepository::class)
 *  @ORM\HasLifecycleCallbacks()
 */
#[ApiResource(
    collectionOperations: ['post'=>['path'=>'/addToCurrentBasket','input'=> BasketInput::class,
        'openapi_context'=>['summary'=>'Добавление списка пицц в корзину']]
        ,'get'=>['path'=>'/getCurrentBasket','openapi_context'=>['summary'=>'Получение всех позиций корзины']]],
    itemOperations: ['get',
        'put'=>['input'=>BasketPutInput::class,'openapi_context'=>['summary'=>'Изменение количества пиццы по ID Пиццы']],
        'delete'=>['openapi_context'=>['summary'=>'Удаление пиццы из Корзины по ID Пиццы']]],
    attributes: ["security" => "is_granted('IS_AUTHENTICATED_FULLY')"],
    )]

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

    private string $sessionId;

    /**
     * @ORM\ManyToOne(targetEntity=Pizzas::class, inversedBy="baskets",fetch="EAGER")
     * @ORM\JoinColumn(nullable=false)
     */
    private $item;

    /**
     * @ORM\Column(type="integer")
     * @Assert\Positive()
     */
    private int $count;

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
