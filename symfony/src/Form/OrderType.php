<?php

namespace App\Form;

use App\Entity\Order;
use App\Entity\User;
use App\Repository\UserRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\FormEvents;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormEvent;

class OrderType extends AbstractType
{
    private $em;
    private $userRepository;
    public function __construct(EntityManagerInterface $em,UserRepository $userRepository)
    {
        $this->em=$em;
        $this->userRepository=$userRepository;
    }

    function onPostSubmit(FormEvent $event):void
    {
        $form = $event->getForm();
        $userFullname=$form->getNormData()->getUserName();
        $userPhone=$form->getNormData()->getUserPhone();
        $userAddress=$form->getNormData()->getUserAddress();
        $userWithCurrentPhone = $this->userRepository->findOneByPhone(['userPhone'=>$userPhone]);
         if ($userWithCurrentPhone === null)
         {
             $userName= $this->userRepository->findOneByName(['userName'=>$userFullname]);

             if ($userName === null ) {
                 $user = (new User())
                     ->setUserFullName($userFullname)
                     ->setPassword(password_hash('test', PASSWORD_BCRYPT))
                     ->setUserPhone($userPhone)
                     ->setUserAddress($userAddress)
                     ->setUsername($userFullname);
             } else {
                 $user = (new User())
                     ->setUserFullName($userFullname)
                     ->setPassword(password_hash('test', PASSWORD_BCRYPT))
                     ->setUserPhone($userPhone)
                     ->setUserAddress($userAddress)
                     ->setUsername($userFullname.$userPhone);
             }
             $this->em->persist($user);
             $this->em->flush();

         }
    }


    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('username',TextType::class, array(
                'label'=>'Имя пользователя',
                'attr' => [
                    'placeholder'=>'Введите ваше ФИО'
                ]
            ))
            ->add('userPhone',NumberType::class, array(
        'label'=>'Телефон пользователя',
        'attr' => [
            'placeholder'=>'Введите Ваш телефон','multiple'=>'true',
        ]))

            ->add('userAddress',TextType::class, array(
                'label'=>'Адрес пользователя',
                'attr' => [
                    'placeholder'=>'Введите Ваш Адрес'
                ]
            ))
            ->add('sendOrder',SubmitType::class, array(
                'label'=>'Отправить заказ',
                'attr' => [
                    'class'=>'btn btn-sm btn-outline-secondary text-center'
                ]));
        $builder->addEventListener(FormEvents::POST_SUBMIT, [$this, 'onPostSubmit']);
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Order::class,
        ]);
    }
}
