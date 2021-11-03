{if isset($RSThemes['pages']['access-denied'])}
    {include file=$RSThemes['pages']['access-denied']['fullPath']}
{else}
    <div class="message message-no-data">
        <div class="message-image">
            {include file="$template/assets/svg-icon/protect-user-privacy.tpl"}        
        </div>
        <h2 class="message-text">{$LANG.oops}!</h2>
        <h6 class="m-b-0">{$LANG.subaccountpermissiondenied}</h6>
        {if !empty($allowedpermissions)}
            <div class="well m-t-16 m-b-0 w-100 text-left">
                <p>{$LANG.subaccountallowedperms}</p>
                <ul class="m-b-0">
                    {foreach $allowedpermissions as $permission}
                        <li>{$permission}</li>
                    {/foreach}
                </ul>
            </div>
        {/if}
        <h6 class="message-text ">{$LANG.subaccountcontactmaster}</h6>
        <div>
            <a href="javascript:history.go(-1)" class="btn btn-primary">
                {$LANG.goback}
            </a>
            <a href="index.php" class="btn btn-default">
                {$LANG.returnhome}
            </a>
        </div>
    </div>
{/if}