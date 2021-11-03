{if file_exists("templates/$template/includes/overwrites/promo-slider.tpl")}
    {include file="{$template}/includes/overwrites/promo-slider.tpl"}  
{else}
    <div class="promo-slider {if $class}{$class}{/if}" data-promo-slider>
        <div class="promo-slider-header">
            <ul class="promo-slider-nav" data-promo-slider-pagination>
            {if $setting == "client-home"}
                {foreach from=$addons_html.0.RSMarketConnectServices item=addon_html key=k name=foo}
                    {if $addon_html.settings.promotion.$setting}
                        <li data-promo-slider-pagination-item>
                            <span class="short-name">
                                {if $addon_html.name == "symantec"}
                                    SSL
                                {elseif $addon_html.name == "weebly"}
                                    W
                                {elseif $addon_html.name == "spamexperts"}
                                    ES
                                {elseif $addon_html.name == "sitelock"}
                                    SL
                                {elseif $addon_html.name == "codeguard"}
                                    CG
                                {elseif $addon_html.name == "sitelockvpn"} 
                                    VPN   
                                {elseif $addon_html.name == "marketgoo"}     
                                    MG
                                {elseif $addon_html.name == "ox"}        
                                    OX
                                {/if}
                            </span>
                            <span class="full-name">
                                {if $addon_html.name == "symantec"}
                                    SSL
                                {elseif $addon_html.name == "weebly"}
                                    Weebly
                                {elseif $addon_html.name == "spamexperts"}
                                    Email Security
                                {elseif $addon_html.name == "sitelock"}
                                    SiteLock
                                {elseif $addon_html.name == "codeguard"}
                                    CodeGuard    
                                {elseif $addon_html.name == "sitelockvpn"}
                                    SiteLock VPN
                                {elseif $addon_html.name == "marketgoo"}     
                                    Marketgoo
                                {elseif $addon_html.name == "ox"}        
                                    OX App Suite   
                                {/if}
                            </span>
                        </li>
                    {/if}
                {/foreach}
            {else}
                {foreach from=$RSMarketConnectServices item=addon_html key=k name=foo}
                    {if $addon_html.settings.promotion.$setting}
                        <li data-promo-slider-pagination-item>
                            <span class="short-name">
                                {if $addon_html.name == "symantec"}
                                    SSL
                                {elseif $addon_html.name == "weebly"}
                                    W
                                {elseif $addon_html.name == "spamexperts"}
                                    ES
                                {elseif $addon_html.name == "sitelock"}
                                    SL
                                {elseif $addon_html.name == "codeguard"}
                                    CG
                                {elseif $addon_html.name == "sitelockvpn"} 
                                    VPN  
                                {elseif $addon_html.name == "marketgoo"}     
                                    MG         
                                {elseif $addon_html.name == "ox"}        
                                    OX
                                {/if}
                            </span>
                            <span class="full-name">
                                {if $addon_html.name == "symantec"}
                                    SSL
                                {elseif $addon_html.name == "weebly"}
                                    Weebly
                                {elseif $addon_html.name == "spamexperts"}
                                    Email Security
                                {elseif $addon_html.name == "sitelock"}
                                    SiteLock
                                {elseif $addon_html.name == "codeguard"}
                                    CodeGuard
                                {elseif $addon_html.name == "sitelockvpn"}
                                    SiteLock VPN    
                                {elseif $addon_html.name == "marketgoo"}     
                                    Marketgoo    
                                 {elseif $addon_html.name == "ox"}        
                                    OX App Suite   
                                {/if}
                            </span>
                        </li>
                    {/if}
                {/foreach}
            {/if}
            </ul>
            <div class="promo-slider-close" data-promo-slide-close data-toggle="tooltip" data-title="Close" data-container="body">
                <i class="ls ls-close"></i>
            </div>
        </div>
        <div class="promo-slider-wrapper">
            <div class="promo-slider-background" data-promo-slider-background>
                <div></div>
                <div></div>
            </div>
            <div class="promo-slider-slides" data-promo-slider-wrapper>
                {if $setting == "client-home"}
                    {foreach from=$addons_html.0.RSMarketConnectServices item=addon_html key=k name=foo}
                        {if $addon_html.settings.promotion.$setting}
                            <a href="{routePath('store-product-group', $addon_html.productGroup.slug)}" class="promo-slider-slide">
                                <div class="promo-slider-body">
                                    <div class="promo-slider-content" data-animation-content>
                                        <h2 class="promo-slider-title">
                                            {$addon_html.productGroup.headline} -
                                            {$addon_html.productGroup.tagline}.
                                        </h2>
                                    </div>
                                    <div class="promo-slider-more" data-animation-more><i class="ls ls-basket"></i>{$rslang->trans('market_connect.order')}</div>
                                </div>
                                <div class="promo-slider-icons" data-animation-icons>
                                    {if $addon_html.name == "symantec"}
                                        {if file_exists("templates/$template/assets/svg-illustrations/products/sitelock.tpl")}
                                            {include file="$template/assets/svg-illustrations/products/sitelock.tpl"}
                                        {/if}
                                    {elseif $addon_html.name == "weebly"}
                                        {if file_exists("templates/$template/assets/svg-illustrations/products/weebly.tpl")}
                                            {include file="$template/assets/svg-illustrations/products/weebly.tpl"}
                                        {/if}
                                    {elseif $addon_html.name == "spamexperts"}
                                        {if file_exists("templates/$template/assets/svg-illustrations/products/spamexperts.tpl")}
                                            {include file="$template/assets/svg-illustrations/products/spamexperts.tpl"}
                                        {/if}
                                    {elseif $addon_html.name == "sitelock"}
                                        {if file_exists("templates/$template/assets/svg-illustrations/products/sitelock.tpl")}
                                            {include file="$template/assets/svg-illustrations/products/sitelock.tpl"}
                                        {/if}
                                    {elseif $addon_html.name == "codeguard"}
                                        {if file_exists("templates/$template/assets/svg-illustrations/products/codeguard.tpl")}
                                            {include file="$template/assets/svg-illustrations/products/codeguard.tpl"}
                                        {/if}
                                    {elseif $addon_html.name == "sitelockvpn"}
                                        {if file_exists("templates/$template/assets/svg-illustrations/products/sitelockvpn.tpl")}
                                            {include file="$template/assets/svg-illustrations/products/sitelockvpn.tpl"}
                                        {/if}  
                                    {elseif $addon_html.name == "marketgoo"}    
                                        {if file_exists("templates/$template/assets/svg-illustrations/products/marketgoo.tpl")}
                                            {include file="$template/assets/svg-illustrations/products/marketgoo.tpl"}
                                        {/if}      
                                    {elseif $addon_html.name == "ox"}    
                                        {if file_exists("templates/$template/assets/svg-illustrations/products/ox.tpl")}
                                            {include file="$template/assets/svg-illustrations/products/ox.tpl"}
                                        {/if}      
                                    {/if}
                                </div>
                            </a>
                        {/if}
                    {/foreach}
                {else}
                    {foreach from=$RSMarketConnectServices item=addon_html key=k name=foo}
                        {if $addon_html.settings.promotion.$setting}
                            <a href="{routePath('store-product-group', $addon_html.productGroup.slug)}" class="promo-slider-slide">
                                <div class="promo-slider-body">
                                    <div class="promo-slider-content" data-animation-content>
                                        <h2 class="promo-slider-title">
                                            {$addon_html.productGroup.headline} -
                                            {$addon_html.productGroup.tagline}.
                                        </h2>
                                    </div>
                                    <div class="promo-slider-more" data-animation-more><i class="ls ls-basket"></i>{$rslang->trans('market_connect.order')}</div>
                                </div>
                                <div class="promo-slider-icons" data-animation-icons>
                                    {if $addon_html.name == "symantec"}
                                        {if file_exists("templates/$template/assets/svg-illustrations/products/sitelock.tpl")}
                                            {include file="$template/assets/svg-illustrations/products/sitelock.tpl"}
                                        {/if}
                                    {elseif $addon_html.name == "weebly"}
                                        {if file_exists("templates/$template/assets/svg-illustrations/products/weebly.tpl")}
                                            {include file="$template/assets/svg-illustrations/products/weebly.tpl"}
                                        {/if}
                                    {elseif $addon_html.name == "spamexperts"}
                                        {if file_exists("templates/$template/assets/svg-illustrations/products/spamexperts.tpl")}
                                            {include file="$template/assets/svg-illustrations/products/spamexperts.tpl"}
                                        {/if}
                                    {elseif $addon_html.name == "sitelock"}
                                        {if file_exists("templates/$template/assets/svg-illustrations/products/sitelock.tpl")}
                                            {include file="$template/assets/svg-illustrations/products/sitelock.tpl"}
                                        {/if}
                                    {elseif $addon_html.name == "codeguard"}
                                        {if file_exists("templates/$template/assets/svg-illustrations/products/codeguard.tpl")}
                                            {include file="$template/assets/svg-illustrations/products/codeguard.tpl"}
                                        {/if}
                                     {elseif $addon_html.name == "sitelockvpn"}
                                        {if file_exists("templates/$template/assets/svg-illustrations/products/sitelockvpn.tpl")}
                                            {include file="$template/assets/svg-illustrations/products/sitelockvpn.tpl"}
                                        {/if}  
                                     {elseif $addon_html.name == "marketgoo"}    
                                        {if file_exists("templates/$template/assets/svg-illustrations/products/marketgoo.tpl")}
                                            {include file="$template/assets/svg-illustrations/products/marketgoo.tpl"}
                                        {/if}    
                                    {elseif $addon_html.name == "ox"}    
                                        {if file_exists("templates/$template/assets/svg-illustrations/products/ox.tpl")}
                                            {include file="$template/assets/svg-illustrations/products/ox.tpl"}
                                        {/if}      
                                    {/if}
                                </div>
                            </a>
                        {/if}
                    {/foreach}
                {/if}
            </div>
        </div>
    </div>
{/if}    