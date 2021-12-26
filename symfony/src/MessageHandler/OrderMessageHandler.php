<?php

namespace App\MessageHandler;

use Symfony\Component\Messenger\Handler\MessageHandlerInterface;
use App\Message\OrderMessage;
use Doctrine\ORM\EntityManagerInterface;
use App\Repository\OrderRepository;
class OrderMessageHandler implements MessageHandlerInterface
{
    public function __construct(EntityManagerInterface $entityManager, OrderRepository $orderRepository)
    {
        $this->orderRepository=$orderRepository;
       $this->entityManager=$entityManager;
    }

    public function __invoke(OrderMessage $orderMessage)
    {
        $order=$this->orderRepository->find($orderMessage->getId());
        if(!$order) {
            return;
        }
        $userName=$order->getUsername();
        $userPhone=$order->getUserPhone();
        $UserAddress=$order->getUserAddress();
        $message='Тут я отправляю сообщение с даннными через RabbitMQ'.' Имя пользователя '.$userName.' Телефон '.$userPhone.' Адрес '.$UserAddress;
    }

}