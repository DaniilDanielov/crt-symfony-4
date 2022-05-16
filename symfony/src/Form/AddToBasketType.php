<?php

namespace App\Form;


use App\Service\FormSubmitHandler\FormSubmitHandlerInterface;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Form\FormEvent;
use Symfony\Component\Form\FormEvents;
use Symfony\Component\OptionsResolver\OptionsResolver;

class AddToBasketType extends AbstractType
{
    public function __construct(private FormSubmitHandlerInterface $formSubmitHandler)
    {
    }

    function onPostSubmit(FormEvent $event):void
    {
        $form = $event->getForm();
        $this->formSubmitHandler->basketFormTypeSubmit($form);
    }

    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('sendOrder',SubmitType::class, array(
                'label'=>'Добавить в корзину',
                'attr' => [
                    'class'=>'btn btn-success'
                ]))
            ->add('count',NumberType::class, array(
                'attr' => ['value'=>'1']))
            ->add('pizzaId',HiddenType::class,array(
                'attr' => ['value'=>'0']));
        $builder->addEventListener(FormEvents::POST_SUBMIT, [$this, 'onPostSubmit']);
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            // Configure your form options here
        ]);
    }
}
