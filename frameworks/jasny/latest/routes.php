<?php

function getRoutes(): array
{
    return [
        'GET /'      => ['controller' => 'index'],
        'GET /hello' => ['controller' => 'hello'],
    ];
}

