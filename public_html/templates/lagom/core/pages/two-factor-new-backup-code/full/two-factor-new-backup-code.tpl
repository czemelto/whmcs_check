<div class="main-content col-sm-12">
    {if $RSThemes['pages'][$templatefile]['config']['showLogo'] == '1'}
       {if $RCLogo}
            <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" tabindex="7"><img src="{$WEB_ROOT}/{$RCLogo}" alt="{$companyname}" ></a>
        {elseif $MBLogo}
            <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" tabindex="7"  class="logo"><img src="{$MBLogo}" alt="{$companyname}" ></a>
        {elseif $RSThemes.styles.vars.fullPageOnDarkBg}
            {if $RSThemes.logo_inverse}
                <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" tabindex="7" class="logo"><img src="{$WEB_ROOT}{$RSThemes.logo_inverse}" alt="{$companyname}"/></a>
            {elseif $RSThemes.logo}
                <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" tabindex="7" class="logo"><img src="{$WEB_ROOT}{$RSThemes.logo}" alt="{$companyname}"/></a>
            {elseif $assetLogoPath}
                <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" tabindex="7" class="logo"><img src="{$assetLogoPath}" alt="{$companyname}"/></a>
            {else}
                <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" tabindex="7" class="logo logo-text">{$companyname}</a>
            {/if}
        {else}
            {if $RSThemes.logo}
                <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" tabindex="7" class="logo"><img src="{$WEB_ROOT}{$RSThemes.logo}" alt="{$companyname}"/></a>
            {elseif $assetLogoPath}
                <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" tabindex="7" class="logo"><img src="{$assetLogoPath}" alt="{$companyname}"/></a>
            {else}
                <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" tabindex="7" class="logo logo-text">{$companyname}</a>
            {/if}
        {/if}
    {else}
        {include file="$template/includes/pageheader.tpl" title=$LANG.twofactorauth desc="{$LANG.restrictedpage}" textcenter=true}
    {/if}
    <div class="logincontainer">
        <div class="logincontainer-body">
            {if $RSThemes['pages'][$templatefile]['config']['showLogo'] == '1'}
                {include file="$template/includes/pageheader.tpl" title=$LANG.twofactorauth desc="{$LANG.restrictedpage}" textcenter=true}
            {/if}
            {include file="$template/includes/alert.tpl" type="success" msg=$LANG.twofabackupcodereset textcenter=true}
            <h4 class="text-center">{$LANG.twofanewbackupcodeis}</h4>
            {include file="$template/includes/alert.tpl" type="success" msg=$newBackupCode textcenter=true}
            <p class="text-lighter text-center text-small">{$LANG.twofabackupcodeexpl}</p>
            <a href="{routePath('clientarea-home')}" class="btn btn-primary btn-lg btn-block">
                {$LANG.continue}
            </a>
        </div>
    </div>    
    {if $languagechangeenabled && count($locales) > 1}
        {include file="$template/includes/language-chooser.tpl" type="login"}   
    {/if}    
</div>