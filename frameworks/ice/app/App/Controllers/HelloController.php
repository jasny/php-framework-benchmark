<?php

namespace App\Controllers;

use Ice\Mvc\Controller;

/**
 * Hello World controller
 *
 * @package     Ice/Hello
 * @category    Controller
 */
class HelloController extends Controller
{

    /**
     * Default action
     */
    public function indexAction()
    {
        return $this->response->setContent('Hello World!');        
    }
}
