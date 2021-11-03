{if isset($RSThemes.pages.downloadscat)}
    {include file=$RSThemes['pages']['downloadscat']['fullPath']}
{else}   
    <form role="form" method="post" action="{routePath('download-search')}">
        <div class="kb-search">
            <div class="kb-search-wrapper pattern-bg-downloads">
                <div class="input-group search-group">
                    <input type="text" name="search" id="inputDownloadsSearch" class="form-control input-lg" placeholder="{$LANG.downloadssearch}" value="{$search}"/>
                    <span class="input-group-btn">
                        <button type="submit" id="btnDownloadsSearch" class="btn btn-lg btn-primary btn-input-padded-responsive" />{$LANG.search}</button>
                    </span>
                </div>
            </div>
            <p class="desc">{$LANG.downloadsintrotext}</p>
        </div>
    </form>

    {if $dlcats}
        <div class="section">
            <h3>{$LANG.knowledgebasecategories}</h3>
            <div class="kb-category"> 
                {foreach $dlcats as $dlcat}
                    <a href="{routePath('download-by-cat', $dlcat.id, $dlcat.urlfriendlyname)}">{$dlcat.name}({$dlcat.numarticles})
                        <p>{$dlcat.description}</p>
                    </a>
                {/foreach}
            </div>
        </div>
    {/if}

    {if $downloads}
        <div class="section">
            <h3>{$LANG.downloadsfiles}</h3>
            <div class="kbarticles kbdownloads">
                {foreach $downloads as $download}
                    <a href="{$download.link}">
                        {$download.title}
                        {if $download.clientsonly}
                            <i class="ls ls-padlock text-muted"></i>
                        {/if}
                        <p>{$download.filesize}<i class="ls ls-bullet-small"></i>{$download.description}</p>
                    </a>
                {/foreach}
            </div>
        </div>
    {else}
        <div class="section">
            <div class="message message-no-data">
                <div class="message-image">
                    {include file="$template//assets/svg-icon/downloads.tpl"}
                </div>
                <h6 class="message-text">{$LANG.downloadsnone}</h6>
            </div>
        </div>
    {/if}
{/if}