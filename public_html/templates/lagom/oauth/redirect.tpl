{if file_exists("templates/$template/includes/oauth/redirect.tpl")}
    {include file="{$template}/includes/oauth/redirect.tpl"}  
{else} 
    <div class="message message-no-data check">
        <div class="message-image">
            {include file="$template/includes/loader.tpl"}            
        </div>
        <h6 class="message-text">{lang key='oauth.redirectDescriptionOne'}  {lang key='oauth.redirectDescriptionTwo'} <a href="#"{lang key='oauth.redirectDescriptionThree'}</a></h6>
    </div>   
{/if}
