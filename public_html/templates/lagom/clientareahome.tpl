{if isset($RSThemes.pages.clientareahome)}
    {include file=$RSThemes['pages']['clientareahome']['fullPath']}
{else}
    {foreach $panels as $item}
        {if $item->getName() == "Overdue Invoices" || $item->getName() == "Domains Expiring Soon"}
            {assign var=clienthomealerts value=true}
        {/if}
    {/foreach}
    {if $clienthomealerts}
        <div class="client-home-alerts alert-group">
            {foreach $panels as $item}
                {if $item->getName() == "Overdue Invoices" || $item->getName() == "Unpaid Invoices" || $item->getName() == "Domains Expiring Soon"}
                    <div class="alert alert-warning alert-faded alert-dismissible"
                         href="{if $item->getName() == "Overdue Invoices"}{$WEB_ROOT}/clientarea.php?action=invoices{else}{$WEB_ROOT}/index.php?rp=/cart/domain/renew{/if}">
                        <span class="alert-icon ls ls-exclamation-circle"></span>
                        <div class="alert-body">{$item->getBodyHtml()}</div>
                        <div class="alert-actions">
                            {if $item->getExtra('btn-link')}
                                {if $item->getName() == "Overdue Invoices" || $item->getName() == "Unpaid Invoices"}
                                    <a class="btn btn-sm btn-icon" href="{$WEB_ROOT}/clientarea.php?action=invoices"
                                       data-toggle="tooltip" data-title="{$LANG.invoicespaynow}"
                                       data-container="body"><span class="ls ls-wallet"></span></a>
                                {else}
                                    <a class="btn btn-sm btn-icon" href="{$WEB_ROOT}/index.php?rp=/cart/domain/renew"
                                       data-toggle="tooltip" data-title="{$LANG.domainrenew}" data-container="body"
                                       data-original-title="" title=""><span class="ls ls-refresh"></span></a>
                                {/if}
                            {/if}
                            <button class="btn btn-sm btn-icon" type="button" data-dismiss="alert" data-toggle="tooltip"
                                    data-title="{$LANG.supportticketsclose}" aria-label="{$LANG.supportticketsclose}"
                                    data-container="body"><span class="ls ls-close"></span></button>
                        </div>
                    </div>
                {/if}
            {/foreach}
        </div>
    {/if}
    {foreach $addons_html.0.RSMarketConnectServices as $addon}
        {if $addon['settings']['promotion']['client-home'] eq true}
            {assign var="hasDashboardPrormo" value=true}
        {/if}
    {/foreach}
    {if $promoSliderExtension && $promoBannerStatus eq '1'}
        {include file="$template/core/extensions/PromoBanners/promo-slide.tpl" setting="client-home"}
    {elseif $hasDashboardPrormo}
        {include file="$template/includes/promo-slider.tpl" setting="client-home"}
    {/if}
    {include file="$template/includes/flashmessage.tpl"}
    <div class="tiles clearfix swiper-container">
        <div class="row swiper-wrapper">
            <div class="col-sm-3 swiper-slide" onclick="window.location='clientarea.php?action=services'">
                <a class="tile" href="clientarea.php?action=services">
                    <div class="icon"><i class="ls ls-hosting"></i></div>
                    <div class="stat">{$clientsstats.productsnumactive}</div>
                    <div class="title">{$LANG.navservices}</div>
                </a>
            </div>
            {if $clientsstats.numdomains || $registerdomainenabled || $transferdomainenabled}
                <div class="col-sm-3 swiper-slide" onclick="window.location='clientarea.php?action=domains'">
                    <a class="tile" href="clientarea.php?action=domains">
                        <div class="icon"><i class="ls ls-dns"></i></div>
                        <div class="stat">{$clientsstats.numactivedomains}</div>
                        <div class="title"> {$LANG.navdomains}</div>
                    </a>
                </div>
            {elseif $condlinks.affiliates && $clientsstats.isAffiliate}
                <div class="col-sm-3 swiper-slide" onclick="window.location='affiliates.php'">
                    <a class="tile" href="affiliates.php">
                        <div class="icon"><i class="ls ls-wallet"></i></div>
                        <div class="stat">{$clientsstats.numaffiliatesignups}</div>
                        <div class="title">{$LANG.affiliatessignups}</div>
                    </a>
                </div>
            {else}
                <div class="col-sm-3 swiper-slide" onclick="window.location='clientarea.php?action=quotes'">
                    <a class="tile" href="clientarea.php?action=quotes">
                        <div class="icon"><i class="ls ls-document"></i></div>
                        <div class="stat">{$clientsstats.numquotes}</div>
                        <div class="title">{$LANG.quotes}</div>
                    </a>
                </div>
            {/if}
            <div class="col-sm-3 swiper-slide" onclick="window.location='clientarea.php?action=invoices'">
                <a class="tile" href="clientarea.php?action=invoices">
                    <div class="icon"><i class="ls ls-document"></i></div>
                    <div class="stat">{$clientsstats.numunpaidinvoices}</div>
                    <div class="title">{$LANG.clientHomePanels.unpaidInvoices}</div>
                </a>
            </div>
            <div class="col-sm-3 swiper-slide" onclick="window.location='supporttickets.php'">
                <a class="tile" href="supporttickets.php">
                    <div class="icon"><i class="ls ls-ticket-tag"></i></div>
                    <div class="stat">{if $supportPalactiveTicketsNum}{$supportPalactiveTicketsNum}{else}{$clientsstats.numactivetickets}{/if}</div>
                    <div class="title">{$LANG.navtickets}</div>
                </a>
            </div>
        </div>
        <div class="swiper-pagination"></div>
    </div>
    {foreach from=$addons_html item=addon_html key=k}
        {if $addons_html.0.RSMarketConnectServices && $addons_html.0.RSMarketConnectSidebars != ""}
            {if $k != '0' && $k != '1'}
                {$addon_html}
            {/if}
        {else}
            {if !$addon_html@first}
                {$addon_html}
            {/if}
        {/if}
    {/foreach}
    <div class="client-home-panels row" data-panels-grid>
        {function name=outputHomePanels}
            <div menuItemName="{$item->getName()}"
                 class="panel panel-default panel-accent-{$item->getExtra('color')} {if $item->getName() == "Affiliate Program"}panel-affilaite-program panel-info{elseif $item->getName() == "Register a New Domain"}panel-domain-register{elseif $item->getName() == "Recent Support Tickets"}panel-support-tickets{elseif $item->getName() == "Active Products/Services"}panel-active-services{/if}  {if $item->getClass()} {$item->getClass()}{/if}"{if $item->getAttribute('id')} id="{$item->getAttribute('id')}"{/if}>
                <div class="panel-heading">
                    <h3 class="panel-title">
                        {if $item->getExtra('btn-link') && $item->getExtra('btn-text')}
                            <div class="pull-right">
                                <a href="{$item->getExtra('btn-link')}"
                                   class="btn btn-default bg-color-{$item->getExtra('color')} btn-xs">
                                    {if $item->getExtra('btn-icon')}<i class="{$item->getExtra('btn-icon')}"></i>{/if}
                                    {$item->getExtra('btn-text')}
                                </a>
                            </div>
                        {/if}
                        {if $item->hasIcon()}
                            {if $item->getName() == "Active Products/Services"}
                                <i class="ls ls-hosting"></i>
                            {elseif $item->getName() == "Recent Support Tickets"}
                                <i class="ls ls-ticket-tag"></i>
                            {elseif $item->getName() == "Recent News"}
                                <i class="ls ls-text-cloud"></i>
                            {elseif $item->getName() == "Affiliate Program"}
                                <i class="ls ls-text-cloud"></i>
                            {elseif $item->getName() == "Register a New Domain"}
                            {elseif $item->getName() == "SitelockLogin"}
                                <i class="ls ls-shield"></i>
                            {elseif $item->getName() == "SpamexpertsLogin"}
                                <i class="ls ls-envelope"></i>
                            {elseif $item->getName() == "WeeblyLogin"}
                                <i class="ls ls-dashboard"></i>
                            {else}
                                <i class="{$item->getIcon()}"></i>
                            {/if}
                        {/if}
                        {$item->getLabel()}
                        {if $item->hasBadge()}<span class="badge">{$item->getBadge()}</span>{/if}
                    </h3>
                </div>
                
                {if $item->hasChildren()}
                    <div class="list-group{if $item->getChildrenAttribute('class')} {$item->getChildrenAttribute('class')}{/if}">
                        {foreach $item->getChildren() as $childItem}
                            {if $childItem->getUri()}
                                <a menuItemName="{$childItem->getName()}" href="{$childItem->getUri()}"
                                   class="list-group-item{if $childItem->getClass()} {$childItem->getClass()}{/if}{if $childItem->isCurrent()} active{/if}"{if $childItem->getAttribute('dataToggleTab')} data-toggle="tab"{/if}{if $childItem->getAttribute('target')} target="{$childItem->getAttribute('target')}"{/if}
                                   id="{$childItem->getId()}">
                                    {if $childItem->hasIcon()}<i class="{$childItem->getIcon()}"></i>&nbsp;{/if}
                                    {$childItem->getLabel()|replace:"background-color":"--status-color"|replace:'class="label"':'class="status"'|replace:'class="label pull-right label-':'class="status pull-right status-'}
                                    {if $childItem->hasBadge()}&nbsp;<span
                                            class="badge">{$childItem->getBadge()}</span>{/if}
                                </a>
                            {else}
                                <div menuItemName="{$childItem->getName()}"
                                     class="list-group-item{if $childItem->getClass()} {$childItem->getClass()}{/if}"
                                     id="{$childItem->getId()}">
                                    {if $childItem->hasIcon()}<i class="{$childItem->getIcon()}"></i>&nbsp;{/if}
                                    {$childItem->getLabel()}
                                    {if $childItem->hasBadge()}&nbsp;<span
                                            class="badge">{$childItem->getBadge()}</span>{/if}
                                </div>
                            {/if}
                        {/foreach}
                    </div>
                {elseif $item->hasBodyHtml()}
                    <div class="panel-body">
                        {if $item->getName() == "Recent News"}
                            <div class="panel-body">
                                <div class="no-data">
                                    <div class="no-data-icon">
                                        {include file="$template/assets/svg-icon/article.tpl"}
                                    </div>
                                    <div class="text-light">{$rslang->trans('nodata.no_recent_news')}</div>
                                </div>
                            </div>
                        {/if}
                        {if $item->getName() == "Recent Support Tickets"}
                            <div class="no-data">
                                <div class="no-data-icon">
                                    {include file="$template/assets/svg-icon/ticket.tpl"}
                                </div>
                                <div class="text-light">{$rslang->trans('nodata.no_recent_tickets')}</div>
                                <a href="submitticket.php">{$LANG.navopenticket}</a>
                            </div>
                        {elseif $item->getName() == "Active Products/Services"}
                            <div class="no-data">
                                <div class="no-data-icon">
                                    {include file="$template/assets/svg-icon/service.tpl"}
                                </div>
                                <div class="text-light">{$rslang->trans('nodata.no_active_services')}</div>
                                <a href="cart.php">{$LANG.navservicesorder}</a>
                            </div>
                        {elseif $item->getName() == "Unpaid Invoices" && $clientsstats.numunpaidinvoices == "0"}
                            <div class="no-data">
                                <div class="no-data-icon">
                                    {include file="$template/assets/svg-icon/invoice.tpl"}
                                </div>
                                <div class="text-light">{$rslang->trans('nodata.no_unpaid_invoices')}</div>
                            </div>
                        {else}
                            {$item->getBodyHtml()|replace:'name="domain"':'name="domain" placeholder="domain name"'|replace:'domain name':{$LANG.findyourdomain}}
                            {if $item->getName() == "Register a New Domain"}
                                <p>{$LANG.orderForm.transferExtend}*</p>
                            {/if}
                        {/if}
                    </div>
                {/if}
                {if !$item->hasChildren() && $item->getName() == "Recent News"}
                    <div class="panel-body">
                        <div class="no-data">
                            <div class="no-data-icon">
                                {include file="$template/assets/svg-icon/article.tpl"}
                            </div>
                            <div class="text-light">{$rslang->trans('nodata.no_recent_news')}</div>
                        </div>
                    </div>
                {/if}
                {if $item->hasFooterHtml()}
                    <div class="panel-footer">
                        {$item->getFooterHtml()}
                    </div>
                {/if}
            </div>
        {/function}
        {foreach $panels as $item}
            {if $item->getName() != "Overdue Invoices" && $item->getName() != "Unpaid Invoices" && $item->getName() != "Domains Expiring Soon"}
                <div class="col-sm-6 col-xs-12" data-panels-grid-item>
                    {outputHomePanels}
                </div>
            {/if}
        {/foreach}
    </div>
{/if}
