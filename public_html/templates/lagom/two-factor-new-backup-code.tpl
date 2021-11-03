{if isset($RSThemes['pages']['two-factor-new-backup-code'])}
    {include file=$RSThemes['pages']['two-factor-new-backup-code']['fullPath']}
{else}
    <div class="main-content col-sm-12">
        {include file="$template/includes/pageheader.tpl" title=$LANG.twofactorauth desc="{$LANG.restrictedpage}" textcenter=true}
        <div class="logincontainer">
            <div class="logincontainer-body">
                {include file="$template/includes/alert.tpl" type="success" msg=$LANG.twofabackupcodereset textcenter=true}
                <h4 class="text-center">{$LANG.twofanewbackupcodeis}</h4>
                {include file="$template/includes/alert.tpl" type="success" msg=$newBackupCode textcenter=true}
                <p class="text-lighter text-center text-small">{$LANG.twofabackupcodeexpl}</p>
                <a href="{routePath('clientarea-home')}" class="btn btn-primary btn-lg btn-block">
                    {$LANG.continue}
                </a>
            </div>
        </div>    
    </div>
{/if}