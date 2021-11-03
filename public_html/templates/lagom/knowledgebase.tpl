{if isset($RSThemes.pages.knowledgebase)}
    {include file=$RSThemes['pages']['knowledgebase']['fullPath']}
{else}
    <form role="form" method="post" action="{routePath('knowledgebase-search')}">
        <div class="kb-search">
            <div class="kb-search-wrapper pattern-bg-knowledgebase">
                <div class="input-group search-group">
                    <input type="text" id="inputKnowledgebaseSearch" name="search" class="form-control input-lg" placeholder="{$LANG.howcanwehelp}" />
                    <span class="input-group-btn">
                        <button type="submit" id="btnKnowledgebaseSearch" class="btn btn-lg btn-primary btn-input-padded-responsive"/>{$LANG.search}</button>
                    </span>
                </div>
            </div>
        </div>
    </form>
    <div class="section">
        <h3>{$LANG.knowledgebasecategories}</h3>
        {if $kbcats}
            <div class="kb-category">
                {foreach from=$kbcats name=kbcats item=kbcat}  
                    <a href="{routePath('knowledgebase-category-view', {$kbcat.id}, {$kbcat.urlfriendlyname})}">{$kbcat.name}&nbsp;({$kbcat.numarticles}){if $kbcat.editLink}
                            <button data-href="{$kbcat.editLink}" class="btn btn-default btn-sm">
                                {$LANG.edit}
                            </button>
                        {/if}
                        <p>{$kbcat.description}</p>
                        
                    </a>
                {/foreach}
            </div>
        {else}
            <div class="message message-no-data">
                <div class="message-image">
                    {include file="$template//assets/svg-icon/article.tpl"}
                </div>
                <h6 class="message-text">{$LANG.knowledgebasenoarticles}</h6>
            </div>
        {/if}
    </div>
    {if $kbmostviews}
        <div class="section">
            <h3>{$LANG.knowledgebasepopular}</h3>
            <div class="kbarticles">
                {foreach from=$kbmostviews item=kbarticle}
                    <a href="{routePath('knowledgebase-article-view', {$kbarticle.id}, {$kbarticle.urlfriendlytitle})}">{$kbarticle.title}
                        {if $kbarticle.editLink}
                            <button data-href="{$kbarticle.editLink}" class="btn btn-default btn-sm">
                                {$LANG.edit}
                            </button>
                        {/if}
                        <p>{$kbarticle.article|truncate:100:"..."}</p>
                    </a>
                {/foreach}
            </div>
        </div>
    {/if}
{/if}    