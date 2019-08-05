<?php

namespace App;

use HttpMessage\Response;

class IndexController
{
    public function defaultAction()
    {
        $response = new Response();
        $response->getBody()->write('ok');

        return $response;

    }
}

