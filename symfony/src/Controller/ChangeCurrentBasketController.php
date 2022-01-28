<?php

namespace App\Controller;

use App\Entity\Basket;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;

class ChangeCurrentBasketController extends AbstractController
{
    public function __invoke(Basket $basket, Request $request)
    {
        $id=1;
        dump($basket);
        dump($request);
        return $this->basketRepository->findOnePositionByPizzasId($id, $_COOKIE['PHPSESSID']);
    }
}
