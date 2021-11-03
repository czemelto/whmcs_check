{if file_exists("templates/$template/includes/oauth/login.tpl")}
    {include file="{$template}/includes/oauth/login.tpl"}  
{else}
    <div class="main-content col-sm-12">
        {if $appLogo}
            <div class="logo">
                <img src="{$appLogo}" />
            </div>
        {else}
            {if $RCLogo}
                <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}"><img src="{$WEB_ROOT}/{$RCLogo}" alt="{$companyname}" ></a>
            {elseif $MBLogo}
                <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}"  class="logo"><img src="{$MBLogo}" alt="{$companyname}" ></a>
            {elseif $RSThemes.styles.vars.fullPageOnDarkBg}
                {if $RSThemes.logo_inverse}
                    <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" class="logo"><img src="{$WEB_ROOT}{$RSThemes.logo_inverse}" alt="{$companyname}"/></a>
                {elseif $RSThemes.logo}
                    <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" class="logo"><img src="{$WEB_ROOT}{$RSThemes.logo}" alt="{$companyname}"/></a>
                {elseif $assetLogoPath}
                    <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" class="logo"><img src="{$assetLogoPath}" alt="{$companyname}"/></a>
                {else}
                    <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" class="logo logo-text">{$companyname}</a>
                {/if}
            {else}
                {if $RSThemes.logo}
                    <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" class="logo"><img src="{$WEB_ROOT}{$RSThemes.logo}" alt="{$companyname}"/></a>
                {elseif $assetLogoPath}
                    <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" class="logo"><img src="{$assetLogoPath}" alt="{$companyname}"/></a>
                {else}
                    <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" class="logo logo-text">{$companyname}</a>
                {/if}
            {/if}    
        {/if}
        <div class="logincontainer">
            <div class="logincontainer-body">
                {if $incorrect}
                    {include file="$template/includes/alert.tpl" type="error" msg=$LANG.loginincorrect textcenter=true}
                {/if}
                <div class="header-lined text-center m-b-24">
                    <h3>
                        <span class="text-lighter text-small">{$LANG.restrictedpage}</span>
                        <br>
                        {lang key='oauth.loginToGrantApp' appName=$appName}
                    </h3>
                </div>

                <form method="post" action="{$issuerurl}dologin.php" role="form" class="login-form">
                    <div class="form-group">
                        <label for="inputEmail">{$LANG.clientareaemail}</label>
                        <input type="email" name="username" class="form-control" id="inputEmail" placeholder="{$LANG.enteremail}" autofocus>
                    </div>

                    <div class="form-group">
                        <div class="d-flex space-between">
                            <label for="inputPassword">{$LANG.clientareapassword}</label>
                            <a href="{routePath('password-reset-begin')}">{lang key='forgotpw'}</a>
                        </div>
                        <input type="password" name="password" class="form-control" id="inputPassword" placeholder="{$LANG.clientareapassword}" autocomplete="off" >
                    </div>

                    <div class="form-group">
                        <label class="checkbox m-b-16">
                            <input class="icheck-control" type="checkbox" name="rememberme" /> {$LANG.loginrememberme}
                        </label>
                    </div>

                    <button type="submit" class="btn btn-lg btn-primary btn-block" id="btnLogin">
                        {lang key='login'}
                    </button>
                </form>
            </div>
            <div class="logincontainer-footer">
                <div class="pull-right text-right">
                    {if $loggedin}
                        <form method="post" action="{$issuerurl}oauth/authorize.php" id="frmLogout">
                            <input type="hidden" name="logout" value="1"/>
                            <input type="hidden" name="request_hash" value="{$request_hash}"/>
                            <p>
                                {lang key='oauth.currentlyLoggedInAs' firstName=$userInfo.firstName lastName=$userInfo.lastName}{if $userInfo.clientName} ({$userInfo.clientName}){/if}.
                                <a href="#" onclick="jQuery('#frmLogout').submit()">{lang key='oauth.notYou'}</a>
                            </p>
                        </form>
                    {/if}
                    <form method="post" action="{$issuerurl}oauth/authorize.php" id="frmCancelLogin">
                        <input type="hidden" name="return_to_app" value="1"/>
                        <input type="hidden" name="request_hash" value="{$request_hash}"/>
                        <a href="#" onclick="jQuery('#frmCancelLogin').submit()">
                            {lang key='oauth.returnToApp' appName=$appName}
                        </a>
                    </form>
                </div>
            </div>
        </div>
    </div>        

    <form method="post" action="{$issuerurl}oauth/authorize.php" id="frmCancelLogin">
        <input type="hidden" name="login_declined" value="yes"/>
        <input type="hidden" name="request_hash" value="{$request_hash}"/>
    </form>
{/if}