<?php

use Phalcon\Mvc\Controller;

class HelloController extends Controller
{
    public function indexAction()
    {
        return $this->response->setContent('Hello World!');
    }
}
