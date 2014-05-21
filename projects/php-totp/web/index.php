<!DOCTYPE html>
<?php
ini_set('display_errors',1);
require_once '../vendor/autoload.php';
use Otp\Otp;
use Base32\Base32;
$secret = "BrrY4EJrBJGZbb2mgJCPPg9x";
$interval = 120;
$otp = new Otp();
$key = $otp->totp($secret);
// captcha
use Gregwar\Captcha\CaptchaBuilder;
$builder = new CaptchaBuilder;
$builder->build();
?>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="十二義設計工作室">
    <meta name="author" content="">
    <link rel="shortcut icon" href="assets/ico/favicon.ico">

    <title>captcha/TOTP</title>

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
          <a class="navbar-brand" href="#">php-totp</a>
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
        <h1>captcha</h1>
		<div>
		 <form class="form-inline" role="form">
		 <div class="form-group">
		 <img src="<?php echo $builder->inline(); ?>" />
		 <input type="text" class="form-control" placeholder="Enter text">
		 </div>
		 <button type="submit" class="btn btn-default">Check</button>
		 </form>
		<p><a href="https://github.com/Gregwar/Captcha">Gregwar/Captcha</a></p>
		</div>
      </div>
      <div class="container">
        <h1>Current OTP: <?php echo $key?></h1>
        <p><a href="https://github.com/ChristianRiesen/otp">ChristianRiesen/otp</a></p>
		<p><a href="http://tools.ietf.org/html/draft-mraihi-totp-timebased-00">TOTP: Time-based One-time Password Algorithm</a></p>
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

