<?php

class Hello extends CI_Controller
{
    public function index()
    {
        $this->output->set_output('Hello World!');
    }
}
