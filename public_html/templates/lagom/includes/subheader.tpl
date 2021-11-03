{if file_exists("templates/$template/includes/overwrites/subheader.tpl")}
    {include file="{$template}/includes/overwrites/subheader.tpl"}  
{else}
    <h2>{$title}</h2>
{/if}