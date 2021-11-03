{if isset($RSThemes['pages']['user-switch-account-forced'])}
    {include file=$RSThemes['pages']['user-switch-account-forced']['fullPath']}
{else} 
    <div class="message message-no-data">
        <div class="message-image">
            {include file="$template/assets/svg-icon/protect-user-privacy.tpl"}        
        </div>
        <h6 class="message-text">{lang key="switchAccount.forcedSwitchRequest"}</h6>
        {if !empty($allowedpermissions)}
            <div class="well m-t-16 w-100 text-center">
                <b>{$requiredClient->fullName} </b>
                {if $requiredClient->companyName}
                    ({$requiredClient->companyName})
                {/if}
                <br />
                {$requiredClient->email}
            </div>
        {/if}
        <form method="post" action="{routePath('user-accounts')}">
            <input type="hidden" name="id" value="{$requiredClient->id}" >
            <button type="submit" class="btn btn-primary bnt-">
                {lang key="continue"}
            </button>
            <a class="btn btn-default" href="{routePath('clientarea-home')}">{lang key="switchAccount.cancelAndReturn"}</a>
        </form>
    </div>
{/if}    