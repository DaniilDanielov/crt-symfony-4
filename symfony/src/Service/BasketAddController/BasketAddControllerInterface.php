<?php
namespace App\Service\BasketAddController;

interface BasketAddControllerInterface

{
    public function addBasketDataToNavbar(): void;

    public function getOrderLink(): void;

    public function addToBasket($count,$id): void;
}


