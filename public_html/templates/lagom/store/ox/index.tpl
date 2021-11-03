<link href="{$WEB_ROOT}/templates/{$template}/store/css/style.css" rel="stylesheet">
<div class="site">
    <div class="site-banner">
        <div class="container">
            <div class="row d-flex">
                <div class="col-lg-6 col-md-8">
                    <div class="banner-content">
                        <h1 class="banner-title">{lang key="store.ox.promoHeading"}</h1>
                        <div class="banner-actions">
                            <a href="#" class="btn btn-lg btn-primary" onclick="smoothScroll('#pricing');return false">{lang key="store.ox.viewPricing"}</a>
                            <a href="#" class="btn btn-lg btn-outline btn-outline-light" onclick="smoothScroll('#overview');return false">{lang key='learnmore'}</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-4">
                    <div class="banner-graphic"> 
                        {if file_exists("templates/$template/assets/svg-illustrations/products/ox-apps.tpl")}
                            {include file="$template/assets/svg-illustrations/products/ox-apps.tpl"}
                        {/if}
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="site-section">
        <div class="container">
            <div class="section-content">
                <div class="row d-flex-align f-flow">
                    <div class="col-md-6 section-graphic">
                        <div class="browser browser-sm has-shadow">
                            <div class="browser-top">
                                <div class="browser-actions"><span></span><span></span><span></span></div>
                            </div>
                            <div class="browser-body">
                            {if file_exists("templates/$template/assets/svg-icon/incoming-filter-1.tpl")}
                                {include file="$template/assets/svg-icon/incoming-filter-3.tpl"}
                            {/if}
                            </div>
                        </div> 
                    </div>
                    <div class="col-md-6">
                        <div class="section-content">
                            <h2 class="section-title">{lang key="store.ox.standout.feature1.title"}</h2>
                            <div class="section-desc">
                                <ul class="check-list">
                                    <li><i class="lm lm-check"></i>{lang key="store.ox.standout.feature1.bullet1"}</li>
                                    <li><i class="lm lm-check"></i>{lang key="store.ox.standout.feature1.bullet2"}</li>
                                    <li><i class="lm lm-check"></i>{lang key="store.ox.standout.feature1.bullet3"}</li>
                                    <li><i class="lm lm-check"></i>{lang key="store.ox.standout.feature1.bullet4"}</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>   
    <div class="site-section" id="overview">
        <div class="container">
            <div class="section-content">
                <div class="row d-flex-align f-flow">
                    <div class="col-md-6">
                        <div class="section-content">
                            <h2 class="section-title">{lang key="store.ox.standout.feature2.title"}</h2>
                            <p class="section-desc">{lang key="store.ox.standout.feature2.detail"}</p>
                        </div>
                    </div>
                    <div class="col-md-6 section-graphic section-graphic-right">
                        <div class="browser browser-sm  has-shadow">
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
                </div>
            </div>
        </div>
    </div>   
    <div class="site-section">
        <div class="container">
            <div class="section-content">
                <div class="row d-flex-align f-flow">
                    <div class="col-md-6 section-graphic">
                        <div class="browser browser-sm  has-shadow">
                            <div class="browser-top">
                                <div class="browser-actions"><span></span><span></span><span></span></div>
                            </div>
                            <div class="browser-body">
                            {if file_exists("templates/$template/assets/svg-illustrations/store/any-device.tpl")}
                                {include file="$template/assets/svg-illustrations/store/any-device.tpl"}
                            {/if}
                            </div> 
                        </div> 
                    </div>
                    <div class="col-md-6">
                        <div class="section-content">
                            <h2 class="section-title">{lang key="store.ox.standout.feature3.title"}</h2>
                            <p class="section-desc">{lang key="store.ox.standout.feature3.detail"}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="site-section section-dark" id="pricing">
        <div class="container">
            <h2 class="section-title text-center">
                {lang key="store.ox.pricingHeadline"}
            </h2>
                               
            <div class="row row-eq-height row-eq-height-sm">
                {if count($plans) > 0}
                    {foreach $plans as $plan}
                        <div class="col-lg-{if $plan@total == 1}4 {if $plan@first}col-md-offset-4{/if}{elseif $plan@total == 2}4 {if $plan@first}col-md-offset-2{/if}{elseif $plan@total == 3}4{elseif $plan@total == 4}3{elseif $plan@total == 5}4{else}3{/if}">
                            <div class="package">
                                <h4 class="package-title">{$plan->name}</h4>

                                <div class="package-price"> 
                                    <div class="price monthly">
                                    {if $plan->isFree()}
                                        {lang key='orderpaymenttermfree'}
                                    {elseif $plan->pricing()->first()}
                                        {$plan->pricing()->first()->toFullString()}
                                    {else}
                                        -
                                    {/if}
                                    </div>
                                    {if $plan->pricing()->first()}
                                    <div class="package-starting-from ">per user</div>
                                    {/if}
                                </div>
                                <ul class="package-features">
                                    {foreach $plans[0]['features'] as $feature => $value}
                                        <li>
                                            {if $plan['features'][$feature] !== '-'}
                                                <span>{$feature}</span> 
                                                {if !is_bool($plan['features'][$feature])}<b>{$plan['features'][$feature]}</b>{/if}
                                            {/if}
                                        </li>
                                    {/foreach}
                                </ul>
                                <div class="package-actions">
                                    <form method="post" action="{routePath('cart-order')}">
                                        <input type="hidden" name="pid" value="{$plan->id}">
                                        <button type="submit" class="btn btn-primary">
                                            {lang key="store.ssl.landingPage.buyNow"}
                                        </button>
                                    </form>
                                </div>
                            </div>    
                        </div>
                    {/foreach}
                {elseif $inPreview}
                    <div class="lead text-center">
                        {lang key="store.sitelockvpn.adminPreview"}
                    </div>
                {/if}    
            </div>
        </div>
    </div> 
    <div class="site-section">
        <div class="container">
            <h2 class="section-title text-center">{lang key="store.ox.featuresHeadline"}</h2>
            <div class="section-content">
                <div class="row row-eq-height row-eq-height-xs row-features">
                    <div class="col-lg-4 col-sm-6">
                        <div class="feature feature-xs-left">
                            <div class="feature-icon">
                                {if file_exists("templates/$template/assets/svg-icon/cloud-hosting.tpl")}
                                    {include file="$template/assets/svg-icon/cloud-hosting.tpl"}
                                {/if} 
                            </div>
                            <div class="feature-content">
                                <h4 class="feature-title">{lang key="store.ox.feature1.title"}</h4>
                                <p class="feature-desc">{lang key="store.ox.feature1.detail"}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6">
                        <div class="feature feature-xs-left">
                            <div class="feature-icon">
                                {if file_exists("templates/$template/assets/svg-icon/issued-in-1-2-days.tpl")}
                                    {include file="$template/assets/svg-icon/issued-in-1-2-days.tpl"}
                                {/if} 
                            </div>
                            <div class="feature-content">
                                <h4 class="feature-title">{lang key="store.ox.feature2.title"}</h4>
                                <p class="feature-desc">{lang key="store.ox.feature2.detail"}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6">
                        <div class="feature feature-xs-left">
                            <div class="feature-icon">
                                {if file_exists("templates/$template/assets/svg-icon/email-archiving.tpl")}
                                    {include file="$template/assets/svg-icon/email-archiving.tpl"}
                                {/if} 
                            </div>
                            <div class="feature-content">
                                <h4 class="feature-title">{lang key="store.ox.feature3.title"}</h4>
                                <p class="feature-desc">{lang key="store.ox.feature3.detail"}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6">
                        <div class="feature feature-xs-left">
                            <div class="feature-icon">
                                {if file_exists("templates/$template/assets/svg-icon/icon-website-time-maschine.tpl")}
                                    {include file="$template/assets/svg-icon/icon-website-time-maschine.tpl"}
                                {/if} 
                            </div>
                            <div class="feature-content">
                                <h4 class="feature-title">{lang key="store.ox.feature4.title"}</h4>
                                <p class="feature-desc">{lang key="store.ox.feature4.detail"}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6">
                        <div class="feature feature-xs-left">
                            <div class="feature-icon">
                                {if file_exists("templates/$template/assets/svg-icon/icon-wordpress-plugin-updates.tpl")}
                                    {include file="$template/assets/svg-icon/icon-wordpress-plugin-updates.tpl"}
                                {/if} 
                            </div>
                            <div class="feature-content">
                                <h4 class="feature-title">{lang key="store.ox.feature5.title"}</h4>
                                <p class="feature-desc">{lang key="store.ox.feature5.detail"}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6">
                        <div class="feature feature-xs-left">
                            <div class="feature-icon">
                                {if file_exists("templates/$template/assets/svg-icon/protect-user-privacy.tpl")}
                                    {include file="$template/assets/svg-icon/protect-user-privacy.tpl"}
                                {/if} 
                            </div>
                            <div class="feature-content">
                                <h4 class="feature-title">{lang key="store.ox.feature6.title"}</h4>
                                <p class="feature-desc">{lang key="store.ox.feature6.detail"}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>    
    <div class="site-section">
        <div class="container">
            <h2 class="section-title text-center">Frequently Asked Questions</h2>
            <div class="section-content m-w-md m-a">    
                <div id="accordion">
                    <div class="panel panel-default panel-accordion">
                        <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#faq1" aria-expanded="true">
                            <h4 class="panel-title"><i class="lm lm-plus"></i>{lang key="store.ox.faq1.question"}</h4>
                        </div>
                        <div id="faq1" class="panel-collapse collapse" aria-expanded="true" style="">
                            <div class="panel-body">
                                <p>{lang key="store.ox.faq1.answer"}</p>
                            </div>
                        </div>        
                    </div>
                    <div class="panel panel-default panel-accordion">
                        <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#faq2" aria-expanded="true">
                            <h4 class="panel-title"><i class="lm lm-plus"></i>{lang key="store.ox.faq2.question"}</h4>
                        </div>
                        <div id="faq2" class="panel-collapse collapse" aria-expanded="true" style="">
                            <div class="panel-body">
                                <p>{lang key="store.ox.faq2.answer"}</p>
                            </div>
                        </div>        
                    </div>
                    <div class="panel panel-default panel-accordion">
                        <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#faq3" aria-expanded="true">
                            <h4 class="panel-title"><i class="lm lm-plus"></i>{lang key="store.ox.faq3.question"}</h4>
                        </div>
                        <div id="faq3" class="panel-collapse collapse" aria-expanded="true" style="">
                            <div class="panel-body">
                                <p>{lang key="store.ox.faq3.answer"}</p>
                            </div>
                        </div>        
                    </div>
                    <div class="panel panel-default panel-accordion">
                        <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#faq4" aria-expanded="true">
                            <h4 class="panel-title"><i class="lm lm-plus"></i>{lang key="store.ox.faq4.question"}</h4>
                        </div>
                        <div id="faq4" class="panel-collapse collapse" aria-expanded="true" style="">
                            <div class="panel-body">
                                <p>{lang key="store.ox.faq4.answer"}</p>
                            </div>
                        </div>        
                    </div>
                    <div class="panel panel-default panel-accordion">
                        <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#faq5" aria-expanded="true">
                            <h4 class="panel-title"><i class="lm lm-plus"></i>{lang key="store.ox.faq5.question"}</h4>
                        </div>
                        <div id="faq5" class="panel-collapse collapse" aria-expanded="true" style="">
                            <div class="panel-body">
                                <p>{lang key="store.ox.faq5.answer"}</p>
                            </div>
                        </div>        
                    </div>
                    <div class="panel panel-default panel-accordion">
                        <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#faq6" aria-expanded="true">
                            <h4 class="panel-title"><i class="lm lm-plus"></i>{lang key="store.ox.faq6.question"}</h4>
                        </div>
                        <div id="faq6" class="panel-collapse collapse" aria-expanded="true" style="">
                            <div class="panel-body">
                                <p>{lang key="store.ox.faq6.answer"}</p>
                            </div>
                        </div>        
                    </div>
                    <div class="panel panel-default panel-accordion">
                        <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#faq7" aria-expanded="true">
                            <h4 class="panel-title"><i class="lm lm-plus"></i>{lang key="store.ox.faq7.question"}</h4>
                        </div>
                        <div id="faq7" class="panel-collapse collapse" aria-expanded="true" style="">
                            <div class="panel-body">
                                <p>{lang key="store.ox.faq7.answer"}</p>
                            </div>
                        </div>        
                    </div>
                    <div class="panel panel-default panel-accordion">
                        <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#faq8" aria-expanded="true">
                            <h4 class="panel-title"><i class="lm lm-plus"></i>{lang key="store.ox.faq8.question"}</h4>
                        </div>
                        <div id="faq8" class="panel-collapse collapse" aria-expanded="true" style="">
                            <div class="panel-body">
                                <p>{lang key="store.ox.faq8.answer"}</p>
                            </div>
                        </div>        
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

