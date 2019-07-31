<?php

use Slim\App;
use Slim\Http\Request;
use Slim\Http\Response;

return function (App $app) {
    $container = $app->getContainer();

    $app->get('/hello', function (Request $request, Response $response, array $args) use ($container) {
        $response->write('Hello World!');
    });
};

