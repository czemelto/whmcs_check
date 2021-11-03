{if isset($RSThemes.pages.clientareainvoices)}
    {include file=$RSThemes['pages']['clientareainvoices']['fullPath']}
{else}    
    {if $invoices}
        {include file="$template/includes/tablelist.tpl" tableName="InvoicesList" filterColumn="4"}
        <script type="text/javascript">
            jQuery(document).ready( function ()
            {
                var table = jQuery('#tableInvoicesList').removeClass('hidden').DataTable();
                {if $orderby == 'default'}
                    table.order([4, 'desc'], [2, 'asc']);
                {elseif $orderby == 'invoicenum'}
                    table.order(0, '{$sort}');
                {elseif $orderby == 'date'}
                    table.order(1, '{$sort}');
                {elseif $orderby == 'duedate'}
                    table.order(2, '{$sort}');
                {elseif $orderby == 'total'}
                    table.order(3, '{$sort}');
                {elseif $orderby == 'status'}
                    table.order(4, '{$sort}');
                {/if}
                table.draw();
                jQuery('.table-container').removeClass('loading');
                jQuery('#tableLoading').addClass('hidden');
            });
        </script>
        <div class="table-container loading clearfix">
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
                            {foreach key=num item=status from=$RSInvoicesStatuses}
                                    <li><a href="#"><span data-value="{$status.statustext}">{$status.statustext}</span></a></li>
                            {/foreach}
                        </ul>
                    </div>
                </div>       
            </div>
            <table id="tableInvoicesList" class="table table-list">
                <thead>
                    <tr>
                        <th data-priority="1"><button type="button" class="btn-table-collapse"></button>{$LANG.invoicestitle}<span class="sorting-arrows"></span></th>
                        <th data-priority="3">{$LANG.invoicesdatecreated}<span class="sorting-arrows"></span></th>
                        <th data-priority="4">{$LANG.invoicesdatedue}<span class="sorting-arrows"></span></th>
                        <th data-priority="5">{$LANG.invoicestotal}<span class="sorting-arrows"></span></th>
                        <th data-priority="2">{$LANG.invoicesstatus}<span class="sorting-arrows"></span></th>               
                    </tr>
                </thead>
                <tbody>
                    {foreach key=num item=invoice from=$invoices}
                        <tr data-url="viewinvoice.php?id={$invoice.id}">
                            <td><button type="button" class="btn-table-collapse"></button>{$invoice.invoicenum}</td>
                            <td><span class="hidden">{$invoice.normalisedDateCreated}</span>{$invoice.datecreated}</td>
                            <td><span class="hidden">{$invoice.normalisedDateDue}</span>{$invoice.datedue}</td>
                            <td data-order="{$invoice.totalnum}">{$invoice.total}</td>
                            <td><span class="status status-{$invoice.statusClass}">{$invoice.status}</span></td>
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
                {include file="$template//assets/svg-icon/invoice.tpl"}        
            </div>
            <h6 class="message-text">{$LANG.invoicesnoinvoices}</h6>
        </div>
    {/if}
{/if}    