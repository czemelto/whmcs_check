{if file_exists("templates/$template/includes/oauth/login-twofactorauth.tpl")}
    {include file="{$template}/includes/oauth/login-twofactorauth.tpl"}  
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
                {include file="$template/includes/pageheader.tpl" title=$LANG.twofactorauth desc="{$LANG.restrictedpage}" textcenter=true}
                <form method="post" action="{routePath('login-two-factor-challenge-verify')}" role="form">
                    <div id="loginWithBackupCode"{if !$backupcode} class="hidden"{/if}>
                        {include file="$template/includes/alert.tpl" type="warning" msg=$LANG.twofabackupcodelogin textcenter=true}
                        <div class="form-group">
                            <input type="text" name="code" class="form-control" placeholder="{$LANG.twofabackupcodelogin}">
                        </div>    
                        <button type="submit" name="backupcode" value="1" class="btn btn-primary btn-block" id="btnLogin">
                            {lang key='login'}
                        </button>
                    </div>
                    <div id="loginWithSecondFactor"{if $backupcode} class="hidden"{/if}>
                        {if $incorrect}
                            {include file="$template/includes/alert.tpl" type="error" msg=$LANG.twofa2ndfactorincorrect textcenter=true}
                        {elseif $error}
                            {include file="$template/includes/alert.tpl" type="error" msg=$error textcenter=true}
                        {else}
                            {include file="$template/includes/alert.tpl" type="warning" msg=$LANG.twofa2ndfactorreq textcenter=true}
                        {/if}
                        <div class="form-group">
                            {$challenge}
                        </div>
                        {$LANG.twofacantaccess2ndfactor} <a href="#" onclick="jQuery('#loginWithSecondFactor').hide();jQuery('#loginWithBackupCode').removeClass('hidden').show();">{$LANG.twofaloginusingbackupcode}</a> 
                    </div>
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