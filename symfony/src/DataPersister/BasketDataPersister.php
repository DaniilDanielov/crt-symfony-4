<?php

namespace App\DataPersister;

use ApiPlatform\Core\DataPersister\ContextAwareDataPersisterInterface;
use App\Entity\Basket;
use App\Service\BasketAddController\BasketAddControllerInterface;
use Doctrine\ORM\EntityManagerInterface;

final class BasketDataPersister implements ContextAwareDataPersisterInterface
{

    public function __construct(EntityManagerInterface $em,BasketAddControllerInterface $basketAddController)
    {
        $this->em=$em;
        $this->basketAddController=$basketAddController;
    }


    public function supports($data, array $context = []): bool
    {
        return $data instanceof Basket;
    }


    public function persist($data, array $context = [])
    {
        $this->em->persist($data);
        $this->em->flush();
        return $data;
    }


    public function remove($data, array $context = [])
    {
        dump($data);
        if ($data instanceof Basket)
        {
        $this->em->remove($data);
        $this->em->flush();
        }
        return $data;
    }
}