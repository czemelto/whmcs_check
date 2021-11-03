{if file_exists("templates/$template/store/weebly/overwrites/index.tpl")}
    {include file="{$template}/store/weebly/overwrites/index.tpl"}  
{else}    
    <div class="site site-webbly">
        <div class="site-banner">
            <div class="container">
                <div class="row d-flex">
                    <div class="col-lg-6 col-md-8">
                        <div class="banner-content">
                            <h1 class="banner-title">{lang key="store.websiteBuilder.headline"} </h1>
                            <div class="banner-desc">
                                <p>{lang key="store.websiteBuilder.tagline"}</p>
                            </div>
                            <div class="banner-actions">
                                <a href="#" class="btn btn-lg btn-primary" onclick="smoothScroll('#pricing'); return false">{$LANG.clientareaaddonpricing}</a>
                                <a href="#" class="btn btn-lg btn-outline btn-outline-light" onclick="smoothScroll('#overview'); return false">{$LANG.learnmore}</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-4">
                        <div class="banner-graphic"> 
                            {if file_exists("templates/$template/assets/svg-illustrations/products/weebly.tpl")}
                                {include file="$template/assets/svg-illustrations/products/weebly.tpl"}
                            {/if}
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="site-section" id="overview">
            <div class="container">
                <div class="section-content">
                    <div class="row d-flex-align f-flow">
                        <div class="col-md-6 section-graphic">
                            <div class="browser browser-sm has-shadow">
                                <div class="browser-top">
                                    <div class="browser-actions"><span></span><span></span><span></span></div>
                                </div>
                                {if file_exists("templates/$template/assets/svg-icon/store/Weebly/weebly-preview-1.tpl")}
                                    {include file="$template/assets/svg-icon/store/Weebly/weebly-preview-1.tpl"}
                                {/if}
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="section-content">
                                <h2 class="section-title">{lang key="store.websiteBuilder.ddEditor"}</h2>
                                <div class="section-desc">
                                    <p>{lang key="store.websiteBuilder.introduction"}</p>
                                    <p>{lang key="store.websiteBuilder.ddEditorDescription"}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="section-content">
                    <div class="row row-eq-height row-features justify-center">
                        <div class="col-lg col-md-6 col-sm-6">
                            <div class="feature feature-boxed feature-left">
                                <div class="feature-icon">
                                    {if file_exists("templates/$template/assets/svg-icon/drag-drop-builder.tpl")}
                                        {include file="$template/assets/svg-icon/drag-drop-builder.tpl"}
                                    {/if}
                                </div>
                                <div class="feature-content">
                                    <h4 class="feature-title">{lang key="store.websiteBuilder.ddEditor"}</h4>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg col-md-6 col-sm-6">
                            <div class="feature feature-boxed feature-left">
                                <div class="feature-icon">
                                    {if file_exists("templates/$template/assets/svg-icon/unlimited-pages.tpl")}
                                        {include file="$template/assets/svg-icon/unlimited-pages.tpl"}
                                    {/if}
                                </div>
                                <div class="feature-content">
                                    <h4 class="feature-title">{lang key="store.websiteBuilder.pricing.features.pages"}</h4>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg col-md-6 col-sm-6">
                            <div class="feature feature-boxed feature-left">
                                <div class="feature-icon">
                                    {if file_exists("templates/$template/assets/svg-icon/trusted-by-over-40.tpl")}
                                        {include file="$template/assets/svg-icon/trusted-by-over-40.tpl"}
                                    {/if}
                                </div>
                                <div class="feature-content">
                                    <h4 class="feature-title">{lang key="store.websiteBuilder.trust"}</h4>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>              
        <div class="site-section section-dark section-pricing" id="pricing">
            <div class="container">
                <h2 class="section-title text-center">{lang key="store.websiteBuilder.tab.pricing"}</h2>
                    <div class="row text-center">
                        <div class="cycle-switcher col-sm-12 currency-flex">
                            <div class="btn-group" role="group">
                                {foreach $billingCycles as $cycle}
                                    
                                <button type="button" class="btn btn-default cycle-change{if $cycle@first} active{/if}" data-cycle="{$cycle}"> {lang key={'orderpaymentterm'|cat:$cycle}} </button>
                                {/foreach} 
                            </div>
                            <div class="currency-selector">
                                {if !$loggedin && $currencies}
                                    <form method="post" action="">
                                        <select name="currency" class="form-control" onchange="submit();">
                                            <option>{lang key="changeCurrency"} ({$activeCurrency.prefix} {$activeCurrency.code})</option>

                                            {foreach $currencies as $currency}

                                                <option value="{$currency['id']}">{$currency['prefix']} {$currency['code']}</option>

                                            {/foreach}

                                        </select>
                                    </form>
                                {/if}
                            </div>
                        </div>
                    </div>
                    {if $litePlan}
                        <div class="weebly-lite-plan package">
                            <h4 class="package-title">{lang key="store.websiteBuilder.pricing.free.headline"}</h4>
                            <p class="package-subtitle">{lang key="store.websiteBuilder.pricing.free.tagline"}</p>
                            <div class="package-price">
                                {foreach $litePlan->pricing()->allAvailableCycles() as $pricing}
                                    <span class="pricing-text price {$pricing->cycle()}">{$pricing->toFullString()}</span></span>
                                {foreachelse}
                                    {if $inPreview}
                                        <span class="pricing-text price">-</span>
                                    {/if}
                                {/foreach}
                                <span class="pricing-text not-available hidden">-</span>
                            </div>
                            <p class="package-features">{$litePlan->description}</p>
                            <form method="post" action="{routePath('cart-order')}" class="package-actions">
                                <input type="hidden" name="pid" value="{$litePlan->id}">
                                <input type="hidden" name="billingcycle" value="">
                                <button type="submit" class="btn btn-primary btn-lg btn-signup">
                                    {lang key='getStartedNow'}
                                </button>
                            </form>
                        </div>
                    {/if}

                        <div class="row row-eq-height row-eq-height-sm"> 
                            {if count($products) > 0}
                                {foreach $products as $key => $product}
                                    <div class="{if count($products) == 1}col-sm-6 col-sm-offset-3{elseif count($products) == 2}col-sm-5{if $key == 0} col-sm-offset-1{/if}{else}col-lg-4 col-md-6 col-sm-12{/if}">
                                        <div class="package">
                                            <h4 class="package-title">{$product->name}</h4>
                                            <p class="package-subtitle">{lang key="store.websiteBuilder.pricing.idealFor" for=$product->idealFor}</p>
                                            <div class="package-price">{foreach $product->pricing()->allAvailableCycles() as $pricing}<span class="pricing-text price {$pricing->cycle()}{if !$pricing@first} hidden{/if}">{if $activeCurrency.prefix}<span class='price-prefix'>{$activeCurrency.prefix}</span>{/if}{$pricing->price()->toSuffixed()}<span class="price-cycle" id="pricingCycle">{if $pricing->cycle() eq "monthly"}/{$rslang->trans('order.period.short.monthly')}{elseif $pricing->cycle() eq "quarterly"}/{$rslang->trans('order.period.short.quarterly')}{elseif $pricing->cycle() eq "semiannually"}/{$rslang->trans('order.period.short.semiannually')}{elseif $pricing->cycle() eq "annually"}/{$rslang->trans('order.period.short.annually')}{elseif $pricing->cycle() eq "biennially"}/{$rslang->trans('order.period.short.biennially')}{elseif $pricing->cycle() eq "triennially"}/{$rslang->trans('order.period.short.triennially')}{/if}</span></span>{foreachelse}{if $inPreview}<span class="pricing-text price">-</span>{/if}{/foreach}<span class="pricing-text price not-available hidden">-</span></div> 
                                            <ul class="package-features">
                                                <li class="features-heading">{lang key='store.websiteBuilder.pricing.siteFeatures'}</li>
                                                {foreach $product->siteFeatures as $langKey => $feature}
                                                    <li>{lang key="store.websiteBuilder.pricing.features.$langKey"}</li>
                                                {/foreach}
                                                <li class="features-heading">{lang key='store.websiteBuilder.pricing.eCommerceFeatures'}</li>
                                                {foreach $product->ecommerceFeatures as $langKey => $feature}
                                                    <li>{lang key="store.websiteBuilder.pricing.features.$langKey"}</li>
                                                {/foreach}
                                            </ul>
                                            <div class="package-actions">
                                                <form method="post" action="{routePath('cart-order')}">
                                                    <input type="hidden" name="pid" value="{$product->id}">
                                                    <input type="hidden" name="billingcycle" value="">
                                                    <button type="submit" class="btn btn-primary btn-lg">{lang key='signup'}</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                    {if count($products)> 4 && ($key % 3 == 0)}</div><div class="row plans">{/if}
                                {/foreach}
                            {elseif $inPreview}
                                <div class="col-xs-12 lead text-center">{lang key='store.websiteBuilder.admin.Preview'}</div>
                            {/if}
                        </div>
                    </div>
                </div>
                <div class="site-section">
                    <div class="container">
                        <div class="section-content">
                            <div class="row row-eq-height row-eq-height-xs row-features">
                                <div class="col-md-3 col-sm-6">
                                    <div class="feature feature-xs-left">
                                        <div class="feature-icon">
                                            {if file_exists("templates/$template/assets/svg-icon/builder.tpl")}
                                                {include file="$template/assets/svg-icon/builder.tpl"}
                                            {/if}
                                        </div>
                                        <div class="feature-content">
                                            <h4 class="feature-title">{lang key="store.websiteBuilder.features.builder"}</h4>
                                            <p class="feature-desc">{lang key="store.websiteBuilder.features.builderDescription"}</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 col-sm-6">
                                    <div class="feature feature-xs-left">
                                        <div class="feature-icon">
                                            {if file_exists("templates/$template/assets/svg-icon/ecommerce.tpl")}
                                                {include file="$template/assets/svg-icon/ecommerce.tpl"}
                                            {/if}
                                        </div>
                                        <div class="feature-content">
                                            <h4 class="feature-title">{lang key="store.websiteBuilder.features.ecommerce"}</h4>
                                            <p class="feature-desc">{lang key="store.websiteBuilder.features.ecommerceDescription"}</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 col-sm-6">
                                    <div class="feature feature-xs-left">
                                        <div class="feature-icon">
                                            {if file_exists("templates/$template/assets/svg-icon/forms.tpl")}
                                                {include file="$template/assets/svg-icon/forms.tpl"}
                                            {/if}
                                        </div>
                                        <div class="feature-content">
                                            <h4 class="feature-title">{lang key="store.websiteBuilder.features.forms"}</h4>
                                            <p class="feature-desc">{lang key="store.websiteBuilder.features.formsDescription"}</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 col-sm-6">
                                    <div class="feature feature-xs-left">
                                        <div class="feature-icon">
                                            {if file_exists("templates/$template/assets/svg-icon/templates.tpl")}
                                                {include file="$template/assets/svg-icon/templates.tpl"}
                                            {/if}
                                        </div>
                                        <div class="feature-content">
                                            <h4 class="feature-title">{lang key="store.websiteBuilder.features.templates"}</h4>
                                            <p class="feature-desc">{lang key="store.websiteBuilder.features.templatesDescription"}</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 col-sm-6">
                                    <div class="feature feature-xs-left">
                                        <div class="feature-icon">
                                            {if file_exists("templates/$template/assets/svg-icon/photos.tpl")}
                                                {include file="$template/assets/svg-icon/photos.tpl"}
                                            {/if}
                                        </div>
                                        <div class="feature-content">
                                            <h4 class="feature-title">{lang key="store.websiteBuilder.features.gallery"}</h4>
                                            <p class="feature-desc">{lang key="store.websiteBuilder.features.galleryDescription"}</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 col-sm-6">
                                    <div class="feature feature-xs-left">
                                        <div class="feature-icon">
                                            {if file_exists("templates/$template/assets/svg-icon/blogging.tpl")}
                                                {include file="$template/assets/svg-icon/blogging.tpl"}
                                            {/if}
                                        </div>
                                        <div class="feature-content">
                                            <h4 class="feature-title">{lang key="store.websiteBuilder.features.blogging"}</h4>
                                            <p class="feature-desc">{lang key="store.websiteBuilder.features.bloggingDescription"}</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 col-sm-6">
                                    <div class="feature feature-xs-left">
                                        <div class="feature-icon">
                                            {if file_exists("templates/$template/assets/svg-icon/video.tpl")}
                                                {include file="$template/assets/svg-icon/video.tpl"}
                                            {/if}
                                        </div>
                                        <div class="feature-content">
                                            <h4 class="feature-title">{lang key="store.websiteBuilder.features.video"}</h4>
                                            <p class="feature-desc">{lang key="store.websiteBuilder.features.videoDescription"}</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 col-sm-6">
                                    <div class="feature feature-xs-left">
                                        <div class="feature-icon">
                                            {if file_exists("templates/$template/assets/svg-icon/seo.tpl")}
                                                {include file="$template/assets/svg-icon/seo.tpl"}
                                            {/if}
                                        </div>
                                        <div class="feature-content">
                                            <h4 class="feature-title">{lang key="store.websiteBuilder.features.seo"}</h4>
                                            <p class="feature-desc">{lang key="store.websiteBuilder.features.seoDescription"}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>            
                <div class="site-section">
                    <div class="container">
                        <h2 class="section-title text-center">{lang key="store.websiteBuilder.faq.title"}</h2>
                        <div class="section-content m-w-md m-a">
                            <div id="accordion">
                                {foreach [1,2,3,4,5,6,7,8] as $columns}
                                    <div class="panel panel-default panel-accordion">
                                        {foreach $columns as $row}
                                        <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#{$row}" aria-expanded="true">
                                            <h4 class="panel-title"><i class="lm lm-plus"></i>{lang key="store.websiteBuilder.faq.q$row"}</h4>
                                        </div>
                                        <div id="{$row}" class="panel-collapse collapse" aria-expanded="true" style="">
                                            <div class="panel-body">
                                                <p>{lang key="store.websiteBuilder.faq.a$row"}</p>
                                            </div>
                                        </div>
                                            {if $row@last && $row != 8}
                                                <div class="hidden-md hidden-lg"></div>
                                            {else}
                                            {/if}
                                        {/foreach}
                                    </div>
                                {/foreach}
                            </div>
                        </div>
                    </div> 
                </div>
                <div class="site-section">
                    <div class="container"> 
                        <div class="row">
                            <div class="col-md-12 text-center">
                                <h2 class="section-title">
                                    {if $LANG.store.websiteBuilder.trust|strstr:"40,000,000"}
                                        {$LANG.store.websiteBuilder.trust|replace:'4':'<span class="text-primary">4'|replace:"0 ":"0</span> "}
                                    {else}
                                        {lang key='store.websiteBuilder.trust'}
                                    {/if}
                                </h2> 
                                <img class="logo"src="{$WEB_ROOT}/assets/img/marketconnect/weebly/logo.png" width="260px"> 
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    <script src="{$WEB_ROOT}/templates/{$template}/store/weebly/master.js"></script> 
{/if}