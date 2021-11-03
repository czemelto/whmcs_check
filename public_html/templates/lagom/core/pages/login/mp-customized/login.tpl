{*<div class="logincontainer{if $linkableProviders} with-social{/if}">

    {include file="$template/includes/pageheader.tpl" title=$LANG.login desc="{$LANG.restrictedpage}"}

    {if $incorrect}
        {include file="$template/includes/alert.tpl" type="error" msg=$LANG.loginincorrect textcenter=true}
    {elseif $verificationId && empty($transientDataName)}
        {include file="$template/includes/alert.tpl" type="error" msg=$LANG.verificationKeyExpired textcenter=true}
    {elseif $ssoredirect}
        {include file="$template/includes/alert.tpl" type="info" msg=$LANG.sso.redirectafterlogin textcenter=true}
    {/if}

    <div class="providerLinkingFeedback"></div>

    <div class="row">
        <div class="col-sm-{if $linkableProviders}7{else}12{/if}">

            <form method="post" action="{$systemurl}dologin.php" class="login-form" role="form">
                <div class="form-group">
                    <label for="inputEmail">{$LANG.clientareaemail}</label>
                    <input type="email" name="username" class="form-control" id="inputEmail" placeholder="{$LANG.enteremail}" autofocus>
                </div>

                <div class="form-group">
                    <label for="inputPassword">{$LANG.clientareapassword}</label>
                    <input type="password" name="password" class="form-control" id="inputPassword" placeholder="{$LANG.clientareapassword}" autocomplete="off" >
                </div>

                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="rememberme" /> {$LANG.loginrememberme}
                    </label>
                </div>

                {if $captcha->isEnabled()}
                    <div class="text-center margin-bottom">
                        {include file="$template/includes/captcha.tpl"}
                    </div>
                {/if}

                <div align="center">
                    <input id="login" type="submit" class="btn btn-primary" value="{$LANG.loginbutton}" /> <a href="pwreset.php" class="btn btn-default">{$LANG.forgotpw}</a>
                </div>
            </form>

        </div>
        <div class="col-sm-5{if !$linkableProviders} hidden{/if}">
            {include file="$template/includes/linkedaccounts.tpl" linkContext="login" customFeedback=true}
        </div>
    </div>
</div>
*}

<style>
@font-face {
  font-family: ProximaSoftBold;
  src: url('templates/lagom/fonts/mediaplatz/ProximaSoftBold.otf') format("opentype");
}
@font-face {
  font-family: ProximaSoft;
  src: url('templates/lagom/fonts/mediaplatz/ProximaSoft.otf') format("opentype");
}
.login-container {
  height: 100vh;
}
.login-container .left {
  height: 100vh;
  position: relative;
  background: #ffffff;
}
.login-container .left .content {
  position: absolute;
  width: 50%;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}
.login-container .right {
  height: 100vh;
  background: #031a4c;
}
.login-container .left .ballon-picture img {
  display: block;
  margin: 0 auto;
}
.login-container .left p {
  width: 412px;
  font-family: ProximaSoftBold, "Open Sans";
  text-align: center;
  color: #031a4c;
  font-size: 30px;
  line-height: 37px;
  margin-top: 40px;
}
.login-container .left .mp-logo {
  display: block;
  width: 73px;
  height: 57px;
  background: url('templates/lagom/img/mediaplatz/mp-logo.png') 0 0;
  margin: 22px auto 0 auto;
}
.login-container .right .content {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}
.login-container .right .lock {
  display: block;
  width: 42px;
  height: 57px;
  background: url('templates/lagom/img/mediaplatz/lock.png') 0 0;
  margin: 0 auto 12px auto;
}
.login-container .right .hello {
  font-family: ProximaSoftBold, "Open Sans";
  text-align: center;
  color: #ffffff;
  font-size: 36px;
  margin-bottom: 45px;
}
.login-container .right .content form input[type=email],
.login-container .right .content form input[type=password] {
  width: 355px;
  height: 50px;
}
.login-container .right .content form input[type=submit] {
  display: block;
  width: 355px;
  height: 50px;
  background: #1ccb7b;
  font-size: 18px;
  font-weight: bold;
  font-family: ProximaSoftBold, "Open Sans";
  text-transform: uppercase;
  border: 0;
}
.login-container .right .content form .forgot-password {
  display: block;
  font-family: ProximaSoft, "Open Sans";
  font-size: 16px;
  color: #009fdb;
  margin-top: 27px;
}
.page-login .container {
	width: 100%;
	padding: 0;
}
.main-body {
	padding: 0;
}
@media screen and (max-width: 768px) { /*768 -*/
	section#header .logo img {
		display: none;
	}
  .login-container .left {
    display: none;
  }
  .login-container .right .content {
    position: relative;
    top: initial;
    left: initial;
    transform: none;
    padding: 50px 0;
  }
  .login-container .right {
    min-height: 100vh;
  }
  .login-container .right .content form input[type=email],
  .login-container .right .content form input[type=password],
  .login-container .right .content form input[type=submit] {
    width: 100%;
  }
}

@media screen and (max-width: 500px) { /*500 -*/
  .login-container .left {
    display: none;
  }
}


@media screen and (orientation:landscape) and (max-width: 768px) {
  .login-container {
    background: #031a4c;
    height: auto;
  }
  .login-container .right .content {
    position: relative;
    top: initial;
    left: initial;
    transform: none;
    width: 70%;
    margin-left: 15%;
  }
  .login-container .right {
    height: auto;
    background: #031a4c;
    padding: 50px 0;
  }
  .login-container .right .content form input[type=email],
  .login-container .right .content form input[type=password],
  .login-container .right .content form input[type=submit] {
    width: 100%;
  }

}
</style>

<div class="login-container">
  <div class="container-fluid">
    <div class="row">
      <div class="col-md-6 col-sm-0 left">
        <div class="content">
          <div class="ballon-picture">
            <img src="{$systemurl}templates/{$template}/img/mediaplatz/home_01.svg" title="" alt="" />
          </div>
          {* <p class="text">{$LANG.mp_login_left_text}</p> 
          <span class="mp-logo"></span> *}
        </div>
      </div>
      <div class="col-md-6 col-sm-12 right">
        <div class="content">
          <span class="lock"></span>
          <p class="hello">{$LANG.mp_login_welcome}</p>
          <div class="login-error-messages">

            {if $incorrect}
                {include file="$template/includes/alert.tpl" type="error" msg=$LANG.loginincorrect textcenter=true}
            {elseif $verificationId && empty($transientDataName)}
                {include file="$template/includes/alert.tpl" type="error" msg=$LANG.verificationKeyExpired textcenter=true}
            {elseif $ssoredirect}
                {include file="$template/includes/alert.tpl" type="info" msg=$LANG.sso.redirectafterlogin textcenter=true}
            {/if}
          </div>
		  
          <form method="post" action="{$systemurl}dologin.php" class="login-form" role="form">
              <div class="form-group">
                <input type="email" name="username" class="form-control" id="inputEmail" placeholder="{$LANG.enteremail}" autofocus>
              </div>

              <div class="form-group">
                <input type="password" name="password" class="form-control" id="inputPassword" placeholder="{$LANG.clientareapassword}" autocomplete="off" >
              </div>
			  
			  {if $captcha->isEnabled()}
                    <div class="text-center margin-bottom">
                        {include file="$template/includes/captcha.tpl"}
                    </div>
              {/if}

              <div align="center">
                <input id="login" type="submit" class="btn btn-primary btn-recaptcha" value="{$LANG.loginbutton}" /> 
                <a class="forgot-password" href="pwreset.php">{$LANG.forgotpw}</a>
              </div>
          </form>
        </div>
        <div class="clearfix"></div>
      </div>
    </div>
  </div>
</div>