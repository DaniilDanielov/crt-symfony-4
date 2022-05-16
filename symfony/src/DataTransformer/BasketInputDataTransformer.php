<?php

namespace App\DataTransformer;

use ApiPlatform\Core\DataTransformer\DataTransformerInterface;
use ApiPlatform\Core\Serializer\AbstractItemNormalizer;
use App\Entity\Basket;
use App\Repository\PizzasRepository;
use App\Service\BasketAddController\BasketAddControllerInterface;
use Doctrine\ORM\EntityManagerInterface;


final class BasketInputDataTransformer implements DataTransformerInterface
{
    public function __construct(PizzasRepository $pizzasRepository,
                                EntityManagerInterface $em,
                                BasketAddControllerInterface $basketAddController)
    {
        $this->pizzasRepository=$pizzasRepository;
        $this->em=$em;
        $this->basketAddController=$basketAddController;
    }

    /**
     * @param $object
     * @param string $to
     * @param array $context
     * {@inheritdoc}
     */

    public function transform($object, string $to, array $context = [])
    {
        if(isset($context['item_operation_name']) && $context['item_operation_name'] ==='put')
        {
            $existingBasket = $context[AbstractItemNormalizer::OBJECT_TO_POPULATE];
            $existingBasket->setCount($object->getCount());
                return $existingBasket;
        }
        if($context['collection_operation_name']==='post') {
            foreach ($object->getPizzasId() as $item) {
                $pizza = $this->pizzasRepository->getPizzaById($item);
                $count = 1;
                $this->basketAddController->AddtoBasket($count, $pizza);
            }
        }
        return $this->em->getRepository(Basket::class)->getBasketItemsBySessionId($_COOKIE['PHPSESSID']);
    }


    public function supportsTransformation($data, string $to, array $context = []): bool
    {
        if ($data instanceof Basket) {
            return false;
        }
        return Basket::class === $to && null !== ($context['input']['class'] ?? null);
    }
}