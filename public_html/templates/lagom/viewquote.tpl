{include file="{$template}/header.tpl"}

{if isset($RSThemes.pages.viewquote)}
    {include file=$RSThemes['pages']['viewquote']['fullPath']}
{else} 
    {if $invalidQuoteIdRequested}
        {include file="$template/includes/alert.tpl" type="danger" msg=$LANG.invoiceserror}
    {else}
        <div class="row row-eq-height row-eq-height-sm">
            <div class="col-md-9 main-content">
                <div class="invoice">
                    {if $agreetosrequired}
                        {include file="$template/includes/alert.tpl" type="danger"  msg=$LANG.ordererroraccepttos}
                    {/if}
                    <div class="section">
                        <div class="row">
                            <div class="col-sm-7">
                                <span class="invoice-title"> {$LANG.quotenumber}{$id}
                                    {if $stage eq "Delivered"}
                                        <span class="invoice-status label label-lg label-success">{$LANG.quotestagedelivered}</span>
                                    {elseif $stage eq "Accepted"}
                                        <span class="invoice-status label label-lg label-success">{$LANG.quotestageaccepted}</span>
                                    {elseif $stage eq "On Hold"}
                                        <span class="invoice-status label label-lg label-warning">{$LANG.quotestageonhold}</span>                           
                                    {elseif $stage eq "Lost"}
                                        <span class="invoice-status label label-lg label-danger">{$LANG.quotestagelost}</span>
                                    {elseif $stage eq "Dead"}
                                        <span class="invoice-status label label-lg label-danger">{$LANG.quotestagedead}</span>
                                    {/if}
                                </span>
                            </div>
                            <div class="col-sm-5">
                                <ul class="list-info list-info-50">
                                    <li>
                                        <span class="list-info-text">{$LANG.quotedatecreated}</span>
                                        <span class="list-info-title">{$datecreated}</span>
                                    </li>
                                    <li>
                                        <span class="list-info-text">{$LANG.quotevaliduntil}</span>
                                        <span class="list-info-title">{$validuntil}</span>
                                    </li>
                                </ul>
                            </div>
                        </div>    
                    </div>
                    <div class="section">
                        <div class="row">
                            <div class="col-sm-7">
                                <h3>{$LANG.quoterecipient}</h3>
                                <address>
                                    {if $clientsdetails.companyname}{$clientsdetails.companyname}<br />{/if}
                                    {$clientsdetails.firstname} {$clientsdetails.lastname}<br />
                                    {$clientsdetails.address1}, {$clientsdetails.address2}<br />
                                    {$clientsdetails.city}, {$clientsdetails.state}, {$clientsdetails.postcode}<br />
                                    {$clientsdetails.country}
                                    {if $customfields}
                                    <br /><br />
                                    {foreach from=$customfields item=customfield}
                                    {$customfield.fieldname}: {$customfield.value}<br />
                                    {/foreach}
                                    {/if}
                                </address>
                            </div>
                            <div class="col-sm-5">
                                <h3>{$LANG.invoicespayto}</h3>
                                <address> 
                                    {$payto}
                                </address>
                            </div>
                        </div>
                    </div>
                    {if $proposal}
                        <div class="section">
                            <h3>{$LANG.quoteproposal}</h3>
                            <div class="well">
                                {$proposal}
                            </div>
                        </div> 
                    {/if}
                    <div class="section">
                        <h3>{$LANG.quotelineitems}</h3>   
                        <div class="table-responsive">
                            <table class="table table-condensed">
                                <thead>
                                    <tr>
                                        <td>{$LANG.invoicesdescription}</td>
                                        <td class="text-center">{$LANG.quotediscountheading}</td>
                                        <td width="20%" class="text-center">{$LANG.invoicesamount}</td>
                                    </tr>
                                </thead>
                                <tbody>
                                    {foreach from=$quoteitems item=item}
                                        <tr>
                                            <td>{$item.description}{if $item.taxed} *{/if}</td>
                                            <td class="text-center">{if $item.discountpc > 0}{$item.discount} ({$item.discountpc}%){else} - {/if}</td>
                                            <td class="text-center">{$item.amount}</td>
                                        </tr>
                                    {/foreach}
                                    <tr class="sub-total-row first">
                                        <td></td>
                                        <td>{$LANG.invoicessubtotal}</td>
                                        <td>{$subtotal}</td>
                                    </tr>
                                    {if $taxrate}
                                        <tr class="sub-total-row">
                                            <td></td>
                                            <td>{$taxrate}% {$taxname}</td>
                                            <td>{$tax}</td>
                                        </tr>
                                    {/if}
                                    {if $taxrate2}
                                        <tr class="sub-total-row">
                                            <td></td>
                                            <td>{$taxrate2}% {$taxname2}</td>
                                            <td>{$tax2}</td>
                                        </tr>
                                    {/if}
                                    <tr class="sub-total-row">
                                        <td></td>
                                        <td>{$LANG.quotelinetotal}</td>
                                        <td>{$total}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        {if $taxrate}
                            <p>* {$LANG.invoicestaxindicator}</p>
                        {/if}   
                    </div>
                    {if $notes}
                        <div class="section">
                            <h3>{$LANG.invoicesnotes}</h3>
                            <div class="well">
                                {$notes}
                            </div>
                        </div>
                    {/if}     
                </div>
            </div>
            <div class="col-md-3 sidebar hidden-print">
                <div id="sticky-sidebar">
                    <div class="sticky-sidebar-inner">
                        <div menuitemname="Client Details" class="panel panel-sidebar panel-payment">
                            <div class="panel-body">
                                <div class="total {if $stage neq "Delivered" && $stage neq "On Hold"}m-b-0{/if}">
                                    <span class="total-text">{$LANG.invoicestotaldue}</span> 
                                    <span class="total-price">{$total}<i class="ls ls-text-cloud"></i></span>
                                </div>          
                            {if $stage eq "Delivered" || $stage eq "On Hold"}   
                                    <button type="button" class="btn btn-info btn-block" data-toggle="modal" data-target="#acceptQuoteModal">
                                        <i class="ls ls-share"></i> 
                                        {$LANG.quoteacceptbtn}
                                    </button>
                                {/if} 
                            </div>
                        </div>
                        <div menuitemname="Client Shortcuts" class="panel panel-sidebar panel-sidebar">
                            <div class="panel-heading">
                                <h3 class="panel-title">
                                    <i class="fa fa-bookmark"></i> {$LANG.actions}
                                    <i class="fa fa-chevron-up panel-minimise pull-right"></i>
                                </h3>
                            </div>
                            <div class="list-group">
                                {* <a href="javascript:window.print()" class="list-group-item">
                                    <i class="ls ls-printer"></i>{$LANG.print}
                                </a> *}
                                <a href="dl.php?type=q&amp;id={$quoteid}" class="list-group-item">
                                    <i class="ls ls-download"></i>{$LANG.invoicesdownload}
                                </a>
                            </div>
                        </div>
                    </div>    
                </div>
            </div>    
        </div>    
    {/if}

    <form method="post" action="viewquote.php?id={$quoteid}&amp;action=accept">
        <div class="modal fade" id="acceptQuoteModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><i class="lm lm-close"></i></button>
                        <h3 class="modal-title">{$LANG.quoteacceptbtn}</h3>
                    </div>
                    <div class="modal-body">
                        <p>{$LANG.quoteacceptagreetos}</p>
                        
                        <label class="checkbox" id="quoteAcceptAgreeTos">
                            <input class="icheck-control" type="checkbox" name="agreetos" />
                            <span>{$LANG.ordertosagreement} <a href="{$tosurl}" target="_blank">{$LANG.ordertos}</a></span>
                        </label>
                        
                        <small>{$LANG.quoteacceptcontractwarning}</small>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">{$LANG.quoteacceptbtn}</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">{$LANG.cancel}</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
{/if}

{include file="{$template}/footer.tpl"}