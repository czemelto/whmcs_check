{if isset($RSThemes['pages']['password-reset-container'])}
    {include file=$RSThemes['pages']['password-reset-container']['fullPath']}
{else}
    <div class="main-content col-sm-12">
        {include file="$template/includes/pageheader.tpl" title=$LANG.pwreset textcenter=true}
        <div class="logincontainer">
            <div class="logincontainer-body">
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
    </div>
{/if}