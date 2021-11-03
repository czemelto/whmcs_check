{if file_exists("templates/$template/store/ssl/overwrites/index.tpl")}
    {include file="{$template}/store/ssl/overwrites/index.tpl"}
{else}

    <div class="site site-ssl-certificates">
        <div class="site-banner">
            <div class="container">
                <div class="row d-flex">
                    <div class="col-lg-6 col-md-8">
                        <div class="banner-content">
                            <h1 class="banner-title">{lang key="store.ssl.landingPage.title"}</h1>
                            <div class="banner-desc">
                                <p>{lang key="store.ssl.landingPage.tagline1"} {lang key="store.ssl.landingPage.tagline2"}</p>
                            </div>
                            <div class="banner-actions">
                                <a href="#" class="btn btn-lg btn-primary" onclick="smoothScroll('#choose-lvl');return false">{lang key='store.ssl.shared.switch'}</a>
                                <a href="#" class="btn btn-lg btn-outline btn-outline-light" onclick="smoothScroll('#overview');return false">{$LANG.learnmore}</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-4">
                        <div class="banner-graphic">
                            {if file_exists("templates/$template/assets/svg-illustrations/products/sitelock.tpl")}
                                {include file="$template/assets/svg-illustrations/products/sitelock.tpl"}
                            {/if}
                        </div>
                    </div>
                </div>
            </div>
        </div>
        {include file="$template/store/ssl/shared/nav.tpl" current="index"}
        <div class="site-section section-center" id="choose-lvl">
            <div class="container">
                <h2 class="section-title">{lang key="store.ssl.landingPage.chooseLevel"}</h2>
                <div class="section-content">
                    {if count($certificates) > 0}
                        {foreach $certificates as $type => $products}
                            {foreach $products as $product}
                                {if $type == "dv"}
                                    {if $dv_lower}
                                        {if $product->pricing()->best()->yearlyPrice()|replace:$activeCurrency.suffix:""|replace:$activeCurrency.prefix:""|replace:"/`$LANG.pricingCycleShort.annually`":"" < $dv_lower}
                                            {assign var="dv_lower" value=$product->pricing()->best()->yearlyPrice()|replace:$activeCurrency.suffix:""|replace:$activeCurrency.prefix:""|replace:"/`$LANG.pricingCycleShort.annually`":""}
                                        {/if}
                                    {else}
                                        {assign var="dv_lower" value=$product->pricing()->best()->yearlyPrice()|replace:$activeCurrency.suffix:""|replace:$activeCurrency.prefix:""|replace:"/`$LANG.pricingCycleShort.annually`":""}
                                    {/if}
                                {elseif $type == "ov"}
                                    {if $ov_lower}
                                        {if $product->pricing()->best()->yearlyPrice()|replace:$activeCurrency.suffix:""|replace:$activeCurrency.prefix:""|replace:"/`$LANG.pricingCycleShort.annually`":"" < $dv_lower}
                                            {assign var="ov_lower" value=$product->pricing()->best()->yearlyPrice()|replace:$activeCurrency.suffix:""|replace:$activeCurrency.prefix:""|replace:"/`$LANG.pricingCycleShort.annually`":""}
                                        {/if}
                                    {else}
                                        {assign var="ov_lower" value=$product->pricing()->best()->yearlyPrice()|replace:$activeCurrency.suffix:""|replace:$activeCurrency.prefix:""|replace:"/`$LANG.pricingCycleShort.annually`":""}
                                    {/if}
                                {elseif $type == "ev"}
                                    {if $ev_lower}
                                        {if $product->pricing()->best()->yearlyPrice()|replace:$activeCurrency.suffix:""|replace:$activeCurrency.prefix:""|replace:"/`$LANG.pricingCycleShort.annually`":"" < $dv_lower}
                                            {assign var="ev_lower" value=$product->pricing()->best()->yearlyPrice()|replace:$activeCurrency.suffix:""|replace:$activeCurrency.prefix:""|replace:"/`$LANG.pricingCycleShort.annually`":""}
                                        {/if}
                                    {else}
                                        {assign var="ev_lower" value=$product->pricing()->best()->yearlyPrice()|replace:$activeCurrency.suffix:""|replace:$activeCurrency.prefix:""|replace:"/`$LANG.pricingCycleShort.annually`":""}
                                    {/if}
                                {/if}
                            {/foreach}
                        {/foreach}
                    {/if}
                    <div class="row row-eq-height row-eq-height-sm">
                        <div class="col-lg-4 col-sm-12">
                            <div class="package has-shadow">
                                <div class="package-icon"> {if file_exists("templates/$template/assets/svg-icon/domain-validation.tpl")}
                                        {include file="$template/assets/svg-icon/domain-validation.tpl"}
                                    {/if}
                                </div>
                                <h4 class="package-title">{lang key="store.ssl.landingPage.dv"}</h4>
                                <p class="package-desc">{lang key="store.ssl.landingPage.dvInformation"}</p>
                                <div class="package-price">
                                    <div class="package-starting-from">{$LANG.startingfrom}</div>
                                    <div class="price">
                                        {if $activeCurrency.prefix}<span class="price-prefix">{$activeCurrency.prefix}</span>{/if}{$dv_lower}{if $activeCurrency.suffix}{$activeCurrency.suffix}{/if}<span class="price-cycle">/{$LANG.pricingCycleShort.annually}</span>
                                    </div>
                                </div>
                                <div class="package-actions">
                                    <a href="{routePath('store-product-group', $routePathSlug, 'dv')}" class="btn btn-primary">{$LANG.learnmore}</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-12">
                            <div class="package">
                                <div class="package-icon">
                                    {if file_exists("templates/$template/assets/svg-icon/organization-validation.tpl")}
                                        {include file="$template/assets/svg-icon/organization-validation.tpl"}
                                    {/if}
                                </div>
                                <h4 class="package-title">{lang key="store.ssl.landingPage.ov"}</h4>
                                <p class="package-desc">{lang key="store.ssl.landingPage.ovInformation"}</p>
                                <div class="package-price">
                                    <div class="package-starting-from">{$LANG.startingfrom}</div>
                                    <div class="price">
                                        {if $activeCurrency.prefix}<span class="price-prefix">{$activeCurrency.prefix}</span>{/if}{$ov_lower}{if $activeCurrency.suffix}{$activeCurrency.suffix}{/if}<span class="price-cycle">/{$LANG.pricingCycleShort.annually}</span>
                                    </div>
                                </div>
                                <div class="package-actions">
                                    <a href="{routePath('store-product-group', $routePathSlug, 'ov')}" class="btn btn-primary">{$LANG.learnmore}</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-12">
                            <div class="package">
                                <div class="package-icon"> {if file_exists("templates/$template/assets/svg-icon/extended-validation.tpl")}
                                        {include file="$template/assets/svg-icon/extended-validation.tpl"}
                                    {/if}
                                </div>
                                <h4 class="package-title">{lang key="store.ssl.landingPage.ev"}</h4>
                                <p class="package-desc">{lang key="store.ssl.landingPage.evInformation"}</p>
                                <div class="package-price">
                                    <div class="package-starting-from">{$LANG.startingfrom}</div>
                                    <div class="price">
                                        {if $activeCurrency.prefix}<span class="price-prefix">{$activeCurrency.prefix}</span>{/if}{$ev_lower}{if $activeCurrency.suffix}{$activeCurrency.suffix}{/if}<span class="price-cycle">/{$LANG.pricingCycleShort.annually}</span>
                                    </div>
                                </div>
                                <div class="package-actions">
                                    <a href="{routePath('store-product-group', $routePathSlug, 'ev')}" class="btn btn-primary">{$LANG.learnmore}</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <p class="show-all-btn">
                    <a href="#" class="show-all" onclick="smoothScroll('#all')"> {lang key="store.ssl.shared.helpMeChoose"}<i class="ls ls-arrow-down"></i></a>
                </p>
            </div>
        </div>
        <div class="site-section" id="overview">
            <div class="container">
                <div class="section-content">
                    <div class="container">
                        <div class="row d-flex-align f-flow">
                            <div class="col-md-6">
                                <h2 class="section-title">{lang key="store.ssl.landingPage.what"}</h2>
                                <div class="section-desc">
                                    <p>{lang key="store.ssl.landingPage.whatInfo"}</p>
                                    <ul class="check-list">
                                        <li> <i class="lm lm-check"></i> {lang key="store.ssl.landingPage.secureConnection"} </li>
                                        <li> <i class="lm lm-check"></i> {lang key="store.ssl.landingPage.encrypts"} </li>
                                        <li> <i class="lm lm-check"></i> {lang key="store.ssl.landingPage.padlock"} </li>
                                        <li> <i class="lm lm-check"></i> {lang key="store.ssl.landingPage.authenticates"} </li>
                                    </ul>
                                    <p>{lang key="store.ssl.landingPage.certTypeInfo" dvLink=routePath('store-product-group', $routePathSlug, 'dv') ovLink=routePath('store-product-group', $routePathSlug, 'ov') evLink=routePath('store-product-group', $routePathSlug, 'ev')}</p>
                                </div>
                            </div>
                            <div class="col-md-6 section-graphic section-graphic-right">
                                <div class="browser browser-sm has-shadow">
                                    <div class="browser-top">
                                        <div class="browser-actions"><span></span><span></span><span></span></div>
                                    </div>
                                    {if file_exists("templates/$template/assets/svg-icon/store/SSL/ssl-preview-2.tpl")}
                                        {include file="$template/assets/svg-icon/store/SSL/ssl-preview-2.tpl"}
                                    {/if}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="section-content">
                    <div class="container">
                        <div class="row d-flex-align f-flow">
                            <div class="section-graphic col-md-6">
                                <div class="browser browser-sm has-shadow">
                                    <div class="browser-top">
                                        <div class="browser-actions"><span></span><span></span><span></span></div>
                                    </div>
                                    {if file_exists("templates/$template/assets/svg-icon/store/SSL/ssl-preview-1.tpl")}
                                        {include file="$template/assets/svg-icon/store/SSL/ssl-preview-1.tpl"}
                                    {/if}
                                </div>
                            </div>
                            <div class="col-md-6">
                                <h2 class="section-title">{lang key="store.ssl.landingPage.benefits.title"}</h2>
                                <div class="section-desc">
                                    <p><strong>{lang key="store.ssl.landingPage.benefits.subtitle"}</strong></p>
                                    <p>{lang key="store.ssl.landingPage.benefits.higherResults"}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="site-section">
            <div class="container">
                <h2 class="section-title text-center">{lang key="store.ssl.landingPage.benefits.reasons"}:</h2>
                <div class="section-content">
                    <div class="m-w-928 m-h-a">
                        <div class="row row-eq-height-xs row-features">
                            <div class="col-lg-4 col-md-4 col-sm-6 m-safari">
                                <div class="feature feature-xs-left">
                                    <div class="feature-icon">
                                        {if file_exists("templates/$template/assets/svg-icon/encryp-sensitive-data.tpl")}
                                            {include file="$template/assets/svg-icon/encryp-sensitive-data.tpl"}
                                        {/if}
                                    </div>
                                    <h3 class="feature-title">{lang key="store.ssl.landingPage.benefits.encrypt"}</h3>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-6 m-safari">
                                <div class="feature feature-xs-left">
                                    <div class="feature-icon">
                                        {if file_exists("templates/$template/assets/svg-icon/protect-user-privacy.tpl")}
                                            {include file="$template/assets/svg-icon/protect-user-privacy.tpl"}
                                        {/if}
                                    </div>
                                    <h3 class="feature-title">{lang key="store.ssl.landingPage.benefits.privacy"}</h3>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-6 m-safari">
                                <div class="feature feature-xs-left">
                                    <div class="feature-icon">
                                        {if file_exists("templates/$template/assets/svg-icon/secure-online-transactions.tpl")}
                                            {include file="$template/assets/svg-icon/secure-online-transactions.tpl"}
                                        {/if}
                                    </div>
                                    <h3 class="feature-title">{lang key="store.ssl.landingPage.benefits.secure"}</h3>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-6 m-safari">
                                <div class="feature feature-xs-left">
                                    <div class="feature-icon">
                                        {if file_exists("templates/$template/assets/svg-icon/prove-legitimacy.tpl")}
                                            {include file="$template/assets/svg-icon/prove-legitimacy.tpl"}
                                        {/if}
                                    </div>
                                    <h3 class="feature-title">{lang key="store.ssl.landingPage.benefits.legitimacy"}</h3>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-6 m-safari">
                                <div class="feature feature-xs-left">
                                    <div class="feature-icon">
                                        {if file_exists("templates/$template/assets/svg-icon/activate-HTTPS-and-the-lock-icon.tpl")}
                                            {include file="$template/assets/svg-icon/activate-HTTPS-and-the-lock-icon.tpl"}
                                        {/if}
                                    </div>
                                    <h3 class="feature-title">{lang key="store.ssl.landingPage.benefits.https"}</h3>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-6 m-safari">
                                <div class="feature feature-xs-left">
                                    <div class="feature-icon">
                                        {if file_exists("templates/$template/assets/svg-icon/increase-SEO-rank.tpl")}
                                            {include file="$template/assets/svg-icon/increase-SEO-rank.tpl"}
                                        {/if}
                                    </div>
                                    <h3 class="feature-title">{lang key="store.ssl.landingPage.benefits.seo"}</h3>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="site-section section-dark section-center section-ssl-upgrade">
            <div class="container">
                <h2 class="section-title">{lang key="store.ssl.landingPage.browser.title"}</h2>
                <div class="section-content">
                    <div class="browser browser-lg browser-ssl has-shadow">
                        <div class="browser-top">
                            <div class="browser-actions"> <span></span> <span></span> <span></span> </div>
                            <div class="browser-searchbar">
                                <span><span class="text-danger">http://</span>yourwebsite.com</span>
                            </div>
                        </div>
                        <div class="browser-body">
                            <div class="browser-notice">
                                <div class="browser-image"> <img src="{$WEB_ROOT}/assets/img/marketconnect/symantec/padlock-x.png"> </div>
                                <p>{lang key="store.ssl.landingPage.browser.insecureNotice"}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="ssl-upgrade">
                <h3 class="section-title">{lang key="store.ssl.landingPage.secureInMinutes"}</h3>
            </div>
        </div>
        <div class="site-section">
            <div class="container">
                <h2 class="section-title text-center">{lang key="store.ssl.landingPage.help.title"}</h2>
                <p class="section-subtitle text-center">{lang key="store.ssl.landingPage.help.guide"}</p>
                <div class="section-content">
                    <div class="row d-flex-align f-flow">
                        <div class="col-md-6">
                            <h3 class="section-title">{lang key="store.ssl.landingPage.help.dv.title"}</h3>
                            <div class="section-desc">
                                <ul>
                                    <li>{lang key="store.ssl.landingPage.help.dv.verify"}</li>
                                    <li>{lang key="store.ssl.landingPage.help.dv.issued"}</li>
                                    <li>{lang key="store.ssl.landingPage.help.dv.compliance"}</li>
                                </ul>
                                <p><b class="text-dark">{lang key="store.ssl.landingPage.help.dv.for"}</b></p>
                                <p>{lang key="store.ssl.landingPage.help.dv.type"}</p>
                                <a href="{routePath('store-product-group', $routePathSlug, 'dv')}" class="btn btn-info">{$LANG.store.ssl.landingPage.help.dv.browse}</a>
                            </div>
                        </div>
                        <div class="col-md-6 section-graphic section-graphic-right">
                            <div class="browser browser-sm has-shadow">
                                {if file_exists("templates/$template/assets/svg-illustrations/store/ssl/library-card.tpl")}
                                    {include file="$template/assets/svg-illustrations/store/ssl/library-card.tpl"}
                                {/if}
                            </div>
                        </div>
                    </div>
                </div>
                <div class="section-content">
                    <div class="row d-flex-align f-flow">
                        <div class="col-md-6 section-graphic">
                            <div class="browser browser-sm has-shadow">
                                {if file_exists("templates/$template/assets/svg-illustrations/store/ssl/driver-license.tpl")}
                                    {include file="$template/assets/svg-illustrations/store/ssl/driver-license.tpl"}
                                {/if}
                            </div>
                        </div>
                        <div class="col-md-6">
                            <h3 class="section-title">{lang key="store.ssl.landingPage.help.ov.title"}</h3>
                            <div class="section-desc">

                                <ul>
                                    <li>{lang key="store.ssl.landingPage.help.ov.verify"}</li>
                                    <li>{lang key="store.ssl.landingPage.help.ov.issued"}</li>
                                    <li>{lang key="store.ssl.landingPage.help.ov.compliance"}</li>
                                </ul>

                                <p><b class="text-dark">{lang key="store.ssl.landingPage.help.ov.for"}</b></p>
                                <p>{lang key="store.ssl.landingPage.help.ov.type"}</p>
                                <a href="{routePath('store-product-group', $routePathSlug, 'ov')}" class="btn btn-info">{$LANG.store.ssl.landingPage.help.ov.browse}</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="section-content">
                    <div class="row d-flex-align f-flow">
                        <div class="col-md-6">
                            <h3 class="section-title">{lang key="store.ssl.landingPage.help.ev.title"}</h3>
                            <div class="section-desc">
                                <ul>
                                    <li>{lang key="store.ssl.landingPage.help.ev.verify"}</li>
                                    <li>{lang key="store.ssl.landingPage.help.ev.issued"}</li>
                                    <li>{lang key="store.ssl.landingPage.help.ev.compliance"}</li>
                                </ul>
                                <p><b class="text-dark">{lang key="store.ssl.landingPage.help.ev.for"}</b></p>
                                <p>{lang key="store.ssl.landingPage.help.ev.type"}</p>
                                <a href="{routePath('store-product-group', $routePathSlug, 'ev')}" class="btn btn-info">{$LANG.store.ssl.landingPage.help.ev.browse}</a>
                            </div>
                        </div>
                        <div class="col-md-6 section-graphic section-graphic-right">
                            <div class="browser browser-sm has-shadow">
                                {if file_exists("templates/$template/assets/svg-illustrations/store/ssl/passport.tpl")}
                                    {include file="$template/assets/svg-illustrations/store/ssl/passport.tpl"}
                                {/if}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="site-section">
            <div class="container">
                <h2 class="section-title text-center">{$LANG.store.ssl.title}</h2>
                <div class="section-content ssl-filters" id="all">
                    {include file="$template/store/ssl/shared/ssl-filters.tpl" current="index"}
                    <div class="row row-eq-height" data-filter-grid>
                        {if count($certificates) > 0}
                            {foreach $certificates as $type => $products}
                                {foreach $products as $product}
                                    <div class="col-md-6 col-sm-12 filtr-item" data-groups='["{$type}"]'>
                                        <div class="package package-horizontal package-ssl">
                                            <h4 class="package-name">{$product->name}</h4>
                                            <div class="package-content">
                                                <p>{$product->description}</p>
                                            </div>
                                            <div class="package-footer">
                                                <div class="package-price">
                                                    <div class="package-starting-from ">{$LANG.startingfrom}</div>
                                                    <div class="price">
                                                        {if $activeCurrency.prefix}<span class="price-prefix">{$activeCurrency.prefix}</span>{/if}{$product->pricing()->best()->yearlyPrice()|replace:$activeCurrency.suffix:""|replace:$activeCurrency.prefix:""|replace:"/`$LANG.pricingCycleShort.annually`":""}{if $activeCurrency.suffix}{$activeCurrency.suffix}{/if}<span class="price-cycle">/{$LANG.pricingCycleShort.annually}</span>
                                                    </div>
                                                </div>
                                                <div class="package-actions">
                                                    <a href="{routePath("store-product-group", $routePathSlug, $type)}" class="btn btn-default btn-outline">{$LANG.learnmore}</a>
                                                    <form method="post" action="{routePath('cart-order')}">
                                                        <input type="hidden" name="pid" value="{$product->id}">
                                                        <button type="submit" class="btn btn-primary btn-block">{lang key="store.ssl.landingPage.buyNow"}</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                {/foreach}
                            {/foreach}
                        {elseif $inPreview}
                            <div class="lead text-center"> {lang key="store.ssl.shared.noProducts"} </div>
                        {/if}
                    </div>
                </div>
            </div>
        </div>
        <div class="site-section">
            <div class="container">
                <h2 class="section-title text-center">{lang key="store.websiteBuilder.faq.title"}</h2>
                <div class="section-content m-w-md m-a">
                    <div id="accordion">
                        <div class="panel panel-default panel-accordion is-open">
                            <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#what_is_an_SSL_Certificate" aria-expanded="true">
                                <h4 class="panel-title"><i class="lm lm-plus"></i>{lang key="store.ssl.landingPage.faq.q1"}</h4>
                            </div>
                            <div id="what_is_an_SSL_Certificate" class="panel-collapse collapse in" aria-expanded="true" style="">
                                <div class="panel-body">
                                    <p>{lang key="store.ssl.landingPage.faq.a1"}</p>
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default panel-accordion">
                            <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#why_do_i_need_codeGuard" aria-expanded="true">
                                <h4 class="panel-title"><i class="lm lm-plus"></i>{lang key="store.ssl.landingPage.faq.q2"}</h4>
                            </div>
                            <div id="why_do_i_need_codeGuard" class="panel-collapse collapse" aria-expanded="true" style="">
                                <div class="panel-body">
                                    <p>{lang key="store.ssl.landingPage.faq.a2"}</p>
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default panel-accordion">
                            <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#what_are_the_different_types_of_SSL" aria-expanded="true">
                                <h4 class="panel-title"><i class="lm lm-plus"></i>{lang key="store.ssl.landingPage.faq.q3"}</h4>
                            </div>
                            <div id="what_are_the_different_types_of_SSL" class="panel-collapse collapse" aria-expanded="true" style="">
                                <div class="panel-body">
                                    <p>{lang key="store.ssl.landingPage.faq.a3"}</p>
                                </div>
                            </div>
                        </div>
                        {if count($certificates.wildcard) > 0 || $inPreview}
                            <div class="panel panel-default panel-accordion">
                                <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#what_is_a_Wildcard_SSL_Certificate" aria-expanded="true">
                                    <h4 class="panel-title"><i class="lm lm-plus"></i>{lang key="store.ssl.landingPage.faq.q4"}</h4>
                                </div>
                                <div id="what_is_a_Wildcard_SSL_Certificate" class="panel-collapse collapse" aria-expanded="true" style="">
                                    <div class="panel-body">
                                        <p>{lang key="store.ssl.landingPage.faq.a4"} <a href="{routePath('store-product-group', $routePathSlug, 'wildcard')}">{lang key="learnmore"}</a></p>
                                    </div>
                                </div>
                            </div>
                        {/if}
                        {if count($certificates.ev) > 0 || $inPreview}
                            <div class="panel panel-default panel-accordion">
                                <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#what_are_the_advantages_of_an_EV_SSL_Certificate" aria-expanded="true">
                                    <h4 class="panel-title"><i class="lm lm-plus"></i>{lang key="store.ssl.landingPage.faq.q5"}</h4>
                                </div>
                                <div id="what_are_the_advantages_of_an_EV_SSL_Certificate" class="panel-collapse collapse" aria-expanded="true" style="">
                                    <div class="panel-body">
                                        <p>{lang key="store.ssl.landingPage.faq.a5"}</p>
                                    </div>
                                </div>
                            </div>
                        {/if}
                    </div>
                </div>
            </div>
        </div>
        {include file="$template/store/ssl/shared/logos.tpl"}
        {*{include file="$template/get-started.tpl"} *}
    </div>
    <script>
        $(function() {

            $('.show-all').click(function(e) {
                e.preventDefault();
                if (!$('#collapseAllCerts').hasClass('in')) {
                    $('#collapseAllCerts').collapse('show');
                }
                $('html, body').animate({
                    scrollTop: $('#sslDetail').offset().top
                }, 500);
            });
        });
    </script>
{/if}
