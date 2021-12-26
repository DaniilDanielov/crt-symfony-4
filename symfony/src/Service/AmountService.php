<?php

namespace App\Service;


class AmountService
{
    public function calculateAmount($items):? int
    {
        $amount=[];
        foreach ($items as $item)
        {
           $positionCost= $item->getItem()->getPrice();
           $positionCount = $item->getCount();
           $amount[] = $positionCost * $positionCount;
        }
            $totalAmount = array_sum($amount);
            return $totalAmount;

    }
}