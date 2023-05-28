<?php

header("Location: https://politipet.github.io");

$time = date("Y-m-d H:i:s");
$data = implode(",", array_keys($_POST));
if ($data)
file_put_contents('poll.txt', $time . "\t" . $data . "\n", FILE_APPEND);

?>
