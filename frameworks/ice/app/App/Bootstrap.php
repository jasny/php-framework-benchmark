<?php

namespace App;

// Create a dependency injector container
$di = new \Ice\Di();

// Register App namespace for App\Controller, App\Model, App\Library, etc.
$di->loader
    ->addNamespace(__NAMESPACE__, __DIR__)
    ->register();

// Set some service's settings
$di->dispatcher
    ->setNamespace(__NAMESPACE__);

// Set routes
$di->set('router', function () {
    $router = new \Ice\Mvc\Router();
    $router->setRoutes([
        ['GET', '/{controller}'],
        ['GET', ''],
    ]);

    return $router;
});

$di->view
    ->setViewsDir(__DIR__ . '/View/');

// Create and return a MVC application
return new \Ice\Mvc\App($di);
