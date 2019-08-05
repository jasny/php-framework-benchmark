<?php

namespace App;

use HttpMessage\Response;

class HelloController
{
    public function defaultAction()
    {
        $response = new Response();
        $response->getBody()->write('Hello World!');

        return $response;
    }
}

