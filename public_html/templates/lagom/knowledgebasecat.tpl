{if isset($RSThemes.pages.knowledgebasecat)}
    {include file=$RSThemes['pages']['knowledgebasecat']['fullPath']}
{else}       
    <form role="form" method="post" action="{routePath('knowledgebase-search')}">
        <div class="kb-search">
            <div class="kb-search-wrapper pattern-bg-knowledgebase">
                <div class="input-group search-group">
                    <input type="text" id="inputKnowledgebaseSearch" name="search" class="form-control input-lg" placeholder="{$LANG.howcanwehelp}" value="{$searchterm}" />
                    <span class="input-group-btn">
                        <button type="submit" id="btnKnowledgebaseSearch" class="btn btn-lg btn-primary btn-input-padded-responsive"/>{$LANG.search}</button>
                    </span>
                </div>
            </div>
        </div>
    </form>

    {if $kbcats}
        <div class="section">
            <h3>{$LANG.knowledgebasecategories}</h3>
            <div class="kb-category">
                {foreach name=kbasecats from=$kbcats item=kbcat}
                    <a href="{routePath('knowledgebase-category-view',{$kbcat.id},{$kbcat.urlfriendlyname})}">{$kbcat.name} ({$kbcat.numarticles})
                    {if $kbcat.editLink}
                    <button data-href="{$kbcat.editLink}" class="btn btn-default btn-sm">
                            {$LANG.edit}
                        </button>
                    {/if}
                        <p>{$kbcat.description}</p>
                    </a>
                {/foreach}
            </div>
        </div> 
    {/if}

    {if $kbarticles || !$kbcats}
        <div class="section">
            {if $tag}
                <h3>{$LANG.kbviewingarticlestagged} '{$tag}'</h3>
            {else}
                <h3>{$LANG.knowledgebasearticles}</h3>
            {/if}
            {if $kbarticles}
                <div class="kbarticles">
                    {foreach from=$kbarticles item=kbarticle}
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
            {else}
                <div class="message message-no-data">
                    <div class="message-image">
                        {include file="$template//assets/svg-icon/article.tpl"}
                    </div>
                    <h6 class="message-text">{$LANG.knowledgebasenoarticles}</h6>
                </div>
            {/if}
        </div>
    {/if}
{/if}    