{if file_exists("templates/$template/store/sitelock/overwrites/index.tpl")}
    {include file="{$template}/store/sitelock/overwrites/index.tpl"}  
{else} 

<div class="site site-sitelock">
    <div class="site-banner">
        <div class="container">
            <div class="row d-flex">
                <div class="col-lg-6 col-md-8">
                    <div class="banner-content">
                        <h1 class="banner-title">{lang key="store.sitelock.contentHeadline"}</h1>
                        <div class="banner-desc">
                            <p>{lang key="store.sitelock.tagline"}</p>
                        </div>
                        <div class="banner-actions">
                            <a href="#" class="btn btn-lg btn-primary" onclick="smoothScroll('#pricing');return false">{lang key="store.websiteBuilder.tab.pricing"}</a>
                            <a href="#" class="btn btn-lg btn-outline btn-outline-light" onclick="smoothScroll('#overview');return false">{lang key="learnmore"}</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-4">
                    <div class="banner-graphic"> 
                         {if file_exists("templates/$template/assets/svg-illustrations/products/symantec.tpl")}
                            {include file="$template/assets/svg-illustrations/products/symantec.tpl"}
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
                            {if file_exists("templates/$template/assets/svg-icon/store/SSL/ssl-preview-2.tpl")}
                                {include file="$template/assets/svg-icon/store/SSL/ssl-preview-2.tpl"}
                            {/if}
                        </div> 
                    </div>
                    <div class="col-md-6">
                        <div class="section-content">
                            <h2 class="section-title">{lang key="store.sitelock.comparePlansSubtitle"}</h2>
                            <div class="section-desc">
                                <p>{lang key="store.sitelock.contentBodyParagraph1"}</p>
                                <p>{lang key="store.sitelock.contentBodyParagraph2"}</p>
                                <p>{lang key="store.sitelock.contentBodyParagraph3"}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="section-content"> 
                <div class="row row-features justify-center">
                    <div class="col-lg col-md-4 col-sm-6">
                        <div class="feature feature-boxed feature-left">
                            <div class="feature-icon">
                                {if file_exists("templates/$template/assets/svg-icon/site-lock-trust-seal.tpl")}
                                    {include file="$template/assets/svg-icon/site-lock-trust-seal.tpl"}
                                {/if}
                            </div>
                            <div class="feature-content">
                                <h4 class="feature-title">{lang key="store.sitelock.featuresTrustSealTitle"}</h4>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg col-md-4 col-sm-6">
                        <div class="feature feature-boxed feature-left">
                            <div class="feature-icon">
                                {if file_exists("templates/$template/assets/svg-icon/daily-malware-scanning.tpl")}
                                    {include file="$template/assets/svg-icon/daily-malware-scanning.tpl"}
                                {/if} 
                            </div>
                            <div class="feature-content">
                                <h4 class="feature-title">{lang key="store.sitelock.features.malwareScanning"}</h4>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg col-md-4 col-sm-6">
                        <div class="feature feature-boxed feature-left">
                            <div class="feature-icon">
                                {if file_exists("templates/$template/assets/svg-icon/vulnerability-scan.tpl")}
                                    {include file="$template/assets/svg-icon/vulnerability-scan.tpl"}
                                {/if} 
                            </div>
                            <div class="feature-content">
                                <h4 class="feature-title">{lang key="store.sitelock.featuresVulnerabilityTitle"}</h4>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>                
    <div class="site-section section-dark" id="pricing">
        <div class="container">
            <div class="currency-flex currency-sitelock">
            <h2 class="section-title text-center">{lang key="store.sitelock.comparePlans"}</h2>
                <div class="currency-selector">
                    {if !$loggedin && $currencies}
                    <form method="post" action="">
                        <select name="currency" class="form-control" onchange="submit()">
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
                {foreach $plans as $plan}
                    <div class="col-lg-{if count($plans) == 4}3{elseif count($plans) == 3}4{elseif count($plans) == 2}6{else}12{/if} col-md-{if count($plans) == 3}6{/if} col-sm-12">
                        <div class="package">
                            <h4 class="package-title">{$plan->name} </h4>
                            <p class="package-subtitle">{$plan->description}</p>
                            <div class="package-price"> 
                                {if $plan->isFree()}
                                    {lang key="orderpaymenttermfree"}
                                {elseif $plan->pricing()->annually()}   
                                    <div class="price monthly"> {if $activeCurrency.prefix}<span class='price-prefix'>{$activeCurrency.prefix}</span>{/if}{$plan->pricing()->annually()->price()->toSuffixed()}</span><span class="price-cycle" id="pricingCycle">/{$rslang->trans('order.period.short.annually')}</span> </div>
                                {elseif $plan->pricing()->first()}    
                                    <div class="price monthly"> {if $activeCurrency.prefix}<span class='price-prefix'>{$activeCurrency.prefix}</span>{/if}{$plan->pricing()->first()->price()->toSuffixed()}<span class="price-cycle" id="pricingCycle">{if $plan->pricing()->first()->cycle() eq "monthly"}/{$rslang->trans('order.period.short.monthly')}{elseif $plan->pricing()->first()->cycle() eq "quarterly"}/{$rslang->trans('order.period.short.quarterly')}{elseif $plan->pricing()->first()->cycle() eq "semiannually"}/{$rslang->trans('order.period.short.semiannually')}{elseif $plan->pricing()->first()->cycle() eq "annually"}/{$rslang->trans('order.period.short.annually')}{elseif $plan->pricing()->first()->cycle() eq "biennially"}/{$rslang->trans('order.period.short.biennially')}{elseif $plan->pricing()->first()->cycle() eq "triennially"}/{$rslang->trans('order.period.short.triennially')}{/if}</span> </div>
                                {else}
                                    -
                                {/if} 
                            </div>
                            <ul class="package-features">
                                {foreach $plan->features as $label => $value}
                                    <li> {$label} {if is_bool($value)}{else} - <b>{$value}</b>
                                    {/if} </li>
                                {/foreach}
                            </ul>
                            <div class="package-actions">
                                <form method="post" action="{routePath('cart-order')}">
                                    <input type="hidden" name="pid" value="{$plan->id}">
                                    <select name="billingcycle" class="form-control">
                                        {foreach $plan->pricing()->allAvailableCycles() as $cycle}
                                            <option value="{$cycle->cycle()}"> {if $cycle->isRecurring()}
                                                {if $cycle->isYearly()}
                                                    {$cycle->cycleInYears()}
                                                {else}
                                                    {$cycle->cycleInMonths()}
                                                {/if}
                                                    -
                                                {/if}
                                                {$cycle->toFullString()}
                                            </option>
                                        {/foreach}
                                    </select>
                                    <button type="submit" class="btn btn-primary btn-block">{lang key="store.sitelock.buyNow"}</button>
                                </form>
                            </div>
                        </div>
                    </div>
                    {/foreach} 
                </div>
            </div>
        </div>
    </div>                
    <div class="site-section">
        <div class="container">
            <h2 class="section-title text-center">{lang key="store.sitelock.featuresTitle"}</h2>
            <p class="section-subtitle text-center">{lang key="store.sitelock.featuresHeadline"}</p>
            <div class="section-content">
                <div class="row row-eq-height row-eq-height-xs row-features">
                    <div class="col-lg-3 col-sm-6">
                        <div class="feature feature-xs-left">
                            <div class="feature-icon">
                                {if file_exists("templates/$template/assets/svg-icon/malware-scan.tpl")}
                                    {include file="$template/assets/svg-icon/malware-scan.tpl"}
                                {/if} 
                            </div>
                            <div class="feature-content">
                                <h4 class="feature-title">{lang key="store.sitelock.featuresMalwareTitle"}</h4>
                                <p class="feature-desc">{lang key="store.sitelock.featuresMalwareContent"}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6">
                        <div class="feature feature-xs-left">
                            <div class="feature-icon">
                                {if file_exists("templates/$template/assets/svg-icon/automatic-malware-removal.tpl")}
                                    {include file="$template/assets/svg-icon/automatic-malware-removal.tpl"}
                                {/if} 
                            </div>
                            <div class="feature-content">
                                <h4 class="feature-title">{lang key="store.sitelock.featuresMalwareRemovalTitle"}</h4>
                                <p class="feature-desc">{lang key="store.sitelock.featuresMalwareRemovalContent"}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6">
                        <div class="feature feature-xs-left">
                            <div class="feature-icon">
                                {if file_exists("templates/$template/assets/svg-icon/vulnerability-scan_2.tpl")}
                                    {include file="$template/assets/svg-icon/vulnerability-scan_2.tpl"}
                                {/if}
                            </div>
                            <div class="feature-content">
                                <h4 class="feature-title">{lang key="store.sitelock.featuresVulnerabilityTitle"}</h4>
                                <p class="feature-desc">{lang key="store.sitelock.featuresVulnerabilityContent"}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6">
                        <div class="feature feature-xs-left">
                            <div class="feature-icon">
                                {if file_exists("templates/$template/assets/svg-icon/OWASP-protection.tpl")}
                                    {include file="$template/assets/svg-icon/OWASP-protection.tpl"}
                                {/if} 
                            </div>
                            <div class="feature-content">
                                <h4 class="feature-title">{lang key="store.sitelock.featuresOWASPTitle"}</h4>
                                <p class="feature-desc">{lang key="store.sitelock.featuresOWASPContent"}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6">
                        <div class="feature feature-xs-left">
                            <div class="feature-icon">
                                {if file_exists("templates/$template/assets/svg-icon/firewall.tpl")}
                                    {include file="$template/assets/svg-icon/firewall.tpl"}
                                {/if} 
                            </div>
                            <div class="feature-content">
                                <h4 class="feature-title">{lang key="store.sitelock.featuresFirewallTitle"}</h4>
                                <p class="feature-desc">{lang key="store.sitelock.featuresFirewallContent"}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6">
                        <div class="feature feature-xs-left">
                            <div class="feature-icon">
                                {if file_exists("templates/$template/assets/svg-icon/protect-your-reputation.tpl")}
                                    {include file="$template/assets/svg-icon/protect-your-reputation.tpl"}
                                {/if} 
                            </div>
                            <div class="feature-content">
                            <h4 class="feature-title">{lang key="store.sitelock.featuresReputationTitle"}</h4>
                            <p class="feature-desc">{lang key="store.sitelock.featuresReputationContent"}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6">
                        <div class="feature feature-xs-left">
                            <div class="feature-icon">
                                {if file_exists("templates/$template/assets/svg-icon/fast-automated-steup.tpl")}
                                    {include file="$template/assets/svg-icon/fast-automated-steup.tpl"}
                                {/if} 
                            </div>
                            <div class="feature-content">
                            <h4 class="feature-title">{lang key="store.sitelock.featuresSetupTitle"}</h4>
                            <p class="feature-desc">{lang key="store.sitelock.featuresSetupContent"}</p>
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
                                <h4 class="feature-title">{lang key="store.sitelock.featuresCDNTitle"}</h4>
                                <p class="feature-desc">{lang key="store.sitelock.featuresCDNContent"}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div> 
    {if !is_null($emergencyPlan)}                        
    <div class="site-section">
        <div class="container">
            <h2 class="section-title text-center">{lang key="store.sitelock.emergencyPlanTitle"}</h2>
            <p class="section-subtitle text-center">{lang key="store.sitelock.emergencyPlanBody"}</p>
            <div class="section-content" id="emergency">
                <div class="emergency-title">
                    <h3>{lang key="store.sitelock.emergencyPlanHeadline"}</h3>
                </div>
                <div class="row row-eq-height row-eq-height-xs">
                    <div class="col-lg-4 col-md-6 col-sm-6 col-xs-12">
                        <div class="feature-wrapper">
                            <div class="content">
                                <span class="feature-number"> 1. </span>
                                <h4>{lang key="store.sitelock.emergencyPlanResponseTitle"}</h4>
                                <p>{lang key="store.sitelock.emergencyPlanResponseContent"}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6 col-sm-6 col-xs-12">
                        <div class="feature-wrapper">
                            <div class="content">
                                <span class="feature-number"> 2. </span>
                                <h4>{lang key="store.sitelock.emergencyPlanMalwareTitle"}</h4>
                                <p>{lang key="store.sitelock.emergencyPlanMalwareContent"}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6 col-sm-6 col-xs-12">
                        <div class="feature-wrapper">
                            <div class="content">
                                <span class="feature-number"> 3. </span>
                                <h4>{lang key="store.sitelock.emergencyPlanPriorityTitle"}</h4>
                                <p>{lang key="store.sitelock.emergencyPlanPriorityContent"}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6 col-sm-6 col-xs-12">
                        <div class="feature-wrapper">
                            <div class="content">
                                <span class="feature-number"> 4. </span>
                                <h4>{lang key="store.sitelock.emergencyPlanAftercareTitle"}</h4>
                                <p>{lang key="store.sitelock.emergencyPlanAftercareContent"}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6 col-sm-6 col-xs-12">
                        <div class="feature-wrapper">
                            <div class="content">
                                <span class="feature-number"> 5. </span>
                                <h4>{lang key="store.sitelock.emergencyPlanUpdatesTitle"}</h4>
                                <p>{lang key="store.sitelock.emergencyPlanUpdatesContent"}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6 col-sm-6 col-xs-12">
                        <div class="feature-wrapper">
                            <div class="content">
                                <span class="feature-number"> 6. </span>
                                <h4>{lang key="store.sitelock.emergencyPlanPaymentTitle"}</h4>
                                <p>{lang key="store.sitelock.emergencyPlanPaymentContent"}</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="banner-promo">
                    <div class="price"> {lang key="store.sitelock.emergencyPlanOnlyCost" price="<span>{if $emergencyPlan->pricing()->best()}{$emergencyPlan->pricing()->best()->toFullString()}{else}-{/if}</span>" }</div>
                    <form method="post" action="{routePath('cart-order')}">
                        <input type="hidden" name="pid" value="{$emergencyPlan->id}">
                        <button type="submit" class="btn btn-info">{lang key="store.sitelock.buyNow"}</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    {/if}
    <div class="site-section">
        <div class="container">
            <h2 class="section-title text-center">{lang key="store.sitelock.faqTitle"}</h2>
            <div class="section-content m-w-md m-a">    
                <div id="accordion">
                    <div class="panel panel-default panel-accordion is-open">
                        <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#what_is_SiteLock" aria-expanded="true">
                            <h4 class="panel-title"><i class="lm lm-plus"></i>{lang key="store.sitelock.faqOneTitle"}</h4>
                        </div>
                        <div id="what_is_SiteLock" class="panel-collapse collapse in" aria-expanded="true" style="">
                            <div class="panel-body">
                                <p>{lang key="store.sitelock.faqOneBody"}</p>
                                <p>{lang key="store.sitelock.faqOneBodyLearnMore" learnMoreLink={$learnMoreLink}}</p>
                            </div>
                        </div>        
                    </div>
                    <div class="panel panel-default panel-accordion">
                        <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#what_does_SiteLock_do" aria-expanded="true">
                            <h4 class="panel-title"><i class="lm lm-plus"></i>{lang key="store.sitelock.faqTwoTitle"}</h4>
                        </div>
                        <div id="what_does_SiteLock_do" class="panel-collapse collapse" aria-expanded="true" style="">
                            <div class="panel-body">
                                <p>{lang key="store.sitelock.faqTwoBody"}</p>
                            </div>
                        </div>        
                    </div>
                    <div class="panel panel-default panel-accordion">
                        <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#what_types_of_issues_does_SiteLock_scan_for" aria-expanded="true">
                            <h4 class="panel-title"><i class="lm lm-plus"></i>{lang key="store.sitelock.faqThreeTitle"}</h4>
                        </div>
                        <div id="what_types_of_issues_does_SiteLock_scan_for" class="panel-collapse collapse" aria-expanded="true" style="">
                            <div class="panel-body">
                                <p>{lang key="store.sitelock.faqThreeBody"} </p>
                                <ul>
                                    <li><strong>{lang key="store.sitelock.faqThreeBodyList1Title"}:</strong> {lang key="store.sitelock.faqThreeBodyList1"}</li>
                                    <li><strong>{lang key="store.sitelock.faqThreeBodyList2Title"}:</strong> {lang key="store.sitelock.faqThreeBodyList2"}</li>
                                    <li><strong>{lang key="store.sitelock.faqThreeBodyList3Title"}:</strong> {lang key="store.sitelock.faqThreeBodyList3"}</li>
                                </ul>
                            </div>
                        </div>        
                    </div>
                    <div class="panel panel-default panel-accordion">
                        <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#what_are_vulnerabilities_and_malware" aria-expanded="true">
                            <h4 class="panel-title"><i class="lm lm-plus"></i>{lang key="store.sitelock.faqFourTitle"}</h4>
                        </div>
                        <div id="what_are_vulnerabilities_and_malware" class="panel-collapse collapse" aria-expanded="true" style="">
                            <div class="panel-body">
                                <p>{lang key="store.sitelock.faqFourBodyParagraph1" vulnerabilityStrong="<strong>{lang key="store.sitelock.websiteVulnerability"}</strong>"}</p>
                                <p>{lang key="store.sitelock.faqFourBodyParagraph2" malwareStrong="<strong>{lang key="store.sitelock.malware"}</strong>"}</p>
                            </div>
                        </div>        
                    </div>
                    <div class="panel panel-default panel-accordion">
                        <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#will_SiteLock_impact_website_performance" aria-expanded="true">
                            <h4 class="panel-title"><i class="lm lm-plus"></i>{lang key="store.sitelock.faqFiveTitle"}</h4>
                        </div>
                        <div id="will_SiteLock_impact_website_performance" class="panel-collapse collapse" aria-expanded="true" style="">
                            <div class="panel-body">
                                <p>{lang key="store.sitelock.faqFiveBody"}</p>
                            </div>
                        </div>        
                    </div>
                    <div class="panel panel-default panel-accordion">
                        <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#are_the_backups_encrypted" aria-expanded="true">
                            <h4 class="panel-title"><i class="lm lm-plus"></i>{lang key="store.sitelock.faqSixTitle"}</h4>
                        </div>
                        <div id="are_the_backups_encrypted" class="panel-collapse collapse" aria-expanded="true" style="">
                            <div class="panel-body">
                                <p>{lang key="store.sitelock.faqSixBody"}</p>
                            </div>
                        </div>        
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
{/if}