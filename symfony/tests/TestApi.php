<?php
namespace App\Tests;

final class TestApi extends AbstractTest
{
    public function getAllPizzasTest():void
    {
        $response = $this->createClientWithCredentials()->request('GET', '/api/pizzas');
        self::assertResponseIsSuccessful();
        self::assertResponseStatusCodeSame(200);
    }

    public function testGetBasketsIdTest():void
    {
        $response = $this->createClientWithCredentials()->request('DELETE', '/api/baskets/{id}');
        self::assertResponseIsSuccessful();
        self::assertResponseStatusCodeSame(200);
    }

    public function testPutBasketsIdTest():void
    {
        $response = $this->createClientWithCredentials()->request('PUT', '/api/baskets/{id}');
        self::assertResponseIsSuccessful();
        self::assertResponseStatusCodeSame(204);
    }

    public function testDeleteBasketsIdTest():void
    {
        $response = $this->createClientWithCredentials()->request('GET', '/api/baskets/{id}');
        self::assertResponseIsSuccessful();
        self::assertResponseStatusCodeSame(200);
    }

    public function testGetCurrentBasketTest():void
    {
        $response = $this->createClientWithCredentials()->request('GET', '/getCurrentBasket');
        self::assertResponseIsSuccessful();
        self::assertResponseStatusCodeSame(200);
    }

    public function addToCurrentBasketTest():void
    {
        $response = $this->createClientWithCredentials()->request('POST', '/addToCurrentBasket');
        self::assertResponseIsSuccessful();
        self::assertResponseStatusCodeSame(201);
    }

    public function getAllUsersTest()
    {
        $response = $this->createClientWithCredentials()->request('GET', '/api/users');
        self::assertResponseIsSuccessful();
        self::assertResponseStatusCodeSame(200);
    }

}

