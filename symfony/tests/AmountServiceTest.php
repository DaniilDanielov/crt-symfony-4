<?php
namespace App\Test;

use App\Entity\Basket;
use App\Entity\Pizzas;
use PHPUnit\Framework\TestCase;
use App\Service\AmountService;
use PHPUnit\Framework\DataProviderTestSuite;
class AmountServiceTest extends TestCase
{
/*    public function AmountServiceTestingDataProvider():array
    {
        return [
            'normal items'=>[
                '0'=>['item'=>['price'=>'564',],'count'=>'1'],

            ]



        ];
    }*/


    /**
     * @test
     *
     */

    public function AmountServiceTesting($items)
    {
        // Position Count
        $amountService = new AmountService();
        $stub=$this->createMock(Basket::class);
        $pizza=$this->createMock(Pizzas::class);
        $stub->method(getCount())
            ->willReturn(2);
        $stub->method(getItem())
            ->willReturn($pizza->method(getPrice())->willReturn(500));
        $totalprice=$amountService->calculateAmount($items);
        $this->assertEquals(1000,$totalprice);




    }


}