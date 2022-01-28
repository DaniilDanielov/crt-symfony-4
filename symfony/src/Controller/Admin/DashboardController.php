<?php

namespace App\Controller\Admin;

use App\Entity\Basket;
use App\Entity\Order;
use App\Entity\Pizzas;
use App\Entity\User;
use EasyCorp\Bundle\EasyAdminBundle\Config\Dashboard;
use EasyCorp\Bundle\EasyAdminBundle\Config\MenuItem;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractDashboardController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use EasyCorp\Bundle\EasyAdminBundle\Config\Actions;

class DashboardController extends AbstractDashboardController
{
    /**
     * @Route("/admin", name="admin")
     */
    public function index(): Response
    {
        return parent::index();
    }

    public function configureDashboard(): Dashboard
    {
        return Dashboard::new()
            ->setTitle('Symfony');
    }

    public function configureMenuItems(): iterable
    {
        yield MenuItem::linkToRoute('Go to main page', 'fa fa-home', 'main');
        yield MenuItem::linkToDashboard('Dashboard', 'fa fa-home');
        yield MenuItem::linkToCrud('Pizzas', 'fas fa-list', Pizzas::class)
            ->setPermission('ROLE_ADMIN');
        yield MenuItem::linkToCrud('User', 'fas fa-list', User::class);
        yield MenuItem::linkToCrud('Order', 'fas fa-list', Order::class)
            ->setPermission('ROLE_ADMIN');
        yield MenuItem::linkToCrud('Basket', 'fas fa-list', Basket::class)
            ->setPermission('ROLE_ADMIN');
    }
}

/*    public function configureActions(Actions $actions): Dashboard
    {
        return Dashboard::new()
            ->setTitle('Symfony');
    }
}*/
