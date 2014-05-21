<?php
require_once '../vendor/autoload.php';
header("Content-Type: image/png");
$qrCode = new Endroid\QrCode\QrCode();
$qrCode->setText($_GET["txt"]);
$qrCode->setSize(150);
$qrCode->setPadding(10);
$qrCode->render();