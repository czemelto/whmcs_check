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
    <div class="logincontainer">
        <div class="logincontainer-body">
            {if $RSThemes['pages'][$templatefile]['config']['showLogo'] == '1'}
                {include file="$template/includes/pageheader.tpl" title=$LANG.pwreset textcenter=true}
            {/if}
            {if $loggedin && $innerTemplate}
                {include file="$template/includes/alert.tpl" type="error" msg=$LANG.noPasswordResetWhenLoggedIn textcenter=true}
            {else}
                {if $successMessage}
                    {include file="$template/includes/message.tpl" type="success" msg=$successTitle textcenter=true}
                    <div class="text-lighter text-center text-small">{$successMessage}</div>
                {else}
                    {if $errorMessage}
                        {include file="$template/includes/alert.tpl" type="error" msg=$errorMessage textcenter=true}
                    {/if}
                    {if $innerTemplate}
                        {include file="$template/password-reset-$innerTemplate.tpl"}
                    {/if}
                {/if}
            {/if}
        </div>
        {if $condlinks.allowClientRegistration}
            <div class="logincontainer-footer">
                <div class="text-light">{$rslang->trans('social.not_member')} <a href="{$WEB_ROOT}/register.php">{$LANG.orderForm.createAccount}</a></div>
            </div>
        {/if}
    </div>   
    {if $languagechangeenabled && count($locales) > 1}
        {include file="$template/includes/language-chooser.tpl" type="login"}   
    {/if}         
</div>