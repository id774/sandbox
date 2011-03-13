<?php
/*
    namecalc.php v1.0 at 2011.03.13 by id774 <idnanashi@gmail.com>.
*/

function num($i, $j) {
    if (is_numeric($i)) {
        if (is_numeric($j)) {
            return $i + $j;
        }
    }
}

function digit($i) {
    if ($i >= 10) $i = $i - 10;
    return $i;
}

function isset_array($base_array, $i) {
    if (isset($base_array[$i])) {
        return digit(num($base_array[$i - 1], $base_array[$i]));
    }
}

function calc($iname) {
    $base_array = str_split($iname);
    $base_array_size = count($base_array);
    $calc_array = $base_array;

    for ($j = 3; $j <= $base_array_size ; $j++) {
        for ($i = 1; $i <= $base_array_size ; $i++) {
            $calc_array[$i - 1] = isset_array($base_array, $i);
        }
        $base_array = $calc_array;
    }
    return "$calc_array[0]$calc_array[1]";
}

function h($str) {
    return htmlspecialchars($str,ENT_QUOTES);
}

function main() {
    if ($_SERVER['REQUEST_METHOD'] == "POST") {
        $male = h($_POST['M']);
        $female  = h($_POST['F']);
        $calc = calc($male . $female);
        $result = "M $male F $female R $calc";
        print h($result);
    }
}

main()
?>
<!Doctype HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
 "http://www.w3.org/TR/html4/loose.dtd"> 
<!--nobanner-->
<html lang="ja">
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>774</title>
    <meta name="description" content="774">
    <meta name="keywords" content="774">
    <meta http-equiv="content-style-type" content="text/css">
    <link rel="stylesheet" href="./stylesheets/common.css" type="text/css">
    <link rel="index" href="./index.html">
    <link rev="made" href="mailto:idnanashi@gmail.com">
    <meta http-equiv="content-script-type" content="text/javascript">
</head>
<body>
    <form action="namecalc.php" method="post">
    M <input type="text" name="M" value="" accesskey="m" tabindex="1">
    F <input type="text" name="F" value="" accesskey="f" tabindex="2">
    <input type="submit" value="Send" accesskey="s" tabindex="3">
    </form>
</body>
</html>
