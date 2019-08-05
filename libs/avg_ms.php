<?php

$times = array_slice($argv, 1);
echo $times !== [] ? array_sum($times) / count($times) : 'n/a';

