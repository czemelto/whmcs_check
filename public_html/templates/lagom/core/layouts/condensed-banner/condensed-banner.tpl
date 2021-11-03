{if file_exists("templates/$template/core/layouts/{$RSThemes.layouts.name}/header.tpl")}
    {include file="{$template}/core/layouts/{$RSThemes.layouts.name}/header.tpl"}  
{/if}

{* Custom page titles
    - This is used to overwrite default titles shown in the page title/banner
*}

{if $rsactivepage == "Dashboard" || $rsactivepage =="Home"}
    {assign var=displayTitle value=$rslang->trans('generals.my_dashboard')}
{elseif $templatefile == "viewinvoice"}
    {assign var=displayTitle value=$LANG.invoicesview}
{elseif $templatefile == "viewquote"}
    {assign var=displayTitle value=$rslang->trans('billing.view_quote')}
{elseif $templatefile == "configureproduct"}
    {assign var=displayTitle value=$LANG.orderconfigure}
{elseif $templatefile == "configureproductdomain"}
    {assign var=displayTitle value=$LANG.domaincheckerchoosedomain}
{elseif $templatefile == "configuredomains"}
    {assign var=displayTitle value=$LANG.cartdomainsconfig}
{elseif $templatefile == "viewcart" ||  $templatefile == "checkout"}
    {assign var=displayTitle value=$LANG.cartreviewcheckout}
{elseif $templatefile == "domainregister"}
    {assign var=displayTitle value=$LANG.registerdomain}
{elseif $templatefile == "domaintransfer"}
    {assign var=displayTitle value=$LANG.transferdomain}
{elseif $templatefile == "domain-renewals"}
    {assign var=displayTitle value=$LANG.domainrenewals}
    {assign var=RSheaderRenewalSearch value=true}
{elseif $templatefile == "products"}
    {if $productGroup.headline}
        {assign var=displayTitle value=$productGroup.headline}
    {else}
        {assign var=displayTitle value=$productGroup.name}
    {/if}
{elseif $templatefile == "fraudcheck"}
    {assign var=displayTitle value=$LANG.cartfraudcheck}
{elseif $templatefile == "complete"}
    {assign var=displayTitle value=$LANG.orderconfirmation}
{elseif $templatefile == "error"}
    {assign var=displayTitle value=$LANG.thereisaproblem}
{elseif $templatefile == "clientareaproductdetails"}
    {assign var="displayTitle" value=$LANG.managing}    
{/if}

{* / Custom page titles *}
{if $RSThemes['pages'][$templatefile]['optionvars']['isFullPage'] !== true && $templatefile!="oauth/layout"}
    <div class="app-nav app-nav-condensed hidden-print">
        <section id="header">
            <div class="container">
                <button type="button" class="navbar-toggle">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                {if $RCLogo}
                    <a class="logo" href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}"><img src="{$WEB_ROOT}/{$RCLogo}" alt="{$companyname}" ></a>
                {elseif $MBLogo}
                    <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}"  class="logo"><img src="{$MBLogo}" alt="{$companyname}" ></a>
                {elseif $RSThemes.styles.vars.topMenuOnDarkBg}
                    {if $RSThemes.logo_inverse}
                        <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" class="logo"><img src="{$WEB_ROOT}{$RSThemes.logo_inverse}" alt="{$companyname}"/></a>
                    {elseif $RSThemes.logo}
                        <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" class="logo"><img src="{$WEB_ROOT}{$RSThemes.logo}" alt="{$companyname}"/></a>
                    {elseif $assetLogoPath}
                        <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" class="logo"><img src="{$assetLogoPath}" alt="{$companyname}"/></a>
                    {else}
                        <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" class="logo logo-text">{$companyname}</a>
                    {/if}
                {else}
                    {if $RSThemes.logo}
                        <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" class="logo"><img src="{$WEB_ROOT}{$RSThemes.logo}" alt="{$companyname}"/></a>
                    {elseif $assetLogoPath}
                        <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" class="logo"><img src="{$assetLogoPath}" alt="{$companyname}"/></a>
                    {else}
                        <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" class="logo logo-text">{$companyname}</a>
                    {/if}
                {/if}
            
                <ul class="top-nav">
                    {if $adminMasqueradingAsClient || $adminLoggedIn}
                        <li>
                            <a href="{$WEB_ROOT}/logout.php?returntoadmin=1" class="" data-toggle="tooltip" data-placement="bottom" title="{if $adminMasqueradingAsClient}{$LANG.adminmasqueradingasclient} {$LANG.logoutandreturntoadminarea}{else}{$LANG.adminloggedin} {$LANG.returntoadminarea}{/if}">
                                <i class="lm lm-arrow-fat-right"></i>
                            </a>
                        </li>
                    {/if}
                    <li>
                        <a href="{$WEB_ROOT}/cart.php?a=view">
                            <i class="lm lm-basket">{if $cartitemcount > 0}<span class="label label-info">&nbsp;</span>{/if}</i>
                        </a>
                    </li>
                    {if $loggedin}
                        <li class="notify">
                            <a href="#" data-toggle="dropdown">
                                <i class="lm lm-bell">
                                    {if count($clientAlerts) > 0}
                                        <span class="label label-info">{$LANG.notificationsnew}</span>
                                    {/if} 
                                </i>                           
                            </a>                        
                            <ul class="client-alerts dropdown-menu">
                                {if count($clientAlerts) > 0}
                                    <li class="client-alerts-header">{$LANG.notifications}</li>
                                {/if}
                                {foreach $clientAlerts as $alert}                               
                                    <li>
                                        <a href="{$alert->getLink()}">
                                            <i class="lm lm-{if $alert->getSeverity() == 'danger'}warning text-danger{elseif $alert->getSeverity() == 'warning'}warning text-warning{elseif $alert->getSeverity() == 'info'}info text-info {else}info text-success{/if}"></i>
                                            <div class="message">{$alert->getMessage()}</div>
                                        </a>
                                    </li>
                                {foreachelse}
                                    <li class="none">
                                        <div class="none-icon">
                                            {include file="$template//assets/svg-icon/notification.tpl"}
                                        </div>
                                        <span class="text-light">{$LANG.notificationsnone}</span>
                                    </li>
                                {/foreach}
                            </ul>
                        </li>
                    {/if}
                    {include file="$template/includes/navbar.tpl" navbar=$secondaryNavbar navtype="account"}
                </ul>
            </div>
        </section>    
        {include file="$template/includes/mainmenu.tpl" type="condensed"}
    </div>

    {if $templatefile != 'homepage' && $templatefile != 'affiliatessignup' && $custompage !='full'}
        {if !$skipMainBodyContainer && !$ignoreHeader}
            <div class="app-header main-header header-lined {if $RSheadercenter}text-center{/if}">
                <div class="container">
                    {if $inShoppingCart}
                        {include file="$template/includes/pageheader.tpl" title=$displayTitle desc=$tagline showbreadcrumb=false}
                    {else}
                        {include file="$template/includes/pageheader.tpl" title=$displayTitle desc=$tagline showbreadcrumb=true}
                    {/if}
                </div>
            </div>
        {/if}
    {/if}
{/if}
{if $templatefile != 'homepage' && $templatefile != 'affiliatessignup' && $custompage !='full'}   
<div class="app-main">    
    {if $loggedin}
        {include file="$template/includes/verifyemail.tpl"}
    {/if}
    <div class="main-body {$appMainBodyClasses}"> 
        <div class="container{if $skipMainBodyContainer}-fluid without-padding{/if}">
            <div class="main-grid  {if $mainGridNoSidebarClass && (!$primarySidebar->hasChildren() && !$secondarySidebar->hasChildren())}{$mainGridNoSidebarClass}{elseif $mainGridOrderClass}{$mainGridOrderClass}{elseif !$skipMainBodyContainer}row{/if}">
            {if !$ignoreHeader}
                {if !$ignoreSidebars && !$inShoppingCart && ($primarySidebar->hasChildren() || $secondarySidebar->hasChildren()) || ($forceSidebar && !$inShoppingCart)}
                    <div class="main-sidebar sidebar-primary col-md-3 pull-md-left sidebar">
                        {include file="$template/includes/sidebar.tpl" sidebar=$primarySidebar} 
                        {include file="$template/includes/sidebar-custom.tpl"} 
                    </div>
                    <div class="main-content col-md-9 pull-md-right">
                {elseif !$skipMainBodyContainer && !$inShoppingCart}
                    <div class="main-content col-md-12">   
                {/if}
            {/if}
{/if}
