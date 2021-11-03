<div class="main-content col-sm-12">
    {if $RSThemes['pages'][$templatefile]['config']['showLogo'] == '1'}
        {if $RCLogo}
            <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" tabindex="7"><img src="{$WEB_ROOT}/{$RCLogo}" alt="{$companyname}"></a>
        {elseif $MBLogo}
            <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" tabindex="7" class="logo"><img src="{$MBLogo}" alt="{$companyname}"></a>
        {elseif $RSThemes.styles.vars.fullPageOnDarkBg}
            {if $RSThemes.logo_inverse}
                <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" tabindex="7" class="logo"><img src="{$WEB_ROOT}{$RSThemes.logo_inverse}" alt="{$companyname}" /></a>
            {elseif $RSThemes.logo}
                <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" tabindex="7" class="logo"><img src="{$WEB_ROOT}{$RSThemes.logo}" alt="{$companyname}" /></a>
            {elseif $assetLogoPath}
                <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" tabindex="7" class="logo"><img src="{$assetLogoPath}" alt="{$companyname}" /></a>
            {else}
                <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" tabindex="7" class="logo logo-text">{$companyname}</a>
            {/if}
        {else}
            {if $RSThemes.logo}
                <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" tabindex="7" class="logo"><img src="{$WEB_ROOT}{$RSThemes.logo}" alt="{$companyname}" /></a>
            {elseif $assetLogoPath}
                <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" tabindex="7" class="logo"><img src="{$assetLogoPath}" alt="{$companyname}" /></a>
            {else}
                <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" tabindex="7" class="logo logo-text">{$companyname}</a>
            {/if}
        {/if}
    {else}
        {include file="$template/includes/pageheader.tpl" title=$LANG.clientareahomeloginbtn desc="{$LANG.restrictedpage}" textcenter=true}
    {/if}

    <div class="logincontainer">
        <div class="logincontainer-body">
            {if $RSThemes['pages'][$templatefile]['config']['showLogo'] == '1'}
                {include file="$template/includes/pageheader.tpl" title=$LANG.clientareahomeloginbtn desc="{$LANG.restrictedpage}" textcenter=true}
            {/if}
            {include file="$template/includes/flashmessage.tpl"}
            <form method="post" action="{routePath('login-validate')}" class="login-form" role="form">
                <div class="form-group">
                    <label for="inputEmail">{$LANG.clientareaemail}</label>
                    <input type="email" name="username" class="form-control input-lg" id="inputEmail" placeholder="{$LANG.enteremail}" tabindex="1" autofocus>
                </div>
                <div class="form-group">
                    <div class="d-flex space-between">
                        <label for="inputPassword">{$LANG.clientareapassword}</label>
                        <a href="{routePath('password-reset-begin')}" tabindex="5">{$rslang->trans('login.forgot')}</a>
                    </div>
                    <input type="password" name="password" class="form-control input-lg" id="inputPassword" placeholder="{$LANG.clientareapassword}" autocomplete="off" tabindex="2">
                </div>
                <div class="form-group">
                    <label class="checkbox m-b-16" tabindex="3">
                        <input class="icheck-control" type="checkbox" name="rememberme" /> {$LANG.loginrememberme}
                    </label>
                </div>
                {if $captcha->isEnabled()}
                    <div class="text-center margin-bottom">
                        {include file="$template/includes/captcha.tpl"}
                    </div>
                {/if}
                <input id="login" type="submit" class="btn btn-lg btn-primary btn-block {$captcha->getButtonClass($captchaForm)}" value="{$LANG.loginbutton}" tabindex="4" />
            </form>
        </div>
        {if $linkableProviders}
            <div class="text-lighter text-center text-small text-divider text-social">
                <span>or</span>
            </div>
            <div class="providerLinkingFeedback"></div>
            {include file="$template/includes/linkedaccounts.tpl" linkContext="login" customFeedback=true}
        {/if}
        {if $condlinks.allowClientRegistration}
            <div class="logincontainer-footer">
                <div class="text-light">{$rslang->trans('social.not_member')} <a href="{$WEB_ROOT}/register.php" tabindex="6">{$LANG.orderForm.createAccount}</a></div>
            </div>
        {/if}
    </div>

    {if $languagechangeenabled && count($locales) > 1}
        {include file="$template/includes/language-chooser.tpl" type="login"}   
    {/if}
</div>