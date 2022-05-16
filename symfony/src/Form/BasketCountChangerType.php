<?php

namespace App\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Form\FormEvent;
use Symfony\Component\Form\FormEvents;
use Symfony\Component\OptionsResolver\OptionsResolver;
use App\Service\FormSubmitHandler\FormSubmitHandlerService;

class BasketCountChangerType extends AbstractType
{
    private $formSubmitHandler;

    public function __construct(FormSubmitHandlerService $formSubmitHandler)
    {
        $this->formSubmitHandler=$formSubmitHandler;
    }

    function onPostSubmit(FormEvent $event):void
    {
        $form = $event->getForm();
        $quantity=$form->getNormData()['quantity'];
        $pizzaId=$form->getNormData()['pizzaId'];
        $this->formSubmitHandler->BasketCountChangerTypeSubmit($pizzaId,$quantity);

    }

    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('quantity',NumberType::class,array(
                'attr' => ['value'=>'1']))
            ->add('pizzaId',HiddenType::class,array(
                'attr' => ['value'=>'1']))
            ->add('sendOrder',SubmitType::class, array(
                'label'=>'Изменить количество',
                'attr' => [
                    'class'=>'btn btn-success']));
        $builder->addEventListener(FormEvents::POST_SUBMIT, [$this, 'onPostSubmit']);
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            // Configure your form options here
        ]);
    }
}
