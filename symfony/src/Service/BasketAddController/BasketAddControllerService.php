<?php

namespace App\Service\BasketAddController;

use App\Entity\Pizzas;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use App\Entity\Basket;
use App\Repository\BasketRepository;
use App\Service\AmountService;

class BasketAddControllerService implements BasketAddControllerInterface
{
    private $basketRepository;
    private $session;
    private $amountService;
    public function __construct(BasketRepository $basketRepository,
                                SessionInterface $session,
                                AmountService $amountService,
                                EntityManagerInterface $em)
    {
        $this->session = $session;
        $this->basketRepository = $basketRepository;
        $this->amountService = $amountService;
        $this->em=$em;
    }

    public function addBasketDataToNavbar(): void
    {
        $items = $this->basketRepository->getBasketItems($this->session);
            $count=count($items);
            $amount=$this->amountService->calculateAmount($items);
            $this->session->set('basketFillUp', $amount);
            $this->session->set('count', $count);
            $this->session->set('amount', $amount);
    }

    public function getOrderLink(): void {
        $this->session->set('orderLink', 'Оформление заказа доступно');
    }

    public function addToBasket($count,$id): void {
        $sessionId=$_COOKIE['PHPSESSID'];
        $pizza = $this->em->getRepository(Pizzas::class)->findOneBy(['id' => $id]);
        $targetBasket = $this->em->getRepository(Basket::class)->findOnePositionByPizzasId($id, $sessionId);
        if (empty($targetBasket)) {
            $basket = (new Basket())
                ->setItem($pizza)
                ->setSessionId($sessionId)
                ->setCount($count);
            $this->em->persist($basket);
            $this->em->flush();
        } else {
            $quantity = $targetBasket->getCount() + $count;
            $targetBasket->setCount($quantity);
            $this->em->persist($targetBasket);
            $this->em->flush();
        }

    }

}