{if file_exists("templates/$template/includes/oauth/authorize.tpl")}
    {include file="{$template}/includes/oauth/authorize.tpl"}  
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
                <div class="header-lined text-center m-b-24">
                    <h3>
                        <span class="text-lighter text-small">{$LANG.restrictedpage}</span>
                        <br>
                        {lang key='oauth.authoriseAppToAccess' appName=$appName}
                    </h3>
                </div>
                <div class="permission-grants form-group">
                    <p>{lang key='oauth.willBeAbleTo'}:</p>
                    <ul>
                        {foreach $requestedPermissions as $permission}
                            <li>{$permission}</li>
                        {/foreach}
                    </ul>
                </div>
                <form method="post" action="#" role="form">
                    {foreach $requestedAuthorizations as $auth}
                        <input type="hidden" name="authz[]" value="{$auth}" />
                    {/foreach}
                   
                    <button name="userAuthorization" id="userAuthorizationAccepted" value="yes" type="submit" class="btn btn-block btn-primary">
                        {lang key='oauth.authorise'}
                    </button>
                    <button name="userAuthorization" id="userAuthorizationDeclined" value="no" type="submit" class="btn btn-block btn-default m-t-16">
                        {lang key='cancel'}
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
{/if}