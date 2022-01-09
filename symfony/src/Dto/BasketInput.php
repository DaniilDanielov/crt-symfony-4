<?php

namespace App\Dto;


final class BasketInput
{

    private array $pizzasId;

    /**
     * @return array
     */
    public function getPizzasId(): array
    {
        return $this->pizzasId;
    }

    /**
     * @param array $item
     */
    public function setPizzasId(array $pizzasId): void
    {
        $this->pizzasId = $pizzasId;
    }


}