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
        {include file="$template/includes/pageheader.tpl" title=$LANG.twofactorauth desc="{$LANG.restrictedpage}" textcenter=true}
    {/if}
    <div class="logincontainer">
        <div class="logincontainer-body">
            {if $RSThemes['pages'][$templatefile]['config']['showLogo'] == '1'}
                {include file="$template/includes/pageheader.tpl" title=$LANG.twofactorauth desc="{$LANG.restrictedpage}" textcenter=true}
            {/if}
            {if $newbackupcode}
                {include file="$template/includes/alert.tpl" type="success" msg=$LANG.twofabackupcodereset textcenter=true}
            {elseif $incorrect}
                {include file="$template/includes/alert.tpl" type="error" msg=$LANG.twofa2ndfactorincorrect textcenter=true}
            {elseif $error}
                {include file="$template/includes/alert.tpl" type="error" msg=$error textcenter=true}
            {else}
                <p class="text-lighter text-center text-small">{$LANG.twofa2ndfactorreq}</p>
            {/if}
            <form method="post" action="{$systemsslurl}dologin.php" id="frmLogin">
                {if $newbackupcode}
                    <input type="hidden" name="newbackupcode" value="1" />
                    <h4 class="text-center">{$LANG.twofanewbackupcodeis}</h4>
                    {include file="$template/includes/alert.tpl" type="success" msg="asdadasda$newbackupcode" textcenter=true}
                    <p class="text-lighter text-center text-small">{$LANG.twofabackupcodeexpl}</p>
                    <input type="submit" value="{$LANG.continue}" class="btn btn-primary btn-block" />
                {elseif $backupcode}
                    <input type="text" name="code" class="form-control" placeholder="{$LANG.twofabackupcodelogin}">
                    <br/>
                    <input id="login" type="submit" class="btn btn-primary btn-block" value="{$LANG.loginbutton}" />
                    <input type="hidden" name="backupcode" value="1" />
                {else}
                    <div class="form-group">
                        {$challenge}
                    </div>
                {/if}
            </form>
        </div>
        {if !$newbackupcode && !$backupcode}
            <div class="logincontainer-footer text-center">
                <div class="text-light">{$LANG.twofacantaccess2ndfactor} <br/><a href="clientarea.php?backupcode=1">{$LANG.twofaloginusingbackupcode}</a></div>
            </div>
        {/if}
    </div>     
    {if $languagechangeenabled && count($locales) > 1}
        {include file="$template/includes/language-chooser.tpl" type="login"}   
    {/if}       
</div>