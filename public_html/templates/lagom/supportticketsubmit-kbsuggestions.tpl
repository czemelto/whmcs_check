{if file_exists("templates/$template/overwrites/supportticketsubmit-kbsuggestions.tpl")}
    {include file="{$template}/overwrites/supportticketsubmit-kbsuggestions.tpl"}  
{else} 
    <h3>{$LANG.kbsuggestions}</h3>

    <p>{$LANG.kbsuggestionsexplanation}</p>

    <div class="kbarticles">
        {foreach from=$kbarticles item=kbarticle}
            <a href="knowledgebase.php?action=displayarticle&id={$kbarticle.id}" target="_blank">{$kbarticle.title}
                <p>{$kbarticle.article}...</p>
            </a>
        {/foreach}
    </div>
{/if}
