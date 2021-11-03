{if isset($RSThemes.pages.announcements)}
    {include file=$RSThemes['pages']['announcements']['fullPath']}
{else}
    {if $announcementsFbRecommend}
        <script>
            (function(d, s, id) {
                var js, fjs = d.getElementsByTagName(s)[0];
                if (d.getElementById(id)) {
                    return;
                }
                js = d.createElement(s); js.id = id;
                js.src = "//connect.facebook.net/{$LANG.locale}/all.js#xfbml=1";
                fjs.parentNode.insertBefore(js, fjs);
            }(document, 'script', 'facebook-jssdk'));
        </script>
    {/if}

    {if $announcements}
        <div class="annoucements">
        {foreach from=$announcements item=announcement}
            <div class="announcement-item" data-href="{routePath('announcement-view', $announcement.id, $announcement.urlfriendlytitle)}">
                <span class="announcement-title">{$announcement.title}</span>
                <div class="announcement-body">
                    {if $announcement.text|strip_tags|strlen < 350}
                        <p>{$announcement.text}</p>
                    {else}
                        <p>{$announcement.summary}</p>
                    {/if}
                </div> 
                <div class="announcement-footer  d-flex space-between">
                    <span class="btn btn-sm btn-info">{$LANG.readmore}</span>
                    {if $announcement.editLink}
                        <button data-href="{$announcement.editLink}" class="btn btn-info btn-sm">                    
                            {$LANG.edit}
                        </button>
                    {/if}
                    <div class="announcement-details">
                        {if $announcementsFbRecommend}
                            <div class="fb-like hidden-sm hidden-xs" data-layout="standard" data-href="{fqdnRoutePath('announcement-view', $announcement.id, $announcement.urlfriendlytitle)}" data-send="true" data-width="450" data-show-faces="true" data-action="recommend"></div>
                            <div class="fb-like hidden-lg hidden-md" data-layout="button_count" data-href="{fqdnRoutePath('announcement-view', $announcement.id, $announcement.urlfriendlytitle)}" data-send="true" data-width="450" data-show-faces="true" data-action="recommend"></div>
                        {/if}
                        <span class="announcement-date">{$carbon->createFromTimestamp($announcement.timestamp)->format('jS M Y')}</span>
                    </div>
                </div>
            </div>
        {/foreach}
        
        <ul class="pagination">
            {foreach $pagination as $item}
            <li {if $item.active}class="active"{/if}>
                <a href="{$item.link}" {if $item.disabled} disabled="disabled"{/if}>{$item.text}</a>
            </li>
            {/foreach}
        </ul>
       
    </div>
    {else}
        <div class="message message-no-data">
            <div class="message-image">
                {include file="$template//assets/svg-icon/article.tpl"}
            </div>
            <h6 class="message-text">{$LANG.noannouncements}</h6>
        </div>
    {/if}
{/if}    