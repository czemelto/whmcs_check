{if file_exists("templates/$template/overwrites/whois.tpl")}
    {include file="{$template}/overwrites/whois.tpl"}  
{else}   
    {$whois}
{/if}