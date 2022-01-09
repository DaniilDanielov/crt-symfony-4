<?php

namespace App\Dto;


final class BasketPutInput
{

    private int $count;
    /**
     * @return int
     */

    /**
     * @return int
     */
    public function getCount(): int
    {
        return $this->count;
    }

    /**
     * @param int $count
     */
    public function setCount(int $count): void
    {
        $this->count = $count;
    }


}