<?php

require __DIR__ . '/php-recipe-2nd/make_chart_parts.php';

function make_graph($results, $id, $title, $hAxis_title)
{
    $barColors = array(
        'DarkBlue', 'DarkCyan', 'DarkGoldenRod', 'DarkGray', 'DarkGreen',
        'DarkKhaki', 'DarkMagenta', 'DarkOliveGreen', 'DarkOrange', 'DarkOrchid',
        'DarkRed', 'DarkSalmon', 'DarkSeaGreen', 'DarkSlateBlue', 'DarkSlateGray',
        'DarkBlue', 'DarkCyan', 'DarkGoldenRod', 'DarkGray', 'DarkGreen',
        'DarkKhaki', 'DarkMagenta', 'DarkOliveGreen', 'DarkOrange', 'DarkOrchid',
        'DarkRed', 'DarkSalmon', 'DarkSeaGreen', 'DarkSlateBlue', 'DarkSlateGray',
    );
    $graphWidth  = 1200;
    $graphHeight = 400;

    $data = array();
    $data[] = array('', $id, array('role' => 'style'));  // header

    $colors = $barColors;
    foreach ($results as $fw => $result) {
        $data[] = array($fw, $result[$id] !== INF ? $result[$id] : 0, array_shift($colors));
    }

    $options = array(
      'title'  => $title,
      'titleTextStyle' => array('fontSize' => 16),
      'hAxis'  => array('title' => $hAxis_title,
                        'titleTextStyle' => array('bold' => true)),
      'vAxis'  => array('minValue' => 0, 'maxValue' => 0.01),
      'width'  => $graphWidth,
      'height' => $graphHeight,
      'bar'    => array('groupWidth' => '90%'),
      'legend' => array('position' => 'none')
    );
    $type = 'ColumnChart';
    return makeChartParts($data, $options, $type);
}
