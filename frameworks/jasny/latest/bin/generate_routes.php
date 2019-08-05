<?php

require 'vendor/autoload.php';
require 'routes.php';

use Jasny\SwitchRoute\Generator;
use Jasny\SwitchRoute\Invoker;

$stud = function($str) {
    return strtr(ucwords($str, '-'), ['-' => '']);
};
$camel = function($str) {
    return strtr(lcfirst(ucwords($str, '-')), ['-' => '']);
};

$invoker = new Invoker(function (?string $controller, ?string $action) use ($stud, $camel) {
    return $controller !== null
        ? ['App\\' . $stud($controller) . 'Controller', $camel($action ?? 'default') . 'Action']
        : ['App\\' . $stud($action) . 'Action', '__invoke'];
});

//$generator = new Generator(new Generator\GenerateFunction($invoker));
//$generator->generate('route', 'generated/route.php', 'getRoutes', true);

$routeGenerator = new Generator(new Generator\GenerateRouteMiddleware());
$routeGenerator->generate('App\Generated\RouteMiddleware', 'generated/RouteMiddleware.php', 'getRoutes', true);

$invokeGenerator = new Generator(new Generator\GenerateInvokeMiddleware($invoker));
$invokeGenerator->generate('App\Generated\InvokeMiddleware', 'generated/InvokeMiddleware.php', 'getRoutes', true);

