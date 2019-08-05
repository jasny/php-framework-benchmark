<?php

function parse_results($file)
{
    $lines = file($file);
    
    $results = [];
    $max_rps    = NAN;
    $min_memory = INF;
    $min_time   = INF;
    $min_file   = INF;
    
    foreach ($lines as $line) {
        $column = explode('|', trim($line));

        $fw = $column[0];
        $rps    = (float)trim($column[1]);
        $memory = is_numeric($column[2]) ? (float)$column[2]/1024/1024 : INF;
        $time   = is_numeric($column[3]) ? (float)$column[3]*1000 : INF;
        $file   = is_numeric($column[4]) ? (int)$column[4] : INF;
        
        $max_rps    = max($max_rps, $rps);
        $min_memory = min($min_memory, $memory);
        $min_time   = min($min_time, $time);
        $min_file   = min($min_file, $file);
        
        $results[$fw] = [
            'rps'    => $rps,
            'memory' => round($memory, 2),
            'time'   => $time,
            'file'   => $file,
        ];
    }
    
    foreach ($results as $fw => $data) {
        $results[$fw]['rps_relative']    = $data['rps'] / $max_rps;
        $results[$fw]['memory_relative'] = $data['memory'] / $min_memory;
        $results[$fw]['time_relative'] = $data['time'] / $min_time;
        $results[$fw]['file_relative'] = $data['file'] / $min_file;
    }
    
    array_multisort(array_column($results, 'rps'), SORT_DESC, $results);
    
    return $results;
}
