<?php

namespace App\Tests;

use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;

class MainControllerTest extends WebTestCase
{
    public function testMainPage(): void
    {
        $client = static::createClient();
        $crawler = $client->request('GET', '/');

        $this->assertResponseIsSuccessful();
        $this->assertSelectorTextContains('h2', 'Каталог пиццы');
    }


    public function testBasketPage(): void
    {
        $client = static::createClient();
        $crawler = $client->request('GET', '/basket');

        $this->assertResponseIsSuccessful();
        $this->assertSelectorTextContains('h2', 'Корзина');
    }

    public function testApi(): void
    {
        $client = static::createClient();
        $crawler = $client->request('GET', '/api/pizzas');
        $this->assertResponseIsSuccessful();
        $this->assertResponseStatusCodeSame(200);
    }



}
