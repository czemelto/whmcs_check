{if isset($RSThemes.pages.logout)}
    {include file=$RSThemes['pages']['logout']['fullPath']}
{else}
    <div class="main-content col-sm-12">
        <div class="logincontainer">
            <div class="logincontainer-body">
                {include file="$template/includes/message.tpl" type="success" msg=$LANG.logoutsuccessful}
                <div class="text-center">
                    <a href="index.php" class="btn btn-default">{$LANG.logoutcontinuetext}</a>
                </div>    
            </div>
        </div>
    </div>
{/if}