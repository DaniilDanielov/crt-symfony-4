<?php

namespace App\Repository;

use App\Entity\Basket;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\EntityManagerInterface;

/**
 * @method Basket|null find($id, $lockMode = null, $lockVersion = null)
 * @method Basket|null findOneBy(array $criteria, array $orderBy = null)
 * @method Basket[]    findAll()
 * @method Basket[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class BasketRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry,EntityManagerInterface $entityManager)
    {
        parent::__construct($registry, Basket::class);
        $this->entityManager=$entityManager;
    }

    public function findOneByIdJoinedToCategory(string $productId): Basket
    {
        $entityManager = $this->getEntityManager();
        $query = $entityManager->createQuery(
            'SELECT p, c
            FROM App\Entity\Basket p
            INNER JOIN p.item c
            WHERE p.id = :id'
        )->setParameter('id', $productId);

        return $query->getOneOrNullResult();
    }


     /**
      * @return Basket[] Returns an array of Basket objects
      */
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('b')
            ->andWhere('b.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('b.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult();
    }


    public function findOneBySomeFields($item,$session): ?Basket
    {
        return $this->createQueryBuilder('b')
            ->andWhere('b.item = :item')
            ->andWhere('b.sessionId = :session')
            ->andWhere('b.id IS NOT NULL')
            ->setParameter('item', $item)
            ->setParameter('session', $session)
            ->getQuery()
            ->getOneOrNullResult();
        ;
    }

    public function getBasketItems($session)
    {
        $sessionId=$session->getId();
        return $this->createQueryBuilder('b')
            ->andWhere('b.sessionId = :session')
            ->setParameter('session', $sessionId)
            ->getQuery()
            ->getResult();
    }
}
