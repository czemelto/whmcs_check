{if isset($RSThemes.pages.clientareaproducts)}
    {include file=$RSThemes['pages']['clientareaproducts']['fullPath']}
{else}  
    {if $services}
        {include file="$template/includes/tablelist.tpl" tableName="ServicesList" filterColumn="3"}
        <script type="text/javascript">
            jQuery(document).ready( function ()
            {
                var table = jQuery('#tableServicesList').removeClass('hidden').DataTable();
                {if $orderby == 'product'}
                    table.order([0, '{$sort}'], [3, 'asc']);
                {elseif $orderby == 'amount' || $orderby == 'billingcycle'}
                    table.order(1, '{$sort}');
                {elseif $orderby == 'nextduedate'}
                    table.order(2, '{$sort}');
                {elseif $orderby == 'domainstatus'}
                    table.order(3, '{$sort}');
                {/if}
                table.draw();
                jQuery('.table-container').removeClass('loading');
                jQuery('#tableLoading').addClass('hidden');
            });
        </script>
        <div class="table-container clearfix loading">
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
                            {foreach key=num item=status from=$RSHookServicesStatuses}
                                <li><a href="#"><span data-value="{$status.statustext}">{$status.statustext}</span></a></li>
                            {/foreach}
                        </ul>
                    </div>           
                </div>
            </div>
            <table id="tableServicesList" class="table table-list dataTable">
                <thead>
                    <tr>
                        <th data-priority="1"><button type="button" class="btn-table-collapse"></button>{$LANG.orderproduct}<span class="sorting-arrows"></span></th>
                        <th data-priority="5">{$LANG.clientareaaddonpricing}<span class="sorting-arrows"></span></th>
                        <th data-priority="4">{$LANG.clientareahostingnextduedate}<span class="sorting-arrows"></span></th>
                        <th data-priority="3">{$LANG.clientareastatus}<span class="sorting-arrows"></span></th>     
                        <th data-priority="2">&nbsp;</th>        
                    </tr>
                </thead>
                <tbody>
                    {foreach key=num item=service from=$services}
                        <tr data-url="clientarea.php?action=productdetails&amp;id={$service.id}">
                            <td>
                                <button type="button" class="btn-table-collapse"></button>
                                {$service.group} - <strong>{$service.product}</strong>
                                {if $service.domain}
                                <br />
                                <div class="ssl-info" data-element-id="{$service.id}" data-type="service"{if $service.domain} data-domain="{$service.domain}"{/if}>
                                    {if $service.sslStatus}
                                        {assign var="awords" value="/"|explode:$service.sslStatus->getImagePath()} 
                                        {assign var="imageSSL" value=$awords|@end}
                                        <img id="sslStatus{$service.id}" src="{$WEB_ROOT}/templates/{$template}/assets/img/ssl/12x12/{$imageSSL|replace:".png":".svg"}" data-toggle="tooltip" title="{$service.sslStatus->getTooltipContent()}" width="12px" class="ssl-status{$service.sslStatus->getClass()}"/>
                                    {elseif !$service.isActive}
                                        <img id="sslStatus{$service.id}" src="{$WEB_ROOT}/templates/{$template}/assets/img/ssl/12x12/ssl-inactive-domain.svg" data-toggle="tooltip" title="{lang key='sslState.sslInactiveService'}" width="12px" class="ssl-status"/>
                                    {/if}
                                </div><a class="text-small" href="http://{$service.domain}" target="_blank">{$service.domain}</a>                                
                                {/if}
                            </td>
                            <td class="text-center text-nowrap" data-order="{$service.amountnum}">{$service.amount}<br /> <span class="small">{$service.billingcycle}</span> </td>
                            <td class="text-center text-nowrap"><span class="hidden">{$service.normalisedNextDueDate}</span>{$service.nextduedate}</td>
                            <td class="text-center text-nowrap"><span class="status status-{$service.status|strtolower}">{$service.statustext}</span></td>
                            <td class="cell-action">
                                <div class="dropdown">
                                    <a href="#" class="btn btn-icon dropdown-toggle" data-toggle="dropdown">
                                        <i class="lm lm-more"></i>
                                    </a>
                                    <ul class="dropdown-menu  pull-right" role="menu">                                        
                                        <li><a href="clientarea.php?action=productdetails&id={$service.id}">{$LANG.clientareaviewdetails}</a></li>
                                        {if $service.rawstatus == "active" && ($service.downloads || $service.addons || $service.packagesupgrade)}
                                            <li class="divider"></li>
                                            {if $service.downloads} <li><a href="clientarea.php?action=productdetails&id={$service.id}#tabDownloads">{$LANG.downloadstitle}</a></li>{/if}
                                            {if $service.addons} <li><a href="clientarea.php?action=productdetails&id={$service.id}#tabAddons">{$LANG.clientareahostingaddons}</a></li>{/if}
                                            {if $service.packagesupgrade} <li><a href="upgrade.php?type=package&id={$service.id}">{$LANG.upgradedowngradepackage}</a></li>{/if}
                                            {*{if $service.showcancelbutton} <li><a href="clientarea.php?action=cancel&id={$service.id}">{$LANG.clientareacancelrequestbutton}</a></li>{/if}*}
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
    {else}
        <div class="message message-no-data">
            <div class="message-image">
                {include file="$template//assets/svg-icon/service.tpl"}        
            </div>
            <h6 class="message-text">{$LANG.clientHomePanels.activeProductsServicesNone}</h6>
            <div class="message-action">
                <a class="btn btn-primary" href="{$WEB_ROOT}/cart.php">
                    {$LANG.navservicesorder}
                </a>
            </div>
        </div>
    {/if}
{/if}


{literal}
<style>
.loader-ring {
  display: inline-block;
  position: relative;
  width: 32px;
  height: 32px;
}
.loader-ring-12 {
  width: 12px;
  height: 12px;
}
.loader-ring-18 {
  width: 18px;
  height: 18px;
}
.loader-ring div {
  box-sizing: border-box;
  display: block;
  position: absolute;
  width: 28px;
  height: 28px;
  margin: 2px;
  border: 2px solid #b9bdc5;
  border-radius: 50%;
  animation: lds-ring 1.2s cubic-bezier(0.5, 0, 0.5, 1) infinite;
  border-color: #b9bdc5 transparent transparent transparent;
}
.loader-ring-12 div {
    width: 10px;
    height: 10px;
    margin: 1px;
}
.loader-ring-18 div {
    width: 16px;
    height: 16px;
    margin: 1px;
}
.loader-ring div:nth-child(1) {
  animation-delay: -0.45s;
}
.loader-ring div:nth-child(2) {
  animation-delay: -0.3s;
}
.loader-ring div:nth-child(3) {
  animation-delay: -0.15s;
}
@keyframes lds-ring {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}
#tableServicesList .ssl-info {
    display: inline-block;
    vertical-align: middle;
    line-height: 12px;
}
#tableServicesList .ssl-info:empty {
    display: none;
}
#tableServicesList .ssl-info > * {
    vertical-align: top;
}

</style>
{/literal}