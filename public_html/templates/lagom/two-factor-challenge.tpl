{if isset($RSThemes['pages']['two-factor-challenge'])}
    {include file=$RSThemes['pages']['two-factor-challenge']['fullPath']}
{else}
    <div class="main-content col-sm-12">
        {include file="$template/includes/pageheader.tpl" title=$LANG.twofactorauth desc="{$LANG.restrictedpage}" textcenter=true}
        <div class="logincontainer">
            <div class="logincontainer-body">
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
    </div>
{/if}

<script>
    jQuery(document).ready(function() {
        jQuery('#loginWithBackupCode').click(function(e) {
            e.preventDefault();
            jQuery('#frmTwoFactorChallenge').addClass('hidden');
            jQuery(this).closest('div').addClass('hidden');
            jQuery(this).closest('.logincontainer-footer').find('#backupCodeCancel').removeClass('hidden');
            jQuery('#frmTwoFactorBackup').removeClass('hidden');
        });
        jQuery('#backupCodeCancel').click(function(e) {
            e.preventDefault();
            jQuery('#frmTwoFactorChallenge').removeClass('hidden');
            jQuery(this).addClass('hidden').siblings('div').removeClass('hidden');
            jQuery('#frmTwoFactorBackup').addClass('hidden');
        });
    });
</script>
