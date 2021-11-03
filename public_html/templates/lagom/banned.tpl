{if isset($RSThemes.pages.banned)}
    {include file=$RSThemes['pages']['banned']['fullPath']}
{else}
    <div class="message message-danger message-lg message-no-data ">
        <div class="message-icon">
            <i class="lm lm-close"></i>
        </div>
        <h2 class="message-text">{$LANG.bannedyourip} {$ip} {$LANG.bannedhasbeenbanned}</h2>
        <h4>{$LANG.bannedbanreason}: <strong>{$reason}</strong></h4>
        <h5>{$LANG.bannedbanexpires}: {$expires}</h5>
    </div>
{/if}