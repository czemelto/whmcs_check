{if file_exists("templates/$template/store/spamexperts/overwrites/index.tpl")}
    {include file="{$template}/store/spamexperts/overwrites/index.tpl"}  
{else} 
<div class="site site-spamexperts">
    <div class="site-banner">
        <div class="container">
            <div class="row d-flex">
                <div class="col-lg-6 col-md-8">
                    <div class="banner-content">
                        <h1 class="banner-title"> {lang key="store.emailServices.headline"} </h1>
                        <div class="banner-desc">
                            <p>{lang key="store.emailServices.tagline"}</p>
                        </div>
                        <div class="banner-actions">
                            <a href="#" class="btn btn-lg btn-primary" onclick="smoothScroll('#pricing'); return false">{$LANG.clientareaaddonpricing}</a>
                            <a href="#" class="btn btn-lg btn-outline btn-outline-light" onclick="smoothScroll('#overview'); return false">{$LANG.learnmore}</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-4">
                    <div class="banner-graphic"> 
                        {if file_exists("templates/$template/assets/svg-illustrations/products/spamexperts.tpl")}
                            {include file="$template/assets/svg-illustrations/products/spamexperts.tpl"}
                        {/if}
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="site-section" id="overview">
        <div class="container">
            <h2 class="section-title text-center">{lang key="store.emailServices.tagline"}</h2>
            <div class="section-content">
                {if $numberOfFeaturedProducts > 0}
                    <div class="row row-eq-height row-eq-height-sm">
                        {if $products.incoming}
                            <div class="{if $numberOfFeaturedProducts == 1}col-sm-6 col-sm-offset-3{elseif $numberOfFeaturedProducts == 2}col-sm-6{else}col-lg-4 col-sm-12 col-md-12{/if}">
                                <div class="package">
                                    <div class="package-icon">
                                        {if file_exists("templates/$template/assets/svg-icon/incoming-email-filtering.tpl")}
                                            {include file="$template/assets/svg-icon/incoming-email-filtering.tpl"}
                                        {/if}
                                    </div>
                                    <h4 class="package-title">{lang key="store.emailServices.incoming.title"}</h4>
                                    <p class="package-desc">{lang key="store.emailServices.overview.incoming.tagline"}</p>
                                    {if $products.incoming->pricing()->best()}
                                    <div class="package-price">
                                        <div class="package-starting-from ">{$LANG.startingfrom}</div>
                                            {assign var="prodCycle" value="/"|explode:$products.incoming->pricing()->best()->toFullString()}
                                            <div class="price">
                                                {if $activeCurrency.prefix}<span class='price-prefix'>{$activeCurrency.prefix}</span>{/if}{$products.incoming->pricing()->best()->toFullString()|replace:'/':''|replace:$prodCycle[1]:''|replace:$activeCurrency.suffix:""|replace:$activeCurrency.prefix:""}{$activeCurrency.suffix}<span class="price-cycle">/{$prodCycle[1]}</span></span>  
                                            </div>
                                            <div class="package-billing-cycle">{$LANG.metrics.pricePer|replace:$LANG.domainprice:""|lower} {lang key="store.emailServices.domain"}</div>
                                    </div>
                                    {elseif $inPreview}
                                        <div class="package-price"><div class="price">-</div></div>
                                    {/if}                                   
                                    <div class="package-actions"> 
                                        <a href="#" class="btn btn-primary btn-buy" data-target="incoming">{lang key="store.emailServices.overview.buy"}</a>
                                        <a href="#" class="package-learn-more" data-target="incoming">{lang key="store.emailServices.overview.learn"}</a> 
                                    </div>
                                </div>
                            </div>            
                        {/if}
                        {if $products.outgoing}
                            <div class="{if $numberOfFeaturedProducts == 1}col-sm-6 col-sm-offset-3{elseif $numberOfFeaturedProducts == 2}col-sm-6{else}col-lg-4 col-sm-12 col-md-12{/if}">
                                <div class="package has-shadow">
                                    <div class="package-icon">
                                        {if file_exists("templates/$template/assets/svg-icon/outgoing-email-filtering.tpl")}
                                            {include file="$template/assets/svg-icon/outgoing-email-filtering.tpl"}
                                        {/if}
                                    </div>
                                    <h4 class="package-title">{lang key="store.emailServices.outgoing.title"}</h4>
                                    <p class="package-desc">{lang key="store.emailServices.overview.outgoing.tagline"}</p>
                                    {if $products.outgoing->pricing()->best()}
                                    <div class="package-price">   
                                        <div class="package-starting-from ">{$LANG.startingfrom}</div>
                                        {assign var="prodCycle" value="/"|explode:$products.outgoing->pricing()->best()->toFullString()}
                                        <div class="price">
                                            {if $activeCurrency.prefix}<span class='price-prefix'>{$activeCurrency.prefix}</span>{/if}{$products.outgoing->pricing()->best()->toFullString()|replace:'/':''|replace:$prodCycle[1]:''|replace:$activeCurrency.suffix:""|replace:$activeCurrency.prefix:""}{$activeCurrency.suffix}<span class="price-cycle">/{$prodCycle[1]}</span></span>
                                        </div>
                                        <div class="package-billing-cycle">{$LANG.metrics.pricePer|replace:$LANG.domainprice:""|lower} {lang key="store.emailServices.domain"}</div>
                                    </div>
                                    {elseif $inPreview}
                                        <div class="package-price"><div class="price">-</div></div>
                                    {/if}   
                                <div class="package-actions"> 
                                    <a href="#" class="btn btn-primary btn-buy" data-target="outgoing">{lang key="store.emailServices.overview.buy"}</a>
                                    <a href="#" class="package-learn-more" data-target="outgoing">{lang key="store.emailServices.overview.learn"}</a>
                                </div>
                            </div>
                        </div>
                        {/if}
                        {if $products.incomingarchiving || $products.outgoingarchiving || $products.incomingoutgoingarchiving}
                            <div class="{if $numberOfFeaturedProducts == 1}col-sm-6 col-sm-offset-3{elseif $numberOfFeaturedProducts == 2}col-sm-6{else}col-lg-4 col-sm-12 col-md-12{/if}">
                                <div class="package">
                                    <div class="package-icon">
                                        {if file_exists("templates/$template/assets/svg-icon/email-archiving.tpl")}
                                            {include file="$template/assets/svg-icon/email-archiving.tpl"}
                                        {/if}
                                    </div>
                                    <h4 class="package-title">{lang key="store.emailServices.archiving.title"}</h4>
                                    <p class="package-desc">{lang key="store.emailServices.overview.archiving.tagline"}</p>
                                    {if $products.incomingarchiving && $products.incomingarchiving->pricing()->best()}
                                        <div class="package-price">
                                            <div class="package-starting-from ">{$LANG.startingfrom}</div>
                                            {assign var="prodCycle" value="/"|explode:$products.incomingarchiving->pricing()->best()->toFullString()}
                                            <div class="price">
                                                {if $activeCurrency.prefix}<span class='price-prefix'>{$activeCurrency.prefix}</span>{/if}{$products.incomingarchiving->pricing()->best()->toFullString()|replace:'/':''|replace:$prodCycle[1]:''|replace:$activeCurrency.suffix:""|replace:$activeCurrency.prefix:""}{$activeCurrency.suffix}<span class="price-cycle">/{$prodCycle[1]}</span></span>                                       
                                            </div>
                                            <div class="package-billing-cycle">{$LANG.metrics.pricePer|replace:$LANG.domainprice:""|lower} {lang key="store.emailServices.domain"}</div>
                                        </div>
                                    {elseif $products.outgoingarchiving && $products.outgoingarchiving->pricing()->best()}
                                        <div class="package-price">
                                            <div class="package-starting-from ">{$LANG.startingfrom}</div>
                                            {assign var="prodCycle" value="/"|explode:$products.outgoingarchiving->pricing()->best()->toFullString()}
                                            <div class="price">
                                                {if $activeCurrency.prefix}<span class='price-prefix'>{$activeCurrency.prefix}</span>{/if}{$products.outgoingarchiving->pricing()->best()->toFullString()|replace:'/':''|replace:$prodCycle[1]:''|replace:$activeCurrency.suffix:""|replace:$activeCurrency.prefix:""}{$activeCurrency.suffix}<span class="price-cycle">/{$prodCycle[1]}</span></span> 
                                            </div>                                                
                                            <div class="package-billing-cycle">{$LANG.metrics.pricePer|replace:$LANG.domainprice:""|lower} {lang key="store.emailServices.domain"}</div>
                                        </div>
                                    {elseif $products.incomingoutgoingarchiving->pricing()->best()}
                                        <div class="package-price">
                                            <div class="package-starting-from ">{$LANG.startingfrom}</div>
                                            {assign var="prodCycle" value="/"|explode:$products.incomingoutgoingarchiving->pricing()->best()->toFullString()}
                                            <div class="price">
                                                {if $activeCurrency.prefix}<span class='price-prefix'>{$activeCurrency.prefix}</span>{/if}{$products.incomingoutgoingarchiving->pricing()->best()->toFullString()|replace:'/':''|replace:$prodCycle[1]:''|replace:$activeCurrency.suffix:""|replace:$activeCurrency.prefix:""}{$activeCurrency.suffix}<span class="price-cycle">/{$prodCycle[1]}</span></span>                          
                                            </div>                                                 
                                            <div class="package-billing-cycle">{$LANG.metrics.pricePer|replace:$LANG.domainprice:""|lower} {lang key="store.emailServices.domain"}</div> 
                                        </div>
                                    {elseif $inPreview}
                                        <div class="package-price"><div class="price">-</div></div>
                                    {/if}      
                                    <div class="package-actions"> 
                                        <a href="#" class="btn btn-primary btn-buy" data-target="incomingoutgoingarchiving">{lang key="store.emailServices.overview.buy"}</a> 
                                        <a href="#" class="package-learn-more" data-target="archiving">{lang key="store.emailServices.overview.learn"}</a> 
                                    </div>
                                </div>
                            </div>
                        {/if}
                    </div>
                {elseif $inPreview}
                    <div class="text-center lead preview-text">{lang key="store.emailServices.preview"}</div>
                {/if}
            </div>    
        </div>
    </div>
    <div class="tabs" id="howitworks">
        <div class="container">
            <ul class="nav nav-tabs" role="tablist">
                {if $products.incoming || $inPreview}
                    <li role="presentation" class="active"> <a href="#incoming" aria-controls="incoming" role="tab" data-toggle="tab">{lang key="store.emailServices.incoming.title"}</a> </li>
                {/if}
                    {if $products.outgoing || $inPreview}
                    <li role="presentation"> <a href="#outgoing" aria-controls="outgoing" role="tab" data-toggle="tab">{lang key="store.emailServices.outgoing.title"}</a> </li>
                    {/if}
                    {if $products.incomingarchiving || $products.incomingoutgoingarchiving || $products.outgoingarchiving || $inPreview}
                    <li role="presentation"> <a href="#archiving" aria-controls="archiving" role="tab" data-toggle="tab">{lang key="store.emailServices.archiving.title"}</a> </li>
                    {/if}
            </ul>
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane active" id="incoming">
                    <div class="site-section">
                        <div class="section-content"> 
                            <div class="benefits">
                                <h3>{lang key="store.emailServices.benefits.incoming.title"}</h3>
                                <div class="row check-features">
                                    <div class="col-md-6"> <i class="lm lm-check"></i> {lang key="store.emailServices.benefits.incoming.1"}</div>
                                    <div class="col-md-6"> <i class="lm lm-check"></i> {lang key="store.emailServices.benefits.incoming.2"}</div>
                                    <div class="col-md-6"> <i class="lm lm-check"></i> {lang key="store.emailServices.benefits.incoming.3"}</div>
                                    <div class="col-md-6"> <i class="lm lm-check"></i> {lang key="store.emailServices.benefits.incoming.4"}</div>
                                    <div class="col-md-6"> <i class="lm lm-check"></i> {lang key="store.emailServices.benefits.incoming.5"}</div>
                                    <div class="col-md-6"> <i class="lm lm-check"></i> {lang key="store.emailServices.benefits.incoming.6"}</div>
                                    <div class="col-md-6"> <i class="lm lm-check"></i> {lang key="store.emailServices.benefits.incoming.7"}</div>
                                    <div class="col-md-6"> <i class="lm lm-check"></i> {lang key="store.emailServices.benefits.incoming.8"}</div>
                                </div>
                            </div>
                        </div>    
                        <div class="section-content">
                            <div class="row d-flex-align f-flow">
                                <div class="col-md-6">
                                    <h3 class="section-title">{lang key="store.emailServices.benefits.incoming.q1"}</h3>
                                    <div class="section-desc">
                                        <p>{lang key="store.emailServices.benefits.incoming.a1"}</p>
                                    </div>
                                </div>
                                <div class="section-graphic section-graphic-right col-md-6">
                                    <div class="browser browser-sm has-shadow">
                                        <div class="browser-top">
                                            <div class="browser-actions"><span></span><span></span><span></span></div>
                                        </div>
                                        <div class="browser-body">
                                            {if file_exists("templates/$template/assets/svg-icon/incoming-filter-1.tpl")}
                                                {include file="$template/assets/svg-icon/incoming-filter-1.tpl"}
                                            {/if}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="section-content">
                            <div class="row d-flex-align f-flow">
                                <div class="col-md-6 section-graphic">
                                    <div class="browser browser-sm has-shadow">
                                        <div class="browser-top">
                                            <div class="browser-actions"><span></span><span></span><span></span></div>
                                        </div>
                                        <div class="browser-body">
                                            {if file_exists("templates/$template/assets/svg-icon/incoming-filter-2.tpl")}
                                                {include file="$template/assets/svg-icon/incoming-filter-2.tpl"}
                                            {/if}
                                        </div>    
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <h3 class="section-title">{lang key="store.emailServices.benefits.incoming.q2"}</h3>
                                    <div class="section-desc">
                                        <p>{lang key="store.emailServices.benefits.incoming.a2"}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="section-content">
                            <div class="row d-flex-align f-flow">
                                <div class="col-md-6">
                                    <h3 class="section-title">{lang key="store.emailServices.benefits.incoming.q3"}</h3>
                                    <div class="section-desc">
                                        <p>{lang key="store.emailServices.benefits.incoming.a3"}</p>
                                    </div>
                                </div>
                                <div class="section-graphic section-graphic-right col-md-6">
                                    <div class="browser browser-sm has-shadow">
                                        <div class="browser-top">
                                            <div class="browser-actions"><span></span><span></span><span></span></div>
                                        </div>
                                        <div class="browser-body">
                                            {if file_exists("templates/$template/assets/svg-icon/incoming-filter-3.tpl")}
                                                {include file="$template/assets/svg-icon/incoming-filter-3.tpl"}
                                            {/if}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div role="tabpanel" class="tab-pane" id="outgoing">
                    <div class="site-section"> 
                        <div class="section-content">
                            <div class="benefits">
                                <h3>{lang key="store.emailServices.benefits.outgoing.title"}</h3>
                                <div class="row check-features">
                                    <div class="col-md-6"> <i class="lm lm-check"></i> {lang key="store.emailServices.benefits.outgoing.1"}</div>
                                    <div class="col-md-6"> <i class="lm lm-check"></i> {lang key="store.emailServices.benefits.outgoing.2"}</div>
                                    <div class="col-md-6"> <i class="lm lm-check"></i> {lang key="store.emailServices.benefits.outgoing.3"}</div>
                                    <div class="col-md-6"> <i class="lm lm-check"></i> {lang key="store.emailServices.benefits.outgoing.4"}</div>
                                    <div class="col-md-6"> <i class="lm lm-check"></i> {lang key="store.emailServices.benefits.outgoing.5"}</div>
                                    <div class="col-md-6"> <i class="lm lm-check"></i> {lang key="store.emailServices.benefits.outgoing.6"}</div>
                                </div>
                            </div>
                        </div>
                        <div class="section-content">
                            <div class="row d-flex-align f-flow">
                                <div class="col-md-6">
                                    <div class="section-content">
                                        <h3 class="section-title">{lang key="store.emailServices.benefits.outgoing.q1"}</h3>
                                        <div class="section-desc">
                                            <p>{lang key="store.emailServices.benefits.outgoing.a1"}</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="section-graphic section-graphic-right col-md-6">
                                    <div class="browser browser-sm has-shadow">
                                        <div class="browser-top">
                                            <div class="browser-actions"><span></span><span></span><span></span></div>
                                        </div>
                                        <div class="browser-body">
                                            {if file_exists("templates/$template/assets/svg-icon/outgoing-filter-1.tpl")}
                                                {include file="$template/assets/svg-icon/outgoing-filter-1.tpl"}
                                            {/if}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="section-content">
                            <div class="row d-flex-align f-flow">
                                <div class="section-graphic col-md-6">
                                    <div class="browser browser-sm has-shadow">
                                        <div class="browser-top">
                                            <div class="browser-actions"><span></span><span></span><span></span></div>
                                        </div>
                                        <div class="browser-body">
                                            {if file_exists("templates/$template/assets/svg-icon/outgoing-filter-2.tpl")}
                                                {include file="$template/assets/svg-icon/outgoing-filter-2.tpl"}
                                            {/if}
                                        </div>
                                    </div>                                
                                </div>
                                <div class="col-md-6">
                                    <div class="section-content">
                                        <h3 class="section-title">{lang key="store.emailServices.benefits.outgoing.q2"}</h3>
                                        <div class="section-desc">
                                            <p>{lang key="store.emailServices.benefits.outgoing.a2"}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div role="tabpanel" class="tab-pane" id="archiving">
                    <div class="site-section">
                        <div class="section-content">
                            <div class="benefits">
                                <h3>{lang key="store.emailServices.benefits.archiving.title"}</h3>
                                <div class="row check-features">
                                    <div class="col-md-6"> <i class="lm lm-check"></i> {lang key="store.emailServices.benefits.archiving.1"}</div>
                                    <div class="col-md-6"> <i class="lm lm-check"></i> {lang key="store.emailServices.benefits.archiving.2"}</div>
                                    <div class="col-md-6"> <i class="lm lm-check"></i> {lang key="store.emailServices.benefits.archiving.3"}</div>
                                    <div class="col-md-6"> <i class="lm lm-check"></i> {lang key="store.emailServices.benefits.archiving.4"}</div>
                                    <div class="col-md-6"> <i class="lm lm-check"></i> {lang key="store.emailServices.benefits.archiving.5"}</div>
                                    <div class="col-md-6"> <i class="lm lm-check"></i> {lang key="store.emailServices.benefits.archiving.6"}</div>
                                    <div class="col-md-6"> <i class="lm lm-check"></i> {lang key="store.emailServices.benefits.archiving.7"}</div>
                                </div>
                            </div>
                        </div>
                        <div class="section-content">
                            <div class="row d-flex-align f-flow">
                                <div class="col-md-6">
                                    <div class="section-content">
                                        <h3 class="section-title">{lang key="store.emailServices.benefits.archiving.q1"}</h3>
                                        <div class="section-desc">
                                            <p>{lang key="store.emailServices.benefits.archiving.a1"}</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="section-graphic section-graphic-right col-md-6">
                                    <div class="browser browser-sm has-shadow">
                                        <div class="browser-top">
                                            <div class="browser-actions"><span></span><span></span><span></span></div>
                                        </div>
                                        <div class="browser-body">
                                            {if file_exists("templates/$template/assets/svg-icon/archiving-1.tpl")}
                                                {include file="$template/assets/svg-icon/archiving-1.tpl"}
                                            {/if}
                                        </div>     
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="site-section">
                            <div class="row d-flex-align f-flow">
                                <div class="section-graphis col-md-6">
                                    <div class="browser browser-sm has-shadow">
                                        <div class="browser-top">
                                            <div class="browser-actions"><span></span><span></span><span></span></div>
                                        </div>
                                        <div class="browser-body">
                                            {if file_exists("templates/$template/assets/svg-icon/archiving-2.tpl")}
                                                {include file="$template/assets/svg-icon/archiving-2.tpl"}
                                            {/if}
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="section-content">
                                        <h3 class="section-title">{lang key="store.emailServices.benefits.archiving.q2"}</h3>
                                        <div class="section-desc">
                                            <p>{lang key="store.emailServices.benefits.archiving.a2a"}</p>
                                            <p>{lang key="store.emailServices.benefits.archiving.a2b"}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>                   
                </div>
            </div>
        </div>
    </div>                
    <div class="site-section section-dark" id="pricing">
        <div class="container">
            <h2 class="section-title text-center">{lang key="store.emailServices.signup.title"}</h2>
            <div class="section-content">
                <form class="m-w-832" method="post" action="{routePath('cart-order')}">
                    <input type="hidden" name="productkey" value="{$products.incoming->productKey}" id="productKey">
                    <div class="get-started">
                        <div class="get-started-left">
                            <h4>{lang key="store.emailServices.signup.choose"}</h4>
                            {if $numberOfFeaturedProducts > 0}
                                <div class="btn-group choose-product" role="group"> 
                                    {if $products.incoming}
                                        <button type="button" class="btn btn-default active" data-product="incoming">
                                        {if file_exists("templates/$template/assets/svg-icon/incoming-email-filtering.tpl")}
                                            {include file="$template/assets/svg-icon/incoming-email-filtering.tpl"}
                                        {/if}
                                        <span>
                                            <i class="lm lm-check"></i>
                                        </span>
                                            {lang key="store.emailServices.options.incomingFilter"}
                                        </button>
                                    {/if}
                                    {if $products.outgoing}
                                        <button type="button" class="btn btn-default" data-product="outgoing">
                                            {if file_exists("templates/$template/assets/svg-icon/outgoing-email-filtering.tpl")}
                                                {include file="$template/assets/svg-icon/outgoing-email-filtering.tpl"}
                                            {/if}
                                            <span>
                                                <i class="lm lm-check"></i>
                                            </span>
                                                {lang key="store.emailServices.options.outgoingFilter"}
                                        </button>
                                    {/if} 
                                </div>
                            {elseif $inPreview}
                                {lang key="store.emailServices.preview"}
                            {/if}
                            <h4>{lang key="store.emailServices.signup.additional"}</h4>
                            <div class="additional-options"> 
                                {foreach $productOptions as $productKey => $options}
                                    <div class="option options-{$productKey}"> 
                                        {foreach $options as $option}
                                            <label class="checkbox-inline">
                                                <input class="icheck-control" type="checkbox" name="options" value="{$option.product}">
                                                {lang key="store.emailServices.options.addFor" description=$option.description pricing=$option.pricing->toFullString()} 
                                            </label>
                                        {foreachelse}
                                            {lang key="store.emailServices.signup.none"}
                                        {/foreach} 
                                    </div>
                                {/foreach} 
                            </div>
                        </div>
                        <div class="get-started-right"> 
                            <p>{$LANG.ordersummary|replace:$LANG.ordertitle:""}</p> 
                            {if $products.incomingarchiving && $products.incomingarchiving->pricing()->best()}
                                {assign var="prodCycle" value="/"|explode:$products.incomingarchiving->pricing()->best()->toFullString()}
                                <span class="price price-incomingarchiving">{if $activeCurrency.prefix}<span class='price-prefix'>{$activeCurrency.prefix}</span>{/if}{$products.incomingarchiving->pricing()->best()->toFullString()|replace:'/':''|replace:$prodCycle[1]:''|replace:$activeCurrency.suffix:""|replace:$activeCurrency.prefix:""}{$activeCurrency.suffix}<span class="price-cycle">/{$prodCycle[1]}</span></span>                                       
                            {/if}
                            {if $products.incoming && $products.incoming->pricing()->best()}        
                                {assign var="prodCycle" value="/"|explode:$products.incoming->pricing()->best()->toFullString()}                                
                                <span class="price price-incoming">{if $activeCurrency.prefix}<span class='price-prefix'>{$activeCurrency.prefix}</span>{/if}{$products.incoming->pricing()->best()->toFullString()|replace:'/':''|replace:$prodCycle[1]:''|replace:$activeCurrency.suffix:""|replace:$activeCurrency.prefix:""}{$activeCurrency.suffix}<span class="price-cycle">/{$prodCycle[1]}</span></span>                                       
                            {/if}
                            {if $products.outgoing && $products.outgoing->pricing()->best()} 
                                {assign var="prodCycle" value="/"|explode:$products.outgoing->pricing()->best()->toFullString()}
                                <span class="price price-outgoing">{if $activeCurrency.prefix}<span class='price-prefix'>{$activeCurrency.prefix}</span>{/if}{$products.outgoing->pricing()->best()->toFullString()|replace:'/':''|replace:$prodCycle[1]:''|replace:$activeCurrency.suffix:""|replace:$activeCurrency.prefix:""}{$activeCurrency.suffix}<span class="price-cycle">/{$prodCycle[1]}</span></span>                                       
                            {/if}
                            {if $products.outgoingarchiving && $products.outgoingarchiving->pricing()->best()} 
                                {assign var="prodCycle" value="/"|explode:$products.outgoingarchiving->pricing()->best()->toFullString()}
                                <span class="price price-outgoingarchiving">{if $activeCurrency.prefix}<span class='price-prefix'>{$activeCurrency.prefix}</span>{/if}{$products.outgoingarchiving->pricing()->best()->toFullString()|replace:'/':''|replace:$prodCycle[1]:''|replace:$activeCurrency.suffix:""|replace:$activeCurrency.prefix:""}{$activeCurrency.suffix}<span class="price-cycle">/{$prodCycle[1]}</span></span>                                       
                            {/if}
                            {if $products.incomingoutgoing && $products.incomingoutgoing->pricing()->best()} 
                                {assign var="prodCycle" value="/"|explode:$products.incomingoutgoing->pricing()->best()->toFullString()}
                                <span class="price price-incomingoutgoing">{if $activeCurrency.prefix}<span class='price-prefix'>{$activeCurrency.prefix}</span>{/if}{$products.incomingoutgoing->pricing()->best()->toFullString()|replace:'/':''|replace:$prodCycle[1]:''|replace:$activeCurrency.suffix:""|replace:$activeCurrency.prefix:""}{$activeCurrency.suffix}<span class="price-cycle">/{$prodCycle[1]}</span></span>                                       
                            {/if}
                            {if $products.incomingoutgoingarchiving && $products.incomingoutgoingarchiving->pricing()->best()} 
                                {assign var="prodCycle" value="/"|explode:$products.incomingoutgoingarchiving->pricing()->best()->toFullString()}
                                <span class="price price-incomingoutgoingarchiving">{if $activeCurrency.prefix}<span class='price-prefix'>{$activeCurrency.prefix}</span>{/if}{$products.incomingoutgoingarchiving->pricing()->best()->toFullString()|replace:'/':''|replace:$prodCycle[1]:''|replace:$activeCurrency.suffix:""|replace:$activeCurrency.prefix:""}{$activeCurrency.suffix}<span class="price-cycle">/{$prodCycle[1]}</span></span>                                       
                            {/if} 
                            <br />
                            <button type="submit" class="btn btn-info btn-order-now btn-lg">{lang key="store.emailServices.signup.order"}</button>
                        </div>
                    </div>
                </form> 
            </div>
        </div>
    </div>
    <div class="site-section">
        <div class="container">
            <h2 class="section-title text-center">{lang key="store.emailServices.faqs.title"}</h2>
            <div class="section-content m-w-md m-a">
                <div id="accordion">
                    <div class="panel panel-default panel-accordion is-open">
                        <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#how_does_it_work" aria-expanded="true">
                            <h4 class="panel-title"><i class="lm lm-plus"></i>{lang key="store.emailServices.faqs.q1"}</h4>
                        </div>
                        <div id="how_does_it_work" class="panel-collapse collapse in" aria-expanded="true" style="">
                            <div class="panel-body">
                                <p>{lang key="store.emailServices.faqs.a1"}</p>
                            </div>
                        </div>        
                    </div>
                    <div class="panel panel-default panel-accordion">
                        <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#how_accurate_is_the_filtering" aria-expanded="true">
                            <h4 class="panel-title"><i class="lm lm-plus"></i>{lang key="store.emailServices.faqs.q2"}</h4>
                        </div>
                        <div id="how_accurate_is_the_filtering" class="panel-collapse collapse" aria-expanded="true" style="">
                            <div class="panel-body">
                                <p>{lang key="store.emailServices.faqs.a2"}</p>
                            </div>
                        </div>        
                    </div>
                    <div class="panel panel-default panel-accordion">
                        <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#can_I_recover_messages_that_get_blocked" aria-expanded="true">
                            <h4 class="panel-title"><i class="lm lm-plus"></i>{lang key="store.emailServices.faqs.q3"}</h4>
                        </div>
                        <div id="can_I_recover_messages_that_get_blocked" class="panel-collapse collapse" aria-expanded="true" style="">
                            <div class="panel-body">
                                <p>{lang key="store.emailServices.faqs.a3"}</p>
                            </div>
                        </div>        
                    </div>
                    <div class="panel panel-default panel-accordion">
                        <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#how_long_does_it_take_to_setup" aria-expanded="true">
                            <h4 class="panel-title"><i class="lm lm-plus"></i>{lang key="store.emailServices.faqs.q4"}</h4>
                        </div>
                        <div id="how_long_does_it_take_to_setup" class="panel-collapse collapse" aria-expanded="true" style="">
                            <div class="panel-body">
                                <p>{lang key="store.emailServices.faqs.a4"}</p>
                            </div>
                        </div>        
                    </div>
                    <div class="panel panel-default panel-accordion">
                        <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#what_is_Email_Archiving" aria-expanded="true">
                            <h4 class="panel-title"><i class="lm lm-plus"></i>{lang key="store.emailServices.faqs.q5"}</h4>
                        </div>
                        <div id="what_is_Email_Archiving" class="panel-collapse collapse" aria-expanded="true" style="">
                            <div class="panel-body">
                                <p>{lang key="store.emailServices.faqs.a5"}</p>
                            </div>
                        </div>        
                    </div>
                    <div class="panel panel-default panel-accordion">
                        <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#how_much_email_can_I_store" aria-expanded="true">
                            <h4 class="panel-title"><i class="lm lm-plus"></i>{lang key="store.emailServices.faqs.q6"}</h4>
                        </div>
                        <div id="how_much_email_can_I_store" class="panel-collapse collapse" aria-expanded="true" style="">
                            <div class="panel-body">
                                <p>{lang key="store.emailServices.faqs.a6"}</p>
                            </div>
                        </div>        
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="{$WEB_ROOT}/templates/{$template}/store/spamexperts/master.js"></script> 
{/if}