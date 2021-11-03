{if $homepage->getMarketConnectCount() == 1}
<style>
    .site.site-index .site-banner {
        padding-bottom: 100px;
    }
</style>
{/if}
{if $homepage->getMarketConnectCount() != 0 && !empty($homepage->getPromotionBanner())}
<div data-promo-slider>
    <div class="site-banner site-slider">
        <div class="slider-background" data-promo-slider-background>
            <div></div>
            <div></div>
        </div>
        <div class="container">
            <div class="d-flex">
                <div class="slider-wrapper">
                    <div class="slider-slides" data-promo-slider-wrapper>
                        {foreach from=$homepage->getPromotionBanner() item=item}
                            {if  strpos($item.settings, '"client-home":true,"') != false}
                                <div class="slider-slide row">
                                    <div class="col-lg-6 col-md-7">
                                        <div class="banner-content" data-animation-content>
                                            <h1 class="banner-title">{$item['headline']}</h1>
                                            <div class="banner-desc">
                                                <p>{$item['tagline']}</p>
                                            </div>
                                            <div class="banner-actions">
                                                <a href="{$systemurl}cart.php?a=add&pid={$item['pid']}" class="btn btn-lg btn-primary">{$LANG.getStartedNow}</a>
                                                <a href="{routePath('store-product-group', $item['slug'])}" class="btn btn-lg btn-outline btn-outline-light">{$LANG.learnmore}</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-md-5">
                                        <div class="banner-graphic" data-animation-icons>
                                            {if file_exists("templates/$template/assets/svg-illustrations/products/{$item['name']}.tpl")}
                                                {include file="$template/assets/svg-illustrations/products/{$item['name']}.tpl"}
                                            {/if}
                                        </div>
                                    </div>
                                </div>
                            {/if}
                        {/foreach}
                    </div>
                </div>
            </div>
        </div>
    </div>
    {if $homepage->getMarketConnectCount() > 1}
    <div class="site-section section-slider-btn">
        <div class="container">
            <div class="section-content">
                <div class="slider-navigation row" data-promo-slider-pagination>
                    {foreach from=$homepage->getPromotionBanner() item=item}
                        {if  strpos($item.settings, '"client-home":true,"') != false}
                            <div class="col-lg">
                                <div class="tile has-shadow" data-promo-slider-pagination-item>                     
                                    {if file_exists("templates/$template/assets/svg-icon/{$item['name']}.tpl")}
                                        {include file="$template/assets/svg-icon/{$item['name']}.tpl"}
                                    {/if}
                                    <span class="title">{$item['tabname']}</span>
                                </div>
                            </div>
                        {/if}
                    {/foreach}
                </div>
            </div>
        </div>
    </div>
    {/if}
</div>
{/if}