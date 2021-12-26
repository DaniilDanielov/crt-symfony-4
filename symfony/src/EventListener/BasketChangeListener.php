<?php

namespace App\EventListener;

use App\Entity\Basket;
use App\Service\AmountService;
use Doctrine\Persistence\Event\LifecycleEventArgs;
use App\Repository\BasketRepository;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use App\Service\BasketAddController\BasketAddControllerInterface;
class BasketChangeListener
{
    private $basketRepository;
    private $session;
    private $amountService;
    private $basketAddController;
    public function __construct(BasketRepository $basketRepository,
                                SessionInterface $session,
                                AmountService $amountService,
                                BasketAddControllerInterface $basketAddController)
    {
        $this->session = $session;
        $this->basketRepository = $basketRepository;
        $this->amountService = $amountService;
        $this->basketAddController=$basketAddController;
    }

    public function PostLoad(LifecycleEventArgs $args)
    {
        $items = $this->basketRepository->getBasketItems($this->session);
        $entity = $args->getObject();
        if ($entity instanceof Basket) {
            $this->basketAddController->AddBasketDataToNavbar();
        }
    }
}