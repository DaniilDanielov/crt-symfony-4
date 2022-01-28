<?php

namespace App\Controller\Admin;

use App\Entity\Pizzas;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextEditorField;
use EasyCorp\Bundle\EasyAdminBundle\Field\ImageField;
use EasyCorp\Bundle\EasyAdminBundle\Field\IntegerField;

class PizzasCrudController extends AbstractCrudController
{
    public static function getEntityFqcn(): string
    {
        return Pizzas::class;
    }


    public function configureFields(string $pageName): iterable
    {
        return [
            TextField::new('title'),
            IntegerField::new('price'),
            TextEditorField::new('description'),
            ImageField::new('image')
                ->setBasePath('images/user/')
                ->setUploadDir('/public/upload/files/')
                ->setUploadedFileNamePattern('[randomhash].[extension]')
                ->setRequired(false),
        ];
    }
}
