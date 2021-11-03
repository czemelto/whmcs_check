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
            {include file="$template/includes/flashmessage.tpl" align="center"}
            {if $newbackupcode}
                {include file="$template/includes/alert.tpl" type="success" msg=$LANG.twofabackupcodereset textcenter=true}
            {elseif $incorrect}
                {include file="$template/includes/alert.tpl" type="error" msg=$LANG.twofa2ndfactorincorrect textcenter=true}
            {elseif $error}
                {include file="$template/includes/alert.tpl" type="error" msg=$error textcenter=true}
            {else}
                <p class="text-lighter text-center text-small">{$LANG.twofa2ndfactorreq}</p>
            {/if}
            <form method="post" action="{routePath('login-two-factor-challenge-verify')}" id="frmTwoFactorChallenge"{if $usingBackup} class="hidden"{/if}>
                <div class="form-group m-b-0">
                    {$challenge}
                </div>
            </form>
            <form method="post" action="{routePath('login-two-factor-challenge-backup-verify')}" id="frmTwoFactorBackup"{if !$usingBackup} class="hidden"{/if}>
                <div class="form-group m-b-24">
                    <input type="text" name="twofabackupcode" class="form-control input-lg" placeholder="{$LANG.twofabackupcodelogin}">
                </div>
                <button type="submit" class="btn btn-primary btn-lg btn-block" id="btnLogin">
                    {$LANG.loginbutton}
                </button>
                
            </form>
        </div>
        <div class="logincontainer-footer text-center">
            <div class="text-light {if $usingBackup}hidden{/if}">{$LANG.twofacantaccess2ndfactor} <br/><a href="#" id="loginWithBackupCode">{$LANG.twofaloginusingbackupcode}</a></div>
            <a class="btn btn-link btn-block {if !$usingBackup}hidden{/if}" href="#" id="backupCodeCancel">
                {lang key='cancel'}
            </a>
        </div>
    </div>   
    {if $languagechangeenabled && count($locales) > 1}
        {include file="$template/includes/language-chooser.tpl" type="login"}   
    {/if}     
</div>