<?php

namespace App\Service\FormSubmitHandler;

use App\Entity\Basket;
use App\Entity\Order;
use App\Service\BasketAddController\BasketAddControllerInterface;
use Doctrine\ORM\EntityManagerInterface;
use App\Repository\PizzasRepository;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use App\Service\FormSubmitHandler\FormSubmitHandlerInterface;
class FormSubmitHandlerService implements FormSubmitHandlerInterface
{
        private $basketAddController;
        private $entityManager;
        private $pizzasRepository;
        public function __construct(EntityManagerInterface $entityManager,
                                PizzasRepository $pizzasRepository,
                                SessionInterface $session,
                                BasketAddControllerInterface $basketAddController)
        {
            $this->entityManager = $entityManager;
            $this->pizzasRepository=$pizzasRepository;
            $this->session=$session;
            $this->basketAddController=$basketAddController;
        }

        public function basketFormTypeSubmit ($form): void
        {
            $id=$form->getNormdata()['pizzaId'];
            $count=$form->getNormdata()['count'];
            $pizza = $this->pizzasRepository->findOneBy(['id' => $id]);
            $this->basketAddController->AddtoBasket($count,$id);
            $this->basketAddController->getOrderLink();
        }

        public function orderTypeSubmit ($order): void
        {
            $sessionId = $this->session->getId();
            $order->setStatus(Order::STATUS_NEW_ORDER);
            $order->setSessionId($sessionId);
            $this->entityManager->persist($order);
            $this->entityManager->flush();
            $this->session->migrate();
            $this->session->clear();
        }

        public function basketCountChangerTypeSubmit($pizzaId,$quantity): void
        {
            $sessionId=$this->session->getId();
            $targetBasket = $this->entityManager->getRepository(Basket::class)->findOneBySomeFields($pizzaId, $sessionId);
                $targetBasket->setCount($quantity);
                $this->entityManager->persist($targetBasket);
                $this->entityManager->flush();
        }



}