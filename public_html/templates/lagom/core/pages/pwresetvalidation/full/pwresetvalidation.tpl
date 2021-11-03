<div class="main-content col-sm-12">
    {if $RSThemes['pages'][$templatefile]['config']['showLogo'] == '1'}
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
    {else}
        {include file="$template/includes/pageheader.tpl" title=$LANG.pwreset textcenter=true}
    {/if}
    
    <script>
        window.langPasswordStrength = "{$LANG.pwstrength}";
        window.langPasswordWeak = "{$LANG.pwstrengthweak}";
        window.langPasswordModerate = "{$LANG.pwstrengthmoderate}";
        window.langPasswordStrong = "{$LANG.pwstrengthstrong}";
        window.langPasswordTooShort = "{$rslang->trans('login.at_least_pass')}";
    </script>

    <div class="logincontainer">
        <div class="logincontainer-body">
            {if $RSThemes['pages'][$templatefile]['config']['showLogo'] == '1'}
                 {include file="$template/includes/pageheader.tpl" title=$LANG.pwreset textcenter=true}
            {/if}
        {if $invalidlink}

            {include file="$template/includes/message.tpl" type="danger" msg=$invalidlink textcenter=true additionalClasses="m-b-0"}

        {elseif $success}

            {include file="$template/includes/message.tpl" type="success" msg=$LANG.pwresetvalidationsuccess textcenter=true}
            <div class="text-center">
                <a href="clientarea.php" class="btn btn-default">
                    {$LANG.orderForm.continueToClientArea}
                </a>
            </div>    

        {else}

            {if $errormessage}
                {include file="$template/includes/alert.tpl" type="danger" msg=$errormessage textcenter=true}
            {/if}

            <p class="text-lighter text-center text-small">{$LANG.pwresetenternewpw}</p>

            <form class="using-password-strength" method="post" action="{$smarty.server.PHP_SELF}?action=pwreset">
                <input type="hidden" name="key" id="key" value="{$key}" />

                <div id="newPassword1" class="form-group has-feedback">                
                    <label class="control-label" for="inputNewPassword1">{$LANG.newpassword}</label>
                    <div class="input-password-strenght">
                        <input type="password" name="newpw" id="inputNewPassword1" class="form-control" autocomplete="off" />
                        <span class="text-small text-lighter"><span id="passwordStrengthTextLabel">{$LANG.pwstrengthenter}</span><i data-toggle="tooltip" title="{$LANG.passwordtips}" data-html="true" data-container="body" class="ls ls-info-circle"></i></span>
                    </div>
                    {include file="$template/includes/pwstrength.tpl"}
                </div>

                <div id="newPassword2" class="form-group has-feedback">
                    <label class="control-label" for="inputNewPassword2">{$LANG.confirmnewpassword}</label>
                    <input type="password" name="confirmpw" id="inputNewPassword2" class="form-control" autocomplete="off" />
                    
                    <div id="inputNewPassword2Msg"></div>
                </div>
                <input class="btn btn-primary btn-block" type="submit" name="submit" value="{$LANG.clientareasavechanges}" />
            </form>
        {/if}
        </div>
        {if $invalidlink}
            <div class="logincontainer-footer">
                <a href="{routePath('password-reset-begin')}">{$LANG.loginforgotteninstructions}</a>
            </div>
        {else}
        {if $condlinks.allowClientRegistration}
            <div class="logincontainer-footer">
                <div class="text-light">{$rslang->trans('social.not_member')} <a href="{$WEB_ROOT}/register.php">{$LANG.orderForm.createAccount}</a></div>
            </div>
        {/if}
        {/if}
    </div>
    {if $languagechangeenabled && count($locales) > 1}
        {include file="$template/includes/language-chooser.tpl" type="login"}   
    {/if}    
</div>