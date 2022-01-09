<?php
namespace App\Service\FormSubmitHandler;

interface FormSubmitHandlerMainInterface
{
    public function basketFormTypeSubmit ($form): void;

    public function orderTypeSubmit ($order): void;

    public function basketCountChangerTypeSubmit($pizzaId,$quantity): void;

}