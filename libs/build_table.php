<?php

function build_table($results, $header = true)
{
    $table = '';

    if ($header) {
        $table .= '|framework                       |requests per second|relative|peak memory|relative|' . "\n";
        $table .= '|--------------------------------|------------------:|-------:|----------:|-------:|' . "\n";
    }
    
    foreach ($results as $fw => $result) {
        $table .= sprintf(
            "|%-32s|%19s|%7s%%|%11s|%8s|\n",
            $fw,
            number_format($result['rps'], 2),
            number_format($result['rps_relative'] * 100, 0),
            number_format($result['memory'], 2),
            number_format($result['memory_relative'], 1)
        );
    }

    return $table;
}
