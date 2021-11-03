{if isset($RSThemes.pages.clientareadomaingetepp)}
    {include file=$RSThemes['pages']['clientareadomaingetepp']['fullPath']}
{else}   
    <div class="section">
        <div class="section-header">
            <h3>{$LANG.domaingeteppcode}</h3>
            <p>{$LANG.domaingeteppcodeexplanation}</p>
        </div>
        <div class="section-body">
            {if $error}
                {include file="$template/includes/alert.tpl" type="error" msg=$LANG.domaingeteppcodefailure|cat:" $error"}
            {elseif $eppcode}
                {include file="$template/includes/alert.tpl" type="success" msg=$LANG.domaingeteppcodeis|cat:" $eppcode"}
            {else}
                {include file="$template/includes/alert.tpl" type="success" msg=$LANG.domaingeteppcodeemailconfirmation}
            {/if}
        </div>
    </div>
{/if}    