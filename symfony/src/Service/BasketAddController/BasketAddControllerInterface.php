<?php
namespace App\Service\BasketAddController;

interface BasketAddControllerInterface

{
    public function AddBasketDataToNavbar(): void;

    public function getOrderLink(): void;

    public function AddtoBasket($count,$id): void;
}


