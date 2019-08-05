<?php

require 'vendor/autoload.php';

use App\Generated\RouteMiddleware;
use App\Generated\InvokeMiddleware;
use HttpMessage\ServerRequest;
use Psr\Http\Factory\ResponseFactoryInterface;
use Relay\Relay;

$middleware[] = new RouteMiddleware();
$middleware[] = new InvokeMiddleware();

$relay = new Relay($middleware);

$request = new ServerRequest($_SERVER, $_COOKIE, $_GET, $_POST, $_FILES);
$response = $relay->handle($request);

echo $response->getBody();

