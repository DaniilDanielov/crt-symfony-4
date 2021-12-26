<?php

namespace App\Service\BasketAddController;

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
                                AmountService $amountService)
    {
        $this->session = $session;
        $this->basketRepository = $basketRepository;
        $this->amountService = $amountService;
    }

    public function AddBasketDataToNavbar()
    {
        $items = $this->basketRepository->getBasketItems($this->session);
            $count=count($items);
            $amount=$this->amountService->calculateAmount($items);
            $this->session->set('basketFillUp', $amount);
            $this->session->set('count', $count);
            $this->session->set('amount', $amount);
    }

    public function getOrderLink() {
        $this->session->set('orderLink', 'Оформление заказа доступно');
    }



}