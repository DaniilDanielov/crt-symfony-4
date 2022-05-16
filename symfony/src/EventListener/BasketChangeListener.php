<?php

namespace App\EventListener;

use App\Entity\Basket;
use Doctrine\Persistence\Event\LifecycleEventArgs;
use App\Repository\BasketRepository;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use App\Service\BasketAddController\BasketAddControllerInterface;

class BasketChangeListener
{
    public function __construct(
        private BasketRepository $basketRepository,
        private SessionInterface $session,
        private BasketAddControllerInterface $basketAddController
    )
    {
    }

    public function PostLoad(LifecycleEventArgs $args)
    {
        $items = $this->basketRepository->getBasketItems($this->session);
        $entity = $args->getObject();
        if ($entity instanceof Basket) {
            $this->basketAddController->addBasketDataToNavbar();
        }
    }
}
