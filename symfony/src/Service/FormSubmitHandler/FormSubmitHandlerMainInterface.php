<?php
namespace App\Service\FormSubmitHandler;

interface FormSubmitHandlerMainInterface
{
    public function basketFormTypeSubmit ($form);

    public function orderTypeSubmit ($order);

    public function basketCountChangerTypeSubmit($pizzaId,$quantity);

}