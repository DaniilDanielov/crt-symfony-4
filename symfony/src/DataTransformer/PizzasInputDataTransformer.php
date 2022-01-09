<?php

namespace App\DataTransformer;

use ApiPlatform\Core\DataTransformer\DataTransformerInterface;
use App\Entity\Pizzas;

final class PizzasInputDataTransformer implements DataTransformerInterface
{

    /**
     * @param $object
     * @param string $to
     * @param array $context
     * @return Pizzas
     */

    public function transform($object, string $to, array $context = []): Pizzas
    {
        dump($object);
        dump($to);
        dump($context);
        $pizza = new Pizzas();
        $pizza
            ->setTitle($object->getTitle())
            ->setDescription($object->getDescription());
        return $pizza;
    }

    /**
     * {@inheritdoc}
     */
    public function supportsTransformation($data, string $to, array $context = []): bool
    {
        if ($data instanceof Pizzas) {
            return false;
        }

        return Pizzas::class === $to && null !== ($context['input']['class'] ?? null);
    }
}