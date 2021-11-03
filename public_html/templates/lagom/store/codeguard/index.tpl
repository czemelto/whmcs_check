{if file_exists("templates/$template/store/codeguard/overwrites/index.tpl")}
    {include file="{$template}/store/codeguard/overwrites/index.tpl"}  
{else}     
<div class="site site-codeguard">
    <div class="site-banner">
        <div class="container">
            <div class="row d-flex">
                <div class="col-lg-6 col-md-8">
                    <div class="banner-content">
                        <h1 class="banner-title">
                            {lang key="store.codeGuard.headline"}
                        </h1>
                        <div class="banner-desc">
                            <p>{lang key="store.codeGuard.tagline"}</p>
                        </div>
                        <div class="banner-actions">
                            <a href="#" class="btn btn-lg btn-primary" onclick="smoothScroll('#pricing');return false">{lang key="store.codeGuard.tab.pricing"}</a>
                            <a href="#" class="btn btn-lg btn-outline btn-outline-light" onclick="smoothScroll('#overview');return false">{lang key="learnmore"}</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-4">
                    <div class="banner-graphic">
                        {if file_exists("templates/$template/assets/svg-illustrations/products/codeguard.tpl")}
                            {include file="$template/assets/svg-illustrations/products/codeguard.tpl"}
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
                            <img src="{$WEB_ROOT}/templates/{$template}/assets/img/store/codeguard/codeguard-dashboard.jpg" />
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="section-content">
                            <h2 class="section-title">{lang key="store.codeGuard.leadTitle"}</h2>
                            <div class="section-desc">
                                <p>{lang key="store.codeGuard.leadText1"}</p>
                                <p>{lang key="store.codeGuard.leadText2"}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="section-content">
                <div class="row row-features row-eq-height row-eq-height-xs justify-center">
                    <div class="col-lg col-md-4 col-sm-6">
                        <div class="feature feature-boxed">
                            <div class="feature-icon">
                                {if file_exists("templates/$template/assets/svg-icon/icon-automatic-daily-backup.tpl")}
                                    {include file="$template/assets/svg-icon/icon-automatic-daily-backup.tpl"}
                                {/if}
                            </div>
                            <div class="feature-content">
                                <h4 class="h6">
                                    {lang key="store.codeGuard.dailyBackup"}
                                </h4>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg col-md-4 col-sm-6">
                        <div class="feature feature-boxed">
                            <div class="feature-icon">
                                {if file_exists("templates/$template/assets/svg-icon/icon-website-time-maschine.tpl")}
                                    {include file="$template/assets/svg-icon/icon-website-time-maschine.tpl"}
                                {/if}
                            </div>
                            <div class="feature-content">
                                <h4 class="h6">
                                    {lang key="store.codeGuard.timeMachine"}
                                </h4>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg col-md-4 col-sm-6">
                        <div class="feature feature-boxed">
                            <div class="feature-icon">
                                {if file_exists("templates/$template/assets/svg-icon/icon-wordpress-plugin-updates.tpl")}
                                    {include file="$template/assets/svg-icon/icon-wordpress-plugin-updates.tpl"}
                                {/if}
                            </div>
                            <div class="feature-content">
                                <h4 class="h6">
                                    {lang key="store.codeGuard.wpPlugin"}
                                </h4>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg col-md-4 col-sm-6">
                        <div class="feature feature-boxed">
                            <div class="feature-icon">
                                {if file_exists("templates/$template/assets/svg-icon/icon-file-change-alert-monitoring.tpl")}
                                    {include file="$template/assets/svg-icon/icon-file-change-alert-monitoring.tpl"}
                                {/if}
                            </div>
                            <div class="feature-content">
                                <h4 class="h6">
                                    {lang key="store.codeGuard.changeAlerts"}
                                </h4>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg col-md-4 col-sm-6">
                        <div class="feature feature-boxed">
                            <div class="feature-icon">
                                {if file_exists("templates/$template/assets/svg-icon/icon-malware-detection-and-restore.tpl")}
                                    {include file="$template/assets/svg-icon/icon-malware-detection-and-restore.tpl"}
                                {/if}
                            </div>
                            <div class="feature-content">
                                <h4 class="h6">
                                    {lang key="store.codeGuard.malwareProtection"}
                                </h4>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="site-section section-dark" id="pricing">
        <div class="container">
            <h2 class="section-title text-center">{lang key='store.codeGuard.chooseBackupPlan'}</h2>
            <div class="section-content">
                {if count($products) > 0}
                    <div class="package-slider">
                        <div class="package-slider-body">
                            <div class="package-slider-top">
                                <div class="slider">
                                    <div class="slider-slide">
                                        <input type="hidden" id="codeGuardPlanSelector" name="codeguardplan" value="" />
                                    </div>
                                    <div class="slider-actions" id="codeGuardPlanActions">

                                    </div>
                                </div>
                            </div>  
                            <div class="package-slider-bottom {if !$loggedin && $currencies}has-currency{/if}">
                                <div class="package-slider-summary">
                                    <div class="package-slider-summary-item">
                                        <div class="package-slider-summary-label">
                                            Storage
                                        </div>  
                                        <div class="package-slider-summary-value">
                                            <span id="diskSpace"></span>
                                        </div>
                                    </div>
                                    <div class="package-slider-summary-item">
                                        <div class="package-slider-summary-label">
                                            {$LANG.orderprice}
                                        </div>  
                                        <div class="package-slider-summary-value">
                                            <div class="package-price">
                                                <div class="price">
                                                    <span class="price-prefix"></span>
                                                    <span id="pricingAmount"></span>
                                                    <span class="price-cycle" id="pricingCycle"></span>
                                                </div>                                 
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="package-slider-actions">
                                 {if !$loggedin && $currencies}
                                        <form method="post" action="{routePath('store-product-group', $routePathSlug)}">
                                            <select name="currency" class="form-control currency-selector" onchange="submit()">
                                                <option>{lang key="changeCurrency"} ({$activeCurrency.prefix} {$activeCurrency.code})</option>
                                                {foreach $currencies as $currency}
                                                    <option value="{$currency['id']}">{$currency['prefix']} {$currency['code']}</option>
                                                {/foreach}
                                            </select>
                                        </form>
                                    {/if}
                                    <form action="{routePath('cart-order')}" method="post">
                                        <input id="selectedProductId" type="hidden" name="pid" value="">
                                        <button type="submit" class="btn btn-primary btn-lg order-btn" id="product-order-button">
                                            {lang key='ordernowbutton'}
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                {elseif $inPreview}
                    <div class="alert alert-info">
                        <div class="alert-body">
                            {lang key="store.codeGuard.adminPreview"}
                        </div>
                    </div>
                {/if}             
            </div>
        </div>    
    </div>
     <div class="site-section">
        <div class="container">
            <div class="section-content">
                <div class="row row-eq-height row-eq-height-xs row-features">
                    <div class="col-lg-4 col-sm-6">
                        <div class="feature feature-xs-left">
                            <div class="feature-icon">
                                {if file_exists("templates/$template/assets/svg-icon/icon-daily-automatic-website-backups.tpl")}
                                    {include file="$template/assets/svg-icon/icon-daily-automatic-website-backups.tpl"}
                                {/if}
                            </div>
                            <div class="feature-content">
                                <h4 class="feature-title">{lang key="store.codeGuard.features.dailyBackup"}</h4>
                                <p class="feature-desc">{lang key="store.codeGuard.features.dailyBackupDescription"}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6">
                        <div class="feature feature-xs-left">
                            <div class="feature-icon">
                                {if file_exists("templates/$template/assets/svg-icon/icon-unlimited-files-and-databases.tpl")}
                                    {include file="$template/assets/svg-icon/icon-unlimited-files-and-databases.tpl"}
                                {/if}
                            </div>
                            <div class="feature-content">
                                <h4 class="feature-title">{lang key="store.codeGuard.features.unlimitedFiles"}</h4>
                                <p class="feature-desc">{lang key="store.codeGuard.features.unlimitedFilesDescription"}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6">
                        <div class="feature feature-xs-left">
                            <div class="feature-icon">
                                {if file_exists("templates/$template/assets/svg-icon/icon-one-click-restore.tpl")}
                                    {include file="$template/assets/svg-icon/icon-one-click-restore.tpl"}
                                {/if}
                            </div>
                            <div class="feature-content">
                                <h4 class="feature-title">{lang key="store.codeGuard.features.oneClickRestore"}</h4>
                                <p class="feature-desc">{lang key="store.codeGuard.features.oneClickRestoreDescription"}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6">
                        <div class="feature feature-xs-left">
                            <div class="feature-icon">
                                {if file_exists("templates/$template/assets/svg-icon/icon-malware-monitoring.tpl")}
                                    {include file="$template/assets/svg-icon/icon-malware-monitoring.tpl"}
                                {/if}
                            </div>
                            <div class="feature-content">
                                <h4 class="feature-title">{lang key="store.codeGuard.features.malwareMonitoring"}</h4>
                                <p class="feature-desc">{lang key="store.codeGuard.features.malwareMonitoringDescription"}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6">
                        <div class="feature feature-xs-left">
                            <div class="feature-icon">
                                {if file_exists("templates/$template/assets/svg-icon/icon-automatic-wordpress-update.tpl")}
                                    {include file="$template/assets/svg-icon/icon-automatic-wordpress-update.tpl"}
                                {/if}
                            </div>
                            <div class="feature-content">
                                <h4 class="feature-title">{lang key="store.codeGuard.features.wp"}</h4>
                                <p class="feature-desc">{lang key="store.codeGuard.features.wpDescription"}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6">
                        <div class="feature feature-xs-left">
                            <div class="feature-icon">
                                {if file_exists("templates/$template/assets/svg-icon/icon-file-change-monitoring.tpl")}
                                    {include file="$template/assets/svg-icon/icon-file-change-monitoring.tpl"}
                                {/if}
                            </div>
                            <div class="feature-content">
                                <h4 class="feature-title">{lang key="store.codeGuard.features.fileMonitoring"}</h4>
                                <p class="feature-desc">{lang key="store.codeGuard.features.fileMonitoringDescription"}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6">
                        <div class="feature feature-xs-left">
                            <div class="feature-icon">
                                {if file_exists("templates/$template/assets/svg-icon/icon-staging-of-restores.tpl")}
                                    {include file="$template/assets/svg-icon/icon-staging-of-restores.tpl"}
                                {/if}
                            </div>
                            <div class="feature-content">
                                <h4 class="feature-title">{lang key="store.codeGuard.features.servers"}</h4>
                                <p class="feature-desc">{lang key="store.codeGuard.features.serversDescription"}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6">
                        <div class="feature feature-xs-left">
                            <div class="feature-icon">
                                {if file_exists("templates/$template/assets/svg-icon/icon-email-backup.tpl")}
                                    {include file="$template/assets/svg-icon/icon-email-backup.tpl"}
                                {/if}
                            </div>
                            <div class="feature-content">
                                <h4 class="feature-title">{lang key="store.codeGuard.features.email"}</h4>
                                <p class="feature-desc">{lang key="store.codeGuard.features.emailDescription"}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6">
                        <div class="feature feature-xs-left">
                            <div class="feature-icon">
                                {if file_exists("templates/$template/assets/svg-icon/icon-full-automation.tpl")}
                                    {include file="$template/assets/svg-icon/icon-full-automation.tpl"}
                                {/if}
                            </div>
                            <div class="feature-content">
                                <h4 class="feature-title">{lang key="store.codeGuard.features.api"}</h4>
                                <p class="feature-desc">{lang key="store.codeGuard.features.apiDescription"}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>  
    <div class="site-section">
        <div class="container">
            <h2 class="section-title text-center">{lang key="store.codeGuard.faq.title"}</h2>
            <div class="section-content m-w-md m-a">    
                <div id="accordion">
                    {foreach from=$codeGuardFaqs item=$faq key=num}
                        <div class="panel panel-default panel-accordion {if $num == 0}is-open{/if}">
                            <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#codeguard_faq_{$num}" aria-expanded="true">
                                <h4 class="panel-title"><i class="lm lm-plus"></i>{$faq['question']}</h4>
                            </div>
                            <div id="codeguard_faq_{$num}" class="panel-collapse collapse {if $num == 0}in{/if} " aria-expanded="true" style="">
                                <div class="panel-body">
                                    <p>{$faq['answer']}</p>
                                </div>
                            </div>        
                        </div>
                    {/foreach}
                </div>
            </div>
        </div>
    </div>
</div>
<!-- RangeSlider JS -->
<script type="text/javascript" src="{$BASE_PATH_JS}/ion.rangeSlider.js"></script>
<script type="text/javascript">

    var sliderActivated = false;

    var sliderProductNames = [
    {foreach $products as $product}
        "{$product->diskSpace}",
    {/foreach}
    ];

    var allProducts = {
        {foreach $products as $num => $product}
        "{$num}": {
            "pid": "{$product->id}",
            "name": "{$product->name}",
            "desc": "{$product->formattedProductFeatures.featuresDescription|nl2br|trim}",
            "price": "{if $activeCurrency.prefix}<span class='price-prefix'>{$activeCurrency.prefix}</span>{/if}{$product->pricing()->first()->price()|replace:$activeCurrency.suffix:""|replace:$activeCurrency.prefix:""}{if $activeCurrency.suffix}{$activeCurrency.suffix}{/if}",
            "cycle": {if $product->pricing()->first()->cycle() eq "monthly"}"/{$rslang->trans('order.period.short.monthly')}"{elseif $product->pricing()->first()->cycle() eq "quarterly"}"/{$rslang->trans('order.period.short.quarterly')}"{elseif $product->pricing()->first()->cycle() eq "semiannually"}"/{$rslang->trans('order.period.short.semiannually')}"{elseif $product->pricing()->first()->cycle() eq "annually"}"/{$rslang->trans('order.period.short.annually')}"{elseif $product->pricing()->first()->cycle() eq "biennially"}"/{$rslang->trans('order.period.short.biennially')}"{elseif $product->pricing()->first()->cycle() eq "triennially"}"/{$rslang->trans('order.period.short.triennially')}"{/if},
            "diskspace": "{$product->diskSpace}"
        },
        {/foreach}
    };

    var definedProducts = {
        {foreach $products as $product}
            "{$product->id}": "{$product@index}"{if !($product@last)},{/if}
        {/foreach}
    };

    {foreach $products as $product}
        {if $product->isFeatured}
            var firstFeatured = definedProducts["{$product->id}"];
            {break}
        {/if}
    {/foreach}

    var rangeSliderValues = {
        type: "single",
        grid: false,
        grid_snap: true,
        hide_min_max: true,
        step: 1,
        from: 1,
        onStart: refreshSelectedProduct,
        {if $products|@count eq 1}
            disable: true,
        {/if}
        onChange: refreshSelectedProduct,
        onFinish: stopSliding,
        values: sliderProductNames
    };

    if (typeof firstFeatured !== 'undefined') {
        rangeSliderValues['from'] = firstFeatured;
    }

    var container = $('<div class="slider-actions-list"/>');

    $.each(sliderProductNames, function(i,val) {
        
        container.append('<div class="slider-actions-btn" data-sliderValue="'+i+'"><span>'+val+'</span></div>');
        
    });

    function refreshSelectedProduct(data)
    {
        var featureName = "";
        var featureMarkup = "";
        var i = parseInt(data.from);
        if (isNaN(i)) {
            i = 0;
            jQuery(".irs-single").text(sliderProductNames[0]);
            jQuery(".irs-grid-text").text('');
        }
        jQuery('.irs-slider').addClass('active');
        jQuery("#selectedProductId").val(allProducts[i].pid);
        jQuery("#productDescription").html(allProducts[i].desc);
        jQuery("#pricingAmount").html(allProducts[i].price);
        jQuery("#pricingCycle").html(allProducts[i].cycle);
        jQuery("#diskSpace").html(allProducts[i].diskspace);     
        jQuery('#codeGuardPlanActions').html(container);
        jQuery('.slider-actions-btn').removeClass('active');
        jQuery('.slider-actions-btn[data-sliderValue="'+i+'"]').addClass('active');     
    }
    function stopSliding(){
        jQuery('.irs-slider').removeClass('active');
    }
    jQuery("#codeGuardPlanSelector").ionRangeSlider(rangeSliderValues);
    {if $products|@count eq 1}
    jQuery(".irs-single").text(sliderProductNames[0]);
    jQuery(".irs-grid-text").text('');
    {/if}

    sliderActivated = true;

    let my_range = $("#codeGuardPlanSelector").data("ionRangeSlider");
    
    jQuery(document).on('click','.slider-actions-btn', function(){
        i = jQuery(this).data('slidervalue');
        my_range.update({literal}{from: i, to: i}{/literal});
        
        jQuery("#selectedProductId").val(allProducts[i].pid);
        jQuery("#productDescription").html(allProducts[i].desc);
        jQuery("#pricingAmount").html(allProducts[i].price);
        jQuery("#pricingCycle").html(allProducts[i].cycle);    
        jQuery("#diskSpace").html(allProducts[i].diskspace);     
        jQuery('#codeGuardPlanActions').html(container);
        jQuery('.slider-actions-btn').removeClass('active');
        jQuery('.slider-actions-btn[data-sliderValue="'+i+'"]').addClass('active');
    });
</script>
{/if}