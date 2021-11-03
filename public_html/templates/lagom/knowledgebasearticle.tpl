{if isset($RSThemes.pages.knowledgebasearticle)}
    {include file=$RSThemes['pages']['knowledgebasearticle']['fullPath']}
{else}    
    <div class="article">
        <div class="article-title">   
            <h2>{$kbarticle.title}</h2>
        </div>
        {if $kbarticle.voted}
            {include file="$template/includes/alert.tpl" type="success alert-bordered-left" msg="{lang key="knowledgebaseArticleRatingThanks"}" textcenter=true}
        {/if}
        <div class="article-content">
            {$kbarticle.text}
        </div>
    </div>

    <div class="clearfix"></div>
    {if $kbarticle.editLink}
        <br />
        <br />
        <a href="{$kbarticle.editLink}" class="btn btn-default">
            {$LANG.edit}
        </a>
    {/if}

    <div class="kb-rate-article hidden-print">
        <form action="{routePath('knowledgebase-article-view', {$kbarticle.id}, {$kbarticle.urlfriendlytitle})}" method="post">
            <input type="hidden" name="useful" value="vote">
            <div class="text">
                {if $kbarticle.voted}{$LANG.knowledgebaserating}{else}{$LANG.knowledgebasehelpful}{/if}
                <span><i class="ls ls-heart"></i> {$kbarticle.useful} {$LANG.knowledgebaseratingtext} ({$kbarticle.votes} {$LANG.knowledgebasevotes})</span>
            </div>
            <div>
            {if !$kbarticle.voted}
                <button type="submit" name="vote" value="yes" class="btn btn-info"><i class="ls ls-like"></i> {$LANG.knowledgebaseyes}</button>
                <button type="submit" name="vote" value="no" class="btn btn-info"><i class="ls ls-dislike"></i> {$LANG.knowledgebaseno}</button>
            {/if}
            </div>
        </form>
    </div>

    {if $kbarticles}
        <div class="kb-also-read">
            <h3>{$LANG.knowledgebaserelated}</h3>
            <div class="kbarticles">
                {foreach key=num item=kbarticle from=$kbarticles}
                        <a href="{routePath('knowledgebase-article-view', {$kbarticle.id}, {$kbarticle.urlfriendlytitle})}">
                            {$kbarticle.title} {if $kbarticle.editLink}
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