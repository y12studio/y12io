<!DOCTYPE html>
<?php
ini_set('error_reporting', E_ALL); 
ini_set('display_errors',1);
require_once '../vendor/autoload.php';
require_once 'secret.php';

if(empty($_REQUEST['txt'])){
  $target = 'http://y12.tw';
} else {
  $target = $_REQUEST['txt'];
}
$qrurl = 'qrcode.php?txt='.$target;

use Mremi\UrlShortener\Model\Link;
use Mremi\UrlShortener\Provider\Google\GoogleProvider;

$link = new Link;
$link->setLongUrl($target);

$googleProvider = new GoogleProvider(
    $google_api_key,
    array('connect_timeout' => 1, 'timeout' => 1)
);
$googleProvider->shorten($link);
?>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="十二義設計工作室">
    <meta name="author" content="">
    <link rel="shortcut icon" href="assets/ico/favicon.ico">

    <title>QRCode-y12studio</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/style.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy this line! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>

    <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">php-qrcode</a>
        </div>
        <div class="navbar-collapse collapse">
          <form class="navbar-form navbar-right" role="form">
            <div class="form-group">
              <input type="text" placeholder="Email" class="form-control">
            </div>
            <div class="form-group">
              <input type="password" placeholder="Password" class="form-control">
            </div>
            <button type="submit" class="btn btn-success">Sign in</button>
          </form>
        </div><!--/.navbar-collapse -->
      </div>
    </div>

    <!-- Main jumbotron for a primary marketing message or call to action -->
    <div class="jumbotron">
	  <div class="container">
        <h1>qrcode</h1>
		<div>
		 <div><img src="<?= $qrurl;?>"/><p>
		 <?php echo $qrurl;?>
		 </p>
		 <p>QRCode <a href="?txt=http://www.google.com">google.com</a></p></div>
		<p><a href="https://github.com/endroid/QrCode">endroid/QrCode</a></p>
		</div>
      </div>
      <div class="container">
        <h1>Google Shorturl</h1>
		<p><?= $link->getShortUrl()?></p>
        <p><a href="https://github.com/mremi/UrlShortener">mremi/UrlShortener</a></p>
		
        <p><a class="btn btn-primary btn-lg" role="button" href="info.php">phpinfo &raquo;</a></p>
      </div>
    </div>

    <div class="container">
      <!-- Example row of columns -->
      <div class="row">
	    <div class="col-md-3">
          <h2><a href="http://y12.tw/wp/category/dokku/">dokku | Y12 Studio</a></h2>
          <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
          <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p>
       </div>
        <div class="col-md-6">
          <h2>how to run</h2>
          <p>$ git clone https://github.com/y12studio/dok-php-hello</p>
		  <p>$ cd dok-php-hello</p>
		  <p>$ git remote add dokku dokku@HOSTNAME:APPNAME</p>
		  <p>$ git push dokku master</p>
		   <p>$ curl http://APPNAME.HOSTNAME</p>
		  
          <p><a class="btn btn-default" href="https://github.com/y12studio/dok-php-hello" role="button">View details &raquo;</a></p>
        </div>
      
        <div class="col-md-3">
          <h2><a href="https://github.com/y12studio/">y12studio (github)</a></h2>
          <p>Donec sed odio dui. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>
          <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p>
        </div>
      </div>

      <hr>

      <footer>
        <p>&copy; Company 2014</p>
      </footer>
    </div> <!-- /container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>

