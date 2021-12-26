<?php

namespace App\Controller;



use App\Entity\Order;
use App\Entity\Pizzas;
use App\Form\AddToBasketType;
use App\Form\OrderType;
use App\Message\OrderMessage;
use App\Repository\BasketRepository;
use App\Service\FormSubmitHandler\FormSubmitHandlerInterface;
use App\Repository\PizzasRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use Symfony\Component\Messenger\MessageBusInterface;
use Symfony\Component\Routing\Annotation\Route;
use Twig\Environment;
use Knp\Component\Pager\PaginatorInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Doctrine\ORM\EntityManagerInterface;
use App\Service\AmountService;
use App\Form\BasketCountChangerType;

class MainController extends AbstractController
{
    private $entityManager;
    private $twig;
    private $formSubmitHandlerService;
    private $amountService;
    private $sessionId;


    public function __construct(Environment                $twig,
                                EntityManagerInterface     $entityManager,
                                SessionInterface           $session,
                                AmountService              $amountService,
                                FormSubmitHandlerInterface $formSubmitHandlerService)
    {
        $this->entityManager = $entityManager;
        $this->twig = $twig;
        $this->amountService = $amountService;
        $this->formSubmitHandlerService = $formSubmitHandlerService;
        $this->session = $session;
        $this->session->start();
        $this->sessionId = $this->session->getId();
    }


    #[Route('/', name: 'main')]
    public function index(Request            $request,
                          PaginatorInterface $paginator,
                          PizzasRepository   $pizzasRepository,
    ): Response
    {
        $form = $this->createForm(AddToBasketType::class);
        $form->handleRequest($request);
        $pizzas = $paginator->paginate($pizzasRepository->findAll(), $request->query->getInt('page', 1), 2);
        return new Response($this->twig->render('main/index.html.twig',
            ['pizzas' => $pizzas, 'formObject' => $form,]));
    }

    #[Route("/pizza/{id}", name: 'pizza')]
    public function showPizzaItem(Pizzas $pizza, Request $request): Response
    {
        $form = $this->createForm(AddToBasketType::class);
        $form->handleRequest($request);
        if ($form->isSubmitted()) {
            $this->addFlash('success', 'Ваша пицца добавлена в корзину!');
        }
        return new Response($this->twig->render('pizza/show.html.twig',
            ['pizza' => $pizza,
            'form' => $form->createView(),
            ]));
    }

    #[Route("/basket", name: 'basket')]
    public function showBasket(Request $request, BasketRepository $basketRepository): Response
    {
        $items = $basketRepository->getBasketItems($this->session);
        $amount = $this->amountService->calculateAmount($items);
        $form = $this->createForm(BasketCountChangerType::class);
        $form->handleRequest($request);
        if ($form->isSubmitted()) {
            $this->addFlash('success', 'Количество пиццы изменено!');
            return $this->redirectToRoute('basket', array(
                'items' => $items,
                'message' => 'Корзина пуста',
                'amount' => $amount,
                'formObject' => $form,
            ));
        }
        return $this->render('pizza/basket.html.twig', [
            'items' => $items,
            'message' => 'Корзина пуста',
            'amount' => $amount,
            'formObject' => $form,
        ]);

    }

    #[Route("/order", name: 'order')]
    public function CreateNewOrder(Request             $request,
                                   BasketRepository    $basketRepository,
                                   MessageBusInterface $bus): Response
    {
        $em = $this->entityManager;
        $order = new Order();
        $form = $this->createForm(OrderType::class, $order);
        $form->handleRequest($request);
        $sessionId = $this->session->getId();
        $items = $basketRepository->getBasketItems($this->session);
        $amount = $this->amountService->calculateAmount($items);
        if ($form->isSubmitted() && $form->isValid()) {
            $this->formSubmitHandlerService->OrderTypeSubmit($order,$id);
            $bus->dispatch(new OrderMessage($order->getId(), []));
            $this->addFlash('success', 'Заявка отправлена в очередь обработки RabbitMQ!');
            return $this->redirectToRoute('order');
        }
        return new Response($this->twig->render('main/order.html.twig', [
            'title' => 'Оформление заказа',
            'order_form' => $form->createView(),
            'items' => $items,
            'amount' => $amount,
        ]));
    }
}
