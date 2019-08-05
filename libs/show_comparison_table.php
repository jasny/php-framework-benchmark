<?php

require __DIR__ . '/parse_results.php';
require __DIR__ . '/build_table.php';
require __DIR__ . '/recalc_relative.php';

$variant = getenv('VARIANT');

if ($variant === false) {
    fwrite(STDERR, "VARIANT environment variable not set.\n");
    exit(1);
}

if (!is_dir(__DIR__ . "/../output/$variant/results.log")) {
    fwrite(STDERR, "Run benchmarks.sh with environment variable 'VARIANT=$variant'\n");
    exit(1);
}

$results = parse_results(__DIR__ . '/../output/results.log');
$results_variant = parse_results(__DIR__ . "/../output/$variant/results.log");

$is_fisrt = true;
foreach (array_keys($results_variant) as $fw) {
    $results = [];
    if (isset($results_master[$fw])) {
        $results[$fw] = $results_master[$fw];
    }
    $results["$fw ($variant)"] = $results_variant[$fw];
    
    $results = recalc_relative($results);
    echo build_table($results, $is_first);
    $is_first = false;
}

