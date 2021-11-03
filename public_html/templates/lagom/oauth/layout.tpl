{if file_exists("templates/$template/includes/oauth/layout.tpl")}
    {include file="{$template}/includes/oauth/layout.tpl"}  
{else}      
    {include file="{$template}/header.tpl"}

    {$content}
       
   {include file="{$template}/footer.tpl"}
{/if}