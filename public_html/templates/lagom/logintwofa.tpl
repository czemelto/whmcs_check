{if isset($RSThemes.pages.logintwofa)}
    {include file=$RSThemes['pages']['logintwofa']['fullPath']}
{else}
    <div class="main-content col-sm-12">
        {include file="$template/includes/pageheader.tpl" title=$LANG.twofactorauth desc="{$LANG.restrictedpage}" textcenter=true}
        <div class="logincontainer">
            <div class="logincontainer-body">
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
                        {include file="$template/includes/alert.tpl" type="success" msg="$newbackupcode" textcenter=true}
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
    </div>
{/if}