{if file_exists("templates/$template/store/sitelockvpn/overwrites/index.tpl")}
    {include file="{$template}/store/sitelockvpn/overwrites/index.tpl"}  
{else} 
    <div class="site site-sitelockvpn">
        <div class="site-banner">
            <div class="container">
                <div class="row d-flex">
                    <div class="col-lg-6 col-md-8">
                        <div class="banner-content">
                            <h1 class="banner-title"> {lang key='store.sitelockvpn.subtitle1'} {lang key='store.sitelockvpn.subtitle2'}</h1>
                            <div class="banner-desc">
                                <p>{lang key='store.sitelockvpn.tagline1'} {lang key='store.sitelockvpn.tagline2'}</p>
                            </div>
                            <div class="banner-actions">
                                <a href="#" class="btn btn-lg btn-primary" onclick="smoothScroll('#pricing');return false">{lang key='store.sitelockvpn.getStarted'}</a>
                                <a href="#" class="btn btn-lg btn-outline btn-outline-light" onclick="smoothScroll('#overview');return false">{lang key='learnmore'}</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-4">
                        <div class="banner-graphic"> 
                            {if file_exists("templates/$template/assets/svg-illustrations/products/sitelockvpn.tpl")}
                                {include file="$template/assets/svg-illustrations/products/sitelockvpn.tpl"}
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
                        <div class="col-md-6">
                            <div class="section-content">
                                <h2 class="section-title">{lang key='store.sitelockvpn.feature1.title'}</h2>
                                <div class="section-desc">
                                    <p>{lang key='store.sitelockvpn.feature1.subtitle'}</p>
                                    <ul class="check-list">
                                        <li><i class="lm lm-check"></i>{lang key='store.sitelockvpn.feature1.highlights.one'}</li>
                                        <li><i class="lm lm-check"></i>{lang key='store.sitelockvpn.feature1.highlights.two'}</li>
                                        <li><i class="lm lm-check"></i>{lang key='store.sitelockvpn.feature1.highlights.three'}</li>
                                        <li><i class="lm lm-check"></i>{lang key='store.sitelockvpn.feature1.highlights.four'}</li>
                                        <li><i class="lm lm-check"></i>{lang key='store.sitelockvpn.feature1.highlights.five'}</li>
                                        <li><i class="lm lm-check"></i>{lang key='store.sitelockvpn.feature1.highlights.six'}</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 section-graphic section-graphic-right">
                            <div class="browser browser-sm has-shadow">
                                <div class="browser-top">
                                    <div class="browser-actions"><span></span><span></span><span></span></div>
                                </div>
                                {if file_exists("templates/$template/assets/svg-icon/store/vpn/vpn-illustration-1.tpl")}
                                    {include file="$template/assets/svg-icon/store/vpn/vpn-illustration-1.tpl"}
                                {/if}
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
                            <div class="browser browser-sm has-shadow">
                                <div class="browser-top">
                                    <div class="browser-actions"><span></span><span></span><span></span></div>
                                </div>
                                {if file_exists("templates/$template/assets/svg-icon/store/vpn/vpn-illustration-2.tpl")}
                                    {include file="$template/assets/svg-icon/store/vpn/vpn-illustration-2.tpl"}
                                {/if}
                            </div> 
                        </div>
                        <div class="col-md-6">
                            <div class="section-content">
                                <h2 class="section-title">{lang key='store.sitelockvpn.feature2.title'}</h2>
                                <div class="section-desc">
                                    <p>{lang key='store.sitelockvpn.feature2.subtitle'}</p>
                                    <ul class="check-list">
                                        <li><i class="lm lm-check"></i>{lang key='store.sitelockvpn.feature2.highlights.one'}</li>
                                        <li><i class="lm lm-check"></i>{lang key='store.sitelockvpn.feature2.highlights.two'}</li>
                                        <li><i class="lm lm-check"></i>{lang key='store.sitelockvpn.feature2.highlights.three'}</li>
                                        <li><i class="lm lm-check"></i>{lang key='store.sitelockvpn.feature2.highlights.four'}</li>
                                        <li><i class="lm lm-check"></i>{lang key='store.sitelockvpn.feature2.highlights.five'}</li>
                                        <li><i class="lm lm-check"></i>{lang key='store.sitelockvpn.feature2.highlights.six'}</li>
                                    </ul>
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
                        <div class="col-md-6">
                            <div class="section-content">
                                <h2 class="section-title">{lang key='store.sitelockvpn.feature3.title'}</h2>
                                <div class="section-desc">
                                    <p><b>{lang key='store.sitelockvpn.feature3.subtitle'}</b></p>
                                    <p>{lang key='store.sitelockvpn.feature3.subtitle2'}</p>
                                    <sup class='text-muted'>{lang key='store.sitelockvpn.feature3.subtitle3'}</sup>
                                </div>
                            </div>
                        </div> 
                        <div class="col-md-6 section-graphic section-graphic-right">
                            <div class="browser browser-sm has-shadow">
                                <div class="browser-top">
                                    <div class="browser-actions"><span></span><span></span><span></span></div>
                                </div>
                                {if file_exists("templates/$template/assets/svg-icon/store/vpn/vpn-illustration-3.tpl")}
                                    {include file="$template/assets/svg-icon/store/vpn/vpn-illustration-3.tpl"}
                                {/if}
                            </div> 
                        </div>                   
                    </div>
                </div>
            </div>
        </div>
        <div class="site-section section-dark" id="pricing">
            <div class="container">
                <div class="currency-flex currency-sitelock">
                    <h2 class="section-title text-center">
                        {lang key='store.sitelockvpn.pricing.oneSubscription'}<br>
                        <strong>{lang key='store.sitelockvpn.pricing.fiveDevices'}</strong>
                    </h2>
                    <div class="currency-selector">
                        {if !$loggedin && $currencies}
                            <form method="post" action="">
                                <select name="currency" class="form-control currency-selector" onchange="submit()">
                                    <option>{lang key="changeCurrency"} ({$activeCurrency.prefix} {$activeCurrency.code})</option>
                                    {foreach $currencies as $currency}
                                        <option value="{$currency['id']}">{$currency['prefix']} {$currency['code']}</option>
                                    {/foreach}
                                </select>
                            </form>                        
                        {/if}
                    </div>
                </div>
                <div class="section-content">
                    <div class="row row-eq-height row-eq-height-sm">
                        {if count($plans) > 0}
                            {foreach $plans as $plan}
                                {foreach $plan->pricing()->allAvailableCycles() as $pricing}
                                    <div class="col-lg-{if $pricing@total == 1}12{elseif $pricing@total == 2}6{elseif $pricing@total == 3}4{elseif $pricing@total == 4}3{elseif $pricing@total == 5}4{else}3{/if}">
                                        <div class="package {if $pricing->calculatePercentageDifference($highestMonthlyPrice) > 0}package-featured{/if}">
                                            {if $pricing->calculatePercentageDifference($highestMonthlyPrice) > 0}
                                                <span class="label-corner label-primary">
                                                    {lang key='store.save' saving=$pricing->calculatePercentageDifference($highestMonthlyPrice)}
                                                </span>
                                            {/if}
                                            <h4 class="package-title">
                                                {if $pricing->isYearly()}
                                                    {$pricing->cycleInYears()}
                                                {else}
                                                    {$pricing->cycleInMonths()}
                                                {/if}
                                            </h4>
                                            <div class="package-price">                                           
                                                {assign var=vpnPrice value="/"|explode:$pricing->toFullString()}
                                                <div class="price monthly">{$vpnPrice[0]}</div>
                                            </div>
                                            <ul class="package-features">
                                                {foreach $plan->planFeatures as $langKey => $feature}
                                                    <li>
                                                        {lang key="store.sitelockvpn.pricing.features.$langKey"}
                                                    </li>
                                                {/foreach}
                                            </ul>
                                            <div class="package-actions">
                                                <form method="post" action="{routePath('cart-order')}">
                                                    <input type="hidden" name="pid" value="{$plan->id}">
                                                    <input type="hidden" name="billingcycle" value="{$pricing->cycle()}">
                                                    <button type="submit" class="btn btn-primary btn-block btn-signup{if $pricing@iteration == ($pricing@total - 1)} highlight1{elseif $pricing@iteration == $pricing@total} highlight2{/if}">
                                                        {lang key="signup"}
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>        
                                {/foreach}
                            {/foreach}
                        {elseif $inPreview}
                            <div class="lead text-center">
                                {lang key="store.sitelockvpn.adminPreview"}
                            </div>
                        {/if}    
                    </div>
                </div>
            </div>
        </div>
        <div class="site-section">
            <div class="container">
                <h2 class="section-title text-center">{lang key='store.sitelockvpn.plans.features.allInclude'}:</h2>
                <div class="section-content">
                    <div class="row row-eq-height row-eq-height-xs row-features">
                        <div class="col-lg-3 col-sm-6">
                            <div class="feature feature-xs-left">
                                <div class="feature-icon">
                                    {if file_exists("templates/$template/assets/svg-icon/instant-issuance.tpl")}
                                        {include file="$template/assets/svg-icon/instant-issuance.tpl"}
                                    {/if} 
                                </div>
                                <div class="feature-content">
                                    <h4 class="feature-title">{lang key='store.sitelockvpn.plans.features.noRestrictions'}</h4>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-sm-6">
                            <div class="feature feature-xs-left">
                                <div class="feature-icon">
                                    {if file_exists("templates/$template/assets/svg-icon/web-hosting.tpl")}
                                        {include file="$template/assets/svg-icon/web-hosting.tpl"}
                                    {/if} 
                                </div>
                                <div class="feature-content">
                                    <h4 class="feature-title">{lang key='store.sitelockvpn.plans.features.highSpeed'}</h4>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-sm-6">
                            <div class="feature feature-xs-left">
                                <div class="feature-icon">
                                    {if file_exists("templates/$template/assets/svg-icon/transfer-domain.tpl")}
                                        {include file="$template/assets/svg-icon/transfer-domain.tpl"}
                                    {/if} 
                                </div>
                                <div class="feature-content">
                                    <h4 class="feature-title">{lang key='store.sitelockvpn.plans.features.unlimited'}</h4>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-sm-6">
                            <div class="feature feature-xs-left">
                                <div class="feature-icon">
                                    {if file_exists("templates/$template/assets/svg-icon/sitelock.tpl")}
                                        {include file="$template/assets/svg-icon/sitelock.tpl"}
                                    {/if} 
                                </div>
                                <div class="feature-content">
                                    <h4 class="feature-title">{lang key='store.sitelockvpn.plans.features.encryption'}</h4>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-sm-6">
                            <div class="feature feature-xs-left">
                                <div class="feature-icon">
                                    {if file_exists("templates/$template/assets/svg-icon/icon-staging-of-restores.tpl")}
                                        {include file="$template/assets/svg-icon/icon-staging-of-restores.tpl"}
                                    {/if} 
                                </div>
                                <div class="feature-content">
                                    <h4 class="feature-title">{lang key='store.sitelockvpn.plans.features.protocol'}</h4>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-sm-6">
                            <div class="feature feature-xs-left">
                                <div class="feature-icon">
                                    {if file_exists("templates/$template/assets/svg-icon/templates.tpl")}
                                        {include file="$template/assets/svg-icon/templates.tpl"}
                                    {/if} 
                                </div>
                                <div class="feature-content">
                                    <h4 class="feature-title">{lang key='store.sitelockvpn.plans.features.simultaneous'}</h4>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-sm-6">
                            <div class="feature feature-xs-left">
                                <div class="feature-icon">
                                    {if file_exists("templates/$template/assets/svg-icon/icon-automatic-daily-backup.tpl")}
                                        {include file="$template/assets/svg-icon/icon-automatic-daily-backup.tpl"}
                                    {/if} 
                                </div>
                                <div class="feature-content">
                                    <h4 class="feature-title">{lang key='store.sitelockvpn.plans.features.switching'}</h4>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-sm-6">
                            <div class="feature feature-xs-left">
                                <div class="feature-icon">
                                    {if file_exists("templates/$template/assets/svg-icon/email-archiving.tpl")}
                                        {include file="$template/assets/svg-icon/email-archiving.tpl"}
                                    {/if} 
                                </div>
                                <div class="feature-content">
                                    <h4 class="feature-title">{lang key='store.sitelockvpn.plans.features.support'}</h4>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>    
        </div> 
        <div class="site-section">
            <div class="container">
                <h2 class="section-title text-center">{lang key='store.sitelockvpn.world.features.title'}</h2>
                <div class="section-content">
                    <div class="vpn-map">
                        <img src="{$WEB_ROOT}/templates/{$template}/assets/img/store/sitelockvpn/vpn-map.svg">
                    </div>
                    <div class="vpn-tiles">
                        <div class="row"> 
                            <div class="col-sm-4">
                                <div class="tile">
                                    <span class="stat">1000+</span>
                                    <span class="title">{$LANG.store.sitelockvpn.world.features.servers|capitalize}</span>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="tile">
                                    <span class="stat">40+</span>
                                    <span class="title">{$LANG.store.sitelockvpn.world.features.countries|capitalize}</span>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="tile">
                                    <span class="stat">{$LANG.store.sitelockvpn.world.features.unlimited}</span>
                                    <span class="title">{$LANG.store.sitelockvpn.world.features.bandwidth|capitalize}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
{/if}