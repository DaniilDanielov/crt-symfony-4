<?php

namespace App\Repository;

use App\Entity\Pizzas;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method Pizzas|null find($id, $lockMode = null, $lockVersion = null)
 * @method Pizzas|null findOneBy(array $criteria, array $orderBy = null)
 * @method Pizzas[]    findAll()
 * @method Pizzas[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class PizzasRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Pizzas::class);
    }



     /**
      * @return Pizzas[] Returns an array of Pizzas objects
      */

    public function getPizzasById( $value):array
    {
        return $this->createQueryBuilder('p')
            ->andWhere('p.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getResult();
    }


    public function getPizzaById($id)
    {
        return $this->createQueryBuilder('b')
            ->andWhere('b.id = :id')
            ->setParameter('id', $id)
            ->getQuery()
            ->getOneOrNullResult();
    }
}
