<?php
namespace App\Service\FormSubmitHandler;

interface FormSubmitHandlerInterface
{
    public function basketFormTypeSubmit ($form);

    public function orderTypeSubmit ($order);

    public function basketCountChangerTypeSubmit($pizzaId,$quantity);

}