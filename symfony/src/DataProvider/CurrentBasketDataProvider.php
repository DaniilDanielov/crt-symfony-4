<?php

namespace App\DataProvider;


use ApiPlatform\Core\DataProvider\ItemDataProviderInterface;
use ApiPlatform\Core\DataProvider\RestrictedDataProviderInterface;
use App\Entity\Basket;
use App\Repository\BasketRepository;
use ApiPlatform\Core\DataProvider\ContextAwareCollectionDataProviderInterface;
final class CurrentBasketDataProvider implements RestrictedDataProviderInterface,ContextAwareCollectionDataProviderInterface,ItemDataProviderInterface
{
    private $basketRepository;

    /**
     * @param $basketRepository
     */
    public function __construct(BasketRepository $basketRepository)
    {
        $this->basketRepository = $basketRepository;
    }


    public function supports(string $resourceClass, string $operationName = null, array $context = []): bool
    {
        return Basket::class === $resourceClass;
    }


    public function getCollection(string $resourceClass, string $operationName = null, array $context = []):iterable
    {
        if (empty($_COOKIE['PHPSESSID'])) {
            throw new \Exception('Корзина с соответствующим идентификатором сессии не найдена');
        }

        return $this->basketRepository->getBasketItemsBySessionId($_COOKIE['PHPSESSID']);
    }


    public function getItem(string $resourceClass, $id, string $operationName = null, array $context = [])
    {
        if (empty($_COOKIE['PHPSESSID'])) {
            throw new \Exception('Корзина с соответствующим идентификатором сессии не найдена');
        }
            return $this->basketRepository->findOnePositionByPizzasId($id,$_COOKIE['PHPSESSID']);

    }
}