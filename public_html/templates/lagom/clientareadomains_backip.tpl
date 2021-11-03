{if isset($RSThemes.pages.clientareadomains)}
    {include file=$RSThemes['pages']['clientareadomains']['fullPath']}
{else}
    {if $warnings}
        {include file="$template/includes/alert.tpl" type="warning" msg=$warnings textcenter=true}
    {/if}
    {if $domains}
        {include file="$template/includes/tablelist.tpl" tableName="DomainsList" noSortColumns="0, 5" startOrderCol="1" filterColumn="4"}
        <script type="text/javascript">
            jQuery(document).ready(function () {
                var table = jQuery('#tableDomainsList').removeClass('hidden').DataTable();
                {if $orderby == 'domain'}
                table.order(1, '{$sort}');
                {elseif $orderby == 'nextduedate'}
                table.order(2, '{$sort}');
                {elseif $orderby == 'autorenew'}
                table.order(3, '{$sort}');
                {elseif $orderby == 'status'}
                table.order(4, '{$sort}');
                {/if}
                table.draw();
                jQuery('.table-container').removeClass('loading');
                jQuery('#tableLoading').addClass('hidden');
                {literal}
                setTimeout(function () {
                    checkAll()
                }, 500);
                {/literal}
            });
        </script>
        <form id="domainForm" method="post" action="clientarea.php?action=bulkdomain">
            <input id="bulkaction" name="update" type="hidden"/>
            <div class="table-container loading clearfix">
                <!--
                <div class="table-top">

                    <div class="d-flex">
                        <label>{$LANG.clientareahostingaddonsview}</label>

                        <div class="dropdown view-filter-btns">
                            <button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown">
                                <span>{$rslang->trans('generals.all_entries')}</span>
                                <i class="ls ls-caret"></i>
                            </button>

                            <ul class="dropdown-menu" role="menu">
                                <li><a href="#"><span data-value="all">{$rslang->trans('generals.all_entries')}</span></a></li>
                                {foreach key=num item=status from=$RSDomainsStatuses}
                                    <li><a href="#"><span data-value="{$status.statustext}">{$status.statustext}</span></a></li>
                                {/foreach}
                            </ul>
                        </div>

                    </div>

                </div>
                 -->
                <table id="tableDomainsList" class="table table-list">
                    
                    <thead>
                    <tr>
                        <th class="cell-checkbox" data-priority="1" width="0">
                            <button type="button" class="btn-table-collapse"></button>
                            <input id="selectAll" class="icheck-control" type="checkbox" name="domids[]" class>
                        </th>
                        <th data-priority="1"><span><span>{$LANG.orderdomain}</span><span class="sorting-arrows"></span></span>
                        </th>
                        <th data-priority="5"><span><span>{$LANG.nextdue}</span><span
                                        class="sorting-arrows"></span></span></th>
                        <th data-priority="4"><span><span>{$LANG.domainsautorenew}</span><span
                                        class="sorting-arrows"></span></span></th>
                        <th data-priority="3"><span><span>{$LANG.domainstatus}</span><span
                                        class="sorting-arrows"></span></span></th>
                        <th data-priority="2"></th>

                    </tr>
                    </thead>
                    <tbody>
                    {foreach key=num item=domain from=$domains}
                        <tr data-url="clientarea.php?action=domaindetails&amp;id={$domain.id}">
                            <td class="cell-checkbox">
                                <button type="button" class="btn-table-collapse"></button>
                                <input type="checkbox" name="domids[]" class="domids stopEventBubble icheck-control"
                                       value="{$domain.id}"/>
                            </td>
                            <td data-sort="{$domain.domain}">
                                <!--<span class="ssl-info" data-element-id="{$domain.id}" data-type="domain" data-domain="{$domain.domain}">
                                    {if $domain.sslStatus}
                                        {assign var="awords" value="/"|explode:$domain.sslStatus->getImagePath()}
                                        {assign var="imageSSL" value=$awords|@end}
                                        <img id="sslStatus{$domain.id}" src="{$WEB_ROOT}/templates/{$template}/assets/img/ssl/12x12/{$imageSSL|replace:".png":".svg"}" data-toggle="tooltip" title="{$domain.sslStatus->getTooltipContent()}" width="12px" data-maintemplate="{$template}" class="ssl-status {$domain.sslStatus->getClass()}"/>
                                    {elseif !$domain.isActive}
                                        <img id="sslStatus{$service.id}" src="{$WEB_ROOT}/templates/{$template}/assets/img/ssl/12x12/ssl-inactive-domain.svg" data-toggle="tooltip" title="{lang key='sslState.sslInactiveDomain'}" data-maintemplate="{$template}" width="12px" class="ssl-status"/>
                                    {/if}
                                </span>--><a href="http://{$domain.domain}" target="_blank">{$domain.domain}</a>

                            </td>
                            <td><span class="hidden">{$domain.normalisedNextDueDate}</span>{$domain.nextduedate}</td>
                            <td>
                                <div style="">
                                    {if $domain.autorenew}
                                        {$LANG.domainsautorenewenabled}

                                    {else}
                                        {$LANG.domainsautorenewdisabled}
                                    {/if}
                                </div>
                            </td>
                            <td>


                                {if in_array($domain.id,$hureg_details['domain_ids'])}

                                    {if $hureg_details[$domain.id]['confirmation_is_required'] and $hureg_details[$domain.id]['confirmation_status_color'] == "unpaid" }
                                        <span class="status status-{$hureg_details[$domain.id]['confirmation_status_color']}"> {$hureg_details[$domain.id]['confirmation_status_text']}</span>
                                    {else}
                                        <span class="status status-{$hureg_details[$domain.id]['status_color']}"> {$hureg_details[$domain.id]['status_text']} </span>
                                    {/if}

                                {else}
                                    <span class="status status-{$domain.statusClass}">{$domain.statustext}</span>
                                {/if}


                                <span class="hidden">
                                    {* {if $domain.next30}<span>{$LANG.domainsExpiringInTheNext30Days}</span><br />{/if}
                                    {if $domain.next90}<span>{$LANG.domainsExpiringInTheNext90Days}</span><br />{/if}
                                    {if $domain.next180}<span>{$LANG.domainsExpiringInTheNext180Days}</span><br />{/if}
                                    {if $domain.after180}<span>{$LANG.domainsExpiringInMoreThan180Days}</span>{/if} *}
                                    {if $domain.expiringSoon}<span>{lang key="domainsExpiringSoon"}</span>{/if}
                                </span>
                            </td>
                            <td class="cell-action">
                                <div class="dropdown">
                                    <a href="#" class="btn btn-icon dropdown-toggle" data-toggle="dropdown">
                                        <i class="lm lm-more"></i>
                                    </a>
                                    <ul class="dropdown-menu  pull-right" role="menu">
                                        <li>
                                            <a href="clientarea.php?action=domaindetails&id={$domain.id}">{$LANG.managedomain}</a>
                                        </li>
                                        {if $allowrenew || $domain.status eq 'Active'}
                                            <li class="divider"></li>
                                        {/if}
                                        {if $domain.status eq 'Active'}
                                            <li>
                                                <a href="clientarea.php?action=domaindetails&id={$domain.id}#tabNameservers">{$LANG.domainmanagens}</a>
                                            </li>
                                            <li>
                                                <a href="clientarea.php?action=domaincontacts&domainid={$domain.id}">{$LANG.domaincontactinfoedit}</a>
                                            </li>
                                            <li>
                                                <a href="clientarea.php?action=domaindetails&id={$domain.id}#tabAutorenew">{$LANG.domainautorenewstatus}</a>
                                            </li>
                                        {/if}
                                        {if $allowrenew}
                                            {if $domain.canDomainBeManaged}
                                                <li>
                                                    <a href="{routePath('domain-renewal', $domain.domain)}">{lang key='domainsrenew'}</a>
                                                </li>
                                            {else}
                                                <li class="disabled"><a href="#" onclick="return false;"
                                                                        class="disabled"
                                                                        disabled="disabled">{lang key='domainsrenew'}</a>
                                                </li>
                                            {/if}
                                        {/if}
                                    </ul>
                                </div>
                            </td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
                <div class="loader loader-table" id="tableLoading">
                    {include file="$template/includes/loader.tpl"}
                </div>
            </div>
            <div class="bottom-action-sticky container">
                <div class="container">
                    <div class="d-flex space-between">
                        <div class="content d-flex align-center justify-center">
                            <div class="badge" id="domainSelectedCounter">0</div>
                            <span class="m-l-8">{$rslang->trans('domains.domains_selected')}</span>
                        </div>
                        <div class="content">
                            <div class="content-actions">
                                <a href="#" id="nameservers" class="setBulkAction btn btn-link">
                                    <i class="ls ls ls-share"></i>
                                    <span class="btn-text">{$LANG.domainmanagens}</span>
                                </a>
                                <a href="#" id="autorenew" class="setBulkAction btn btn-link">
                                    <i class="ls ls-user"></i>
                                    <span class="btn-text">{$LANG.domainautorenewstatus}</span>
                                </a>
                                <a href="#" id="reglock" class="setBulkAction btn btn-link">
                                    <i class="ls ls-refresh"></i>
                                    <span class="btn-text">{$LANG.domainreglockstatus}</span>
                                </a>
                                <a href="#" id="contactinfo" class="setBulkAction btn btn-link">
                                    <i class="ls ls-shield"></i>
                                    <span class="btn-text">{$LANG.domaincontactinfoedit}</span>
                                </a>
                                {if $allowrenew}
                                    <a href="#" id="renewDomains" class="setBulkAction btn btn-link">
                                        <i class="ls ls-refresh"></i>
                                        <span class="btn-text">{lang key='domainmassrenew'}</span>
                                    </a>
                                {/if}
                            </div>
                            <div class="content-dropdown">
                                <div class="dropdown">
                                    <button type="button" class="btn btn-link dropdown-toggle drop-up"
                                            data-toggle="dropdown">
                                        {$LANG.withselected} <i class="ls ls-caret"></i>
                                    </button>
                                    <ul class="dropdown-menu dropdown-menu-right" role="menu">
                                        <li><a href="#" id="nameservers"
                                               class="setBulkAction"> {$LANG.domainmanagens}</a></li>
                                        <li><a href="#" id="autorenew"
                                               class="setBulkAction">{$LANG.domainautorenewstatus}</a></li>
                                        <li><a href="#" id="reglock"
                                               class="setBulkAction">{$LANG.domainreglockstatus}</a></li>
                                        <li><a href="#" id="contactinfo"
                                               class="setBulkAction">{$LANG.domaincontactinfoedit}</a></li>
                                        {if $allowrenew}
                                            <li><a href="#" id="renewDomains"
                                                   class="setBulkAction">{lang key='domainmassrenew'}</a></li>
                                        {/if}
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    {else}
        <div class="message message-no-data">
            <div class="message-image">
                {include file="$template//assets/svg-icon/domain.tpl"}
            </div>
            <h6 class="message-text">{$LANG.clientareadomainnone}</h6>
            <div class="message-action">
                <a class="btn btn-primary" href="{$WEB_ROOT}/cart.php?a=add&domain=register">
                    {$LANG.orderregisterdomain}
                </a>
            </div>
        </div>
    {/if}
{/if}