<?php

namespace App\DataFixtures;

use App\Entity\Pizzas;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;

class PizzasFixtures extends Fixture
{
    public function load(ObjectManager $manager): void
    {
         $pizza1 = (new Pizzas())
             ->setTitle('Пицца№1')
             ->setDescription('Описание Пиццы №1')
             ->setPrice(545);
         $manager->persist($pizza1);


         $pizza1 = (new Pizzas())
             ->setTitle('Пицца№2')
             ->setDescription('Описание Пиццы №2')
             ->setPrice(456);
         $manager->persist($pizza1);


         $pizza1 = (new Pizzas())
             ->setTitle('Пицца№3')
             ->setDescription('Описание Пиццы №3')
             ->setPrice(642);
         $manager->persist($pizza1);

         $pizza1 = (new Pizzas())
             ->setTitle('Пицца№4')
             ->setDescription('Описание Пиццы №4')
             ->setPrice(645);
         $manager->persist($pizza1);

        $manager->flush();
    }
}
