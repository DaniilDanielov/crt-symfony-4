<?php

namespace App\Controller\Admin;

use App\Entity\User;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;
use EasyCorp\Bundle\EasyAdminBundle\Field\ArrayField;
use EasyCorp\Bundle\EasyAdminBundle\Config\Actions;
use EasyCorp\Bundle\EasyAdminBundle\Config\Action;

class UserCrudController extends AbstractCrudController
{
    public static function getEntityFqcn(): string
    {
        return User::class;
    }


    public function configureFields(string $pageName): iterable
    {
        return [
            TextField::new('username'),
            TextField::new('userFullName'),
            TextField::new('password')
                ->setPermission('ROLE_ADMIN'),
            ArrayField::new('roles')
                ->setPermission('ROLE_ADMIN'),
            TextField::new('userAddress'),
            TextField::new('userPhone'),
        ];
    }

    public function configureActions(Actions $actions): Actions
    {
        return $actions
            ->setPermission(Action::EDIT, 'ROLE_ADMIN')
            ->setPermission(Action::NEW, 'ROLE_ADMIN')
            ->setPermission(Action::DELETE, 'ROLE_ADMIN')
        ->setPermission(Action::DETAIL, 'ROLE_MANAGER');
    }


}
