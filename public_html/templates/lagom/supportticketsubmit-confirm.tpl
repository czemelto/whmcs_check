{if isset($RSThemes['pages']['supportticketsubmit-confirm'])}
    {include file=$RSThemes['pages']['supportticketsubmit-confirm']['fullPath']}
{else}  
    <div class="message message-no-data  message-lg message-success">
        <div class="message-icon">
            <i class="lm lm-check"></i>
        </div>
        <h2 class="message-text"> {$LANG.supportticketsticketcreated} #{$tid}</h2>
        <h6 class="text-center text-light">{$LANG.supportticketsticketcreateddesc}</h6>
        <a href="viewticket.php?tid={$tid}&amp;c={$c}" class="btn btn-default">
            {$LANG.continue} 
        </a>
    </div>
{/if}    
