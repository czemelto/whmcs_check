{assign var="homepageTemplate" value=$RSThemes.pages.homepage.name}

{* =====================================

 PROMOTED PRODUCT GROUPS

 Enter product group IDs, which you want to promote

 ======================================= *}

{assign var=productGroupId value=[

[
'gid' => 1,
'icon' => 'shared-hosting.tpl',
'featured' => false
],
[
'gid' => 2,
'icon' => 'vps-hosting.tpl',
'featured' => true
],
[
'gid' => 13,
'icon' => 'dedicated-servers.tpl',
'featured' => false
]
]}

{foreach from=$productGroupId key=k item=product}
    {if $homepage->productGroup($product.gid)->product}
        {assign var=showGroup value=true}
    {/if}
{/foreach}

{* =====================================

 TESTIMONIALS

 Add new testimonials simply by adding new array records below

 ======================================= *}

{assign var=testimonials value=[
[
'author'=> 'Sonia Stephens',
'avatar' => 'homepage-avatar-1.png',
'website'=> 'lagom.rsstudio.net',
'description' => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquid aperiam, doloremque doloribus impedit incidunt minus natus officiis omnis perspiciatis ullam.'
],
[
'author'=> 'John Doe',
'avatar' => 'homepage-avatar-2.png',
'website'=> 'rsstudio.net',
'description' => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquid aperiam, doloremque doloribus impedit incidunt minus natus officiis omnis perspiciatis ullam.'
],
[
'author'=> 'Alexandra Chapman',
'avatar' => 'homepage-avatar-3.png',
'website'=> 'rsstudio.net',
'description' => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquid aperiam, doloremque doloribus impedit incidunt minus natus officiis omnis perspiciatis ullam.'
],
[
'author'=> 'James Bond',
'avatar' => 'homepage-avatar-4.png',
'website'=> 'lagom.rsstudio.com',
'description' => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquid aperiam, doloremque doloribus impedit incidunt minus natus officiis omnis perspiciatis ullam.'
],
[
'author'=> 'Alice Smith',
'avatar' => 'homepage-avatar-5.png',
'website'=> 'lagom.rsstudio.com',
'description' => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquid aperiam, doloremque doloribus impedit incidunt minus natus officiis omnis perspiciatis ullam.'
],
[
'author'=> 'Emily Turner',
'avatar' => 'homepage-avatar-6.png',
'website'=> 'lagom.rsstudio.com',
'description' => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquid aperiam, doloremque doloribus impedit incidunt minus natus officiis omnis perspiciatis ullam.'
],
[
'author'=> 'Brandon Quinn',
'avatar' => 'homepage-avatar-7.png',
'website'=> 'lagom.rsstudio.com',
'description' => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquid aperiam, doloremque doloribus impedit incidunt minus natus officiis omnis perspiciatis ullam.'
]
]}

{if $RSThemes.layouts.vars.type != "navbar-left"}
<div class="app-main">
    {/if}
    <div class="site site-index">
        {if $homepage->getPromotionExtensionStatus()}
            {include file="$template/core/extensions/PromoBanners/promotion-home.tpl"}
        {else}
            {include file="$template/core/pages/homepage/$homepageTemplate/shared/banner-slider.tpl"}
        {/if}
        {if $productGroupId || $registerdomainenabled}
            <div class="site-section">
                <div class="container">
                    {if $registerdomainenabled}
                        <h2 class="section-title text-center">{$LANG.findyourdomain}</h2>
                        <div class="section-content">
                            <form method="post" action="domainchecker.php" id="frmDomainHomepage">
                                <div class="search-box input-group input-group-lg has-shadow">
                                    <i class="input-group-icon fas fa-search lm lm-search"></i>
                                    <input type="text" class="form-control" name="domain" placeholder="{$LANG.exampledomain}" autocapitalize="none"/>
                                    {if $registerdomainenabled}
                                        <input type="submit" class="btn btn-primary search {if in_array($captcha, ['invisible']) && $captcha->isEnabled() && $captcha->isEnabledForForm($captchaForm)}{$captcha->getButtonClass($captchaForm)}{/if}" value="{$LANG.search}" id="btnDomainSearch"/>
                                    {/if}
                                </div>
                            </form>
                            {if $homepage->getSpotlight()}
                                <div class="featured-tlds row">
                                    {foreach $homepage->getSpotlight() as $domain}
                                        <div class="col-sm">
                                            <div class="domains-package">
                                                <div class="domains-icon">
                                                    {$domain.ext|replace:".":"<span>.</span>"}
                                                </div>
                                                <div class="domains-price">
                                                    <span>{$domain.price}</span>
                                                </div>
                                            </div>
                                        </div>
                                    {/foreach}
                                </div>
                            {/if}
                        </div>
                    {/if}
                    {if $productGroupId && $showGroup}
                        <div class="section-content">
                            <h2 class="section-title text-center">{$rslang->trans('homepage.products.title')}</h2>
                            <div class="row row-eq-height row-eq-height-sm">
                                {foreach from=$productGroupId key=k item=product}
                                    {if $homepage->productGroup($product.gid)->product}
                                        <div class="col-lg-4 col-sm-12">
                                            <div class="package package-lg{if $product.featured} has-shadow{/if}">
                                                <div class="package-icon">
                                                    {if $product.icon|strstr:".tpl"}
                                                        {if file_exists("templates/$template/assets/svg-icon/{$product.icon}")}
                                                            {include file="$template/assets/svg-icon/{$product.icon}"}
                                                        {/if}
                                                    {else}
                                                        <img class="w-100" src="{$WEB_ROOT}/templates/{$template}/assets/img/products/{$product.icon}">
                                                    {/if}
                                                </div>
                                                <h4 class="package-title">{$homepage->productGroup($product.gid)->product->productGroup->name}</h4>
                                                <p class="package-desc">{$homepage->productGroup($product.gid)->product->productGroup->headline}</p>
                                                <div class="package-price">
                                                    <div class="package-starting-from ">{$LANG.startingat}</div>
                                                    <div class="price">
                                                        {$homepage->productGroup($product.gid)->price}
                                                        {if $homepage->productGroup($product.gid)->billing eq 'free'}
                                                        {else}
                                                            <span class="price-cycle">
                                                            {if $homepage->productGroup($product.gid)->billing eq "monthly"}
                                                                /{$rslang->trans('order.period.short.monthly')}
                                                            {elseif $homepage->productGroup($product.gid)->billing eq "quarterly"}
                                                                /{$rslang->trans('order.period.short.quarterly')}
                                                            {elseif $homepage->productGroup($product.gid)->billing eq "semiannually"}
                                                                /{$rslang->trans('order.period.short.semiannually')}
                                                            {elseif $homepage->productGroup($product.gid)->billing eq "annually"}
                                                                /{$rslang->trans('order.period.short.annually')}
                                                            {elseif $homepage->productGroup($product.gid)->billing eq "biennially"}
                                                                /{$rslang->trans('order.period.short.biennially')}
                                                            {elseif $homepage->productGroup($product.gid)->billing eq "triennially"}
                                                                /{$rslang->trans('order.period.short.triennially')}
                                                            {/if}
                                                            </span>
                                                        {/if}
                                                    </div>
                                                </div>
                                                <div class="package-actions">
                                                    <a href="{$systemurl}cart.php?gid={$homepage->productGroup($product.gid)->product->productGroup->id}" class="btn btn-primary" data-target="incoming">{$LANG.getStartedNow}</a>
                                                </div>
                                            </div>
                                        </div>
                                    {/if}
                                {/foreach}
                            </div>
                        </div>
                    {/if}
                </div>
            </div>
        {/if}
        <div class="site-section section-dark">
            <div class="container">
                <h2 class="section-title text-center">{$rslang->trans('homepage.features.title')}</h2>
                <p class="section-subtitle text-center">{$rslang->trans('homepage.features.subtitle')}</p>
                <div class="section-content">
                    <div class="row row-eq-height row-eq-height-xs row-features">
                        <div class="col-lg-3 col-sm-6">
                            <div class="feature feature-xs-left">
                                <div class="feature-icon">
                                    {if file_exists("templates/$template/assets/svg-icon/addon-email-forwarding.tpl")}
                                        {include file="$template/assets/svg-icon/addon-email-forwarding.tpl"}
                                    {/if}
                                </div>
                                <div class="feature-content">
                                    <h4 class="feature-title">{$rslang->trans('homepage.features.feature-1.title')}</h4>
                                    <p class="feature-desc">{$rslang->trans('homepage.features.feature-1.desc')}</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-sm-6">
                            <div class="feature feature-xs-left">
                                <div class="feature-icon">
                                    {if file_exists("templates/$template/assets/svg-icon/increase-SEO-rank.tpl")}
                                        {include file="$template/assets/svg-icon/increase-SEO-rank.tpl"}
                                    {/if}
                                </div>
                                <div class="feature-content">
                                    <h4 class="feature-title">{$rslang->trans('homepage.features.feature-2.title')}</h4>
                                    <p class="feature-desc">{$rslang->trans('homepage.features.feature-2.desc')}</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-sm-6">
                            <div class="feature feature-xs-left">
                                <div class="feature-icon">
                                    {if file_exists("templates/$template/assets/svg-icon/free-reissues.tpl")}
                                        {include file="$template/assets/svg-icon/free-reissues.tpl"}
                                    {/if}
                                </div>
                                <div class="feature-content">
                                    <h4 class="feature-title">{$rslang->trans('homepage.features.feature-3.title')}</h4>
                                    <p class="feature-desc">{$rslang->trans('homepage.features.feature-3.desc')}</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-sm-6">
                            <div class="feature feature-xs-left">
                                <div class="feature-icon">
                                    {if file_exists("templates/$template/assets/svg-icon/seo.tpl")}
                                        {include file="$template/assets/svg-icon/seo.tpl"}
                                    {/if}
                                </div>
                                <div class="feature-content">
                                    <h4 class="feature-title">{$rslang->trans('homepage.features.feature-4.title')}</h4>
                                    <p class="feature-desc">{$rslang->trans('homepage.features.feature-4.desc')}</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-sm-6">
                            <div class="feature feature-xs-left">
                                <div class="feature-icon">
                                    {if file_exists("templates/$template/assets/svg-icon/organization-validation.tpl")}
                                        {include file="$template/assets/svg-icon/organization-validation.tpl"}
                                    {/if}
                                </div>
                                <div class="feature-content">
                                    <h4 class="feature-title">{$rslang->trans('homepage.features.feature-5.title')}</h4>
                                    <p class="feature-desc">{$rslang->trans('homepage.features.feature-5.desc')}</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-sm-6">
                            <div class="feature feature-xs-left">
                                <div class="feature-icon">
                                    {if file_exists("templates/$template/assets/svg-icon/free-reissues.tpl")}
                                        {include file="$template/assets/svg-icon/free-reissues.tpl"}
                                    {/if}
                                </div>
                                <div class="feature-content">
                                    <h4 class="feature-title">{$rslang->trans('homepage.features.feature-6.title')}</h4>
                                    <p class="feature-desc">{$rslang->trans('homepage.features.feature-6.desc')}</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-sm-6">
                            <div class="feature feature-xs-left">
                                <div class="feature-icon">
                                    {if file_exists("templates/$template/assets/svg-icon/encryp-sensitive-data.tpl")}
                                        {include file="$template/assets/svg-icon/encryp-sensitive-data.tpl"}
                                    {/if}
                                </div>
                                <div class="feature-content">
                                    <h4 class="feature-title">{$rslang->trans('homepage.features.feature-7.title')}</h4>
                                    <p class="feature-desc">{$rslang->trans('homepage.features.feature-7.desc')}</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-sm-6">
                            <div class="feature feature-xs-left">
                                <div class="feature-icon">
                                    {if file_exists("templates/$template/assets/svg-icon/content-delivery-network.tpl")}
                                        {include file="$template/assets/svg-icon/content-delivery-network.tpl"}
                                    {/if}
                                </div>
                                <div class="feature-content">
                                    <h4 class="feature-title">{$rslang->trans('homepage.features.feature-8.title')}</h4>
                                    <p class="feature-desc">{$rslang->trans('homepage.features.feature-8.desc')}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        {if $testimonials || $announcements}
            <div class="site-section">
                {if $testimonials}
                    <div class="section-content">
                        <div class="container">
                            <h2 class="section-title text-center">{$rslang->trans('homepage.testimonials.title')}</h2>
                            <p class="section-subtitle text-center">{$rslang->trans('homepage.testimonials.subtitle')}</p>
                            {if $testimonials|@count < 4}
                                <div class="testimonials row row-eq-height">
                                    {foreach from=$testimonials item=testimonial key=testimonial_key}
                                        <div class="col-lg-4">
                                            <div class="testimonials-item has-shadow">
                                                {if file_exists("templates/$template/core/pages/homepage/$homepageTemplate/shared/testimonial.tpl")}
                                                    {include file="$template/core/pages/homepage/$homepageTemplate/shared/testimonial.tpl"}
                                                {/if}
                                            </div>
                                        </div>
                                    {/foreach}
                                </div>
                            {/if}
                            {if $testimonials|@count > 3}
                                <div class="slider testimonials" data-testimonial-slider>
                                    <div class="content-slider" data-slider-container>
                                        <div class="content-slider-wrapper" data-slider-wrapper>
                                            {foreach from=$testimonials item=testimonial key=testimonial_key}
                                                <div class="content-slider-item testimonials-item has-shadow">
                                                    {if file_exists("templates/$template/core/pages/homepage/$homepageTemplate/shared/testimonial.tpl")}
                                                        {include file="$template/core/pages/homepage/$homepageTemplate/shared/testimonial.tpl"}
                                                    {/if}
                                                </div>
                                            {/foreach}
                                        </div>
                                    </div>
                                </div>
                            {/if}
                        </div>
                    </div>
                {/if}
                {if $announcements}
                    <div class="section-content">
                        <div class="container">
                            <h2 class="section-title text-center">{$rslang->trans('homepage.latest_news.title')}</h2>
                            <p class="section-subtitle text-center">{$rslang->trans('homepage.latest_news.subtitle')}</p>
                            <div class="row row-eq-height row-eq-height-xs">
                                {foreach $announcements as $announcement}
                                    <div class="{if $announcements|@count == 2} col-lg-6 col-sm-6{else if $announcements|@count == 3} col-lg-4 col-sm-6{else if $announcements|@count == 1} col-lg-12 col-sm-12{else} col-lg-3 col-sm-6{/if}">
                                        <div class="news-box">
                                            <div class="news-date">
                                                <i class="lm lm-calendar"></i>
                                                <span>{$carbon->translatePassedToFormat($announcement.rawDate, 'M jS')}</span>
                                            </div>
                                            <div class="news-desc">
                                                <p>{$announcement.title}</p>
                                            </div>
                                            <div class="news-actions">
                                                <a href="{routePath('announcement-view', $announcement.id, $announcement.urlfriendlytitle)}">{$LANG.readmore}</a>
                                            </div>
                                        </div>
                                    </div>
                                {/foreach}
                            </div>
                        </div>
                    </div>
                {/if}
            </div>
        {/if}
        <div class="site-section section-dark section-started text-center">
            <div class="container">
                <h2 class="section-title">{$rslang->trans('homepage.get_started.title')}</h2>
                <p class="section-subtitle">{$rslang->trans('homepage.get_started.subtitle')}</p>
                <a href="{$WEB_ROOT}/contact.php" class="btn btn-primary">{$LANG.contactus}</a>
            </div>
        </div>
    </div>
    {if $RSThemes.layouts.vars.type != "navbar-left"}
</div>
{/if}
