{include file="{$template}/header.tpl"}

{if isset($RSThemes.pages.viewinvoice)}
    {include file=$RSThemes['pages']['viewinvoice']['fullPath']}
{else}
    {if $invalidInvoiceIdRequested}
        {include file="$template/includes/alert.tpl" type="danger" msg=$LANG.invoiceserror}
    {else}
        <div class="row row-eq-height row-eq-height-md ">
            <div class="col-md-9 tab-m-b-48">
                <div class="invoice">
                    {if $paymentSuccessAwaitingNotification}
                        {include file="$template/includes/alert.tpl" type="success" msg=$LANG.invoicePaymentSuccessAwaitingNotify}
                    {elseif $paymentSuccess}
                        {include file="$template/includes/alert.tpl" type="success" msg=$LANG.invoicepaymentsuccessconfirmation}
                    {elseif $paymentInititated}
                        {include file="$template/includes/alert.tpl" type="info" msg=$LANG.invoicePaymentInitiated}
                    {elseif $pendingReview}
                        {include file="$template/includes/alert.tpl" type="info" msg=$LANG.invoicepaymentpendingreview}
                    {elseif $paymentFailed}
                        {include file="$template/includes/alert.tpl" type="danger" msg=$LANG.invoicepaymentfailedconfirmation}
                    {elseif $offlineReview}
                        {include file="$template/includes/alert.tpl" type="info" msg=$LANG.invoiceofflinepaid}
                    {/if}
                    <div class="section">
                        <div class="row">
                            <div class="col-sm-7">
                                <span class="invoice-title"> {$pagetitle}
                                    {if $status eq "Draft"}
                                        <span class="invoice-status label label-lg label-info">{$LANG.invoicesdraft}</span>                                    
                                    {elseif $status eq "Unpaid"}
                                        <span class="invoice-status label label-lg label-danger">{$LANG.invoicesunpaid}</span>
                                    {elseif $status eq "Paid"}
                                        <span class="invoice-status label label-lg label-success">{$LANG.invoicespaid}</span>                                   
                                    {elseif $status eq "Refunded"}
                                        <span class="invoice-status label label-lg label-info">{$LANG.invoicesrefunded}</span>                                          
                                    {elseif $status eq "Cancelled"}
                                        <span class="invoice-status label label-lg label-info">{$LANG.invoicescancelled}</span>         
                                    {elseif $status eq "Collections"}
                                        <span class="invoice-status label label-lg label-info">{$LANG.invoicescollections}</span>         
                                    {elseif $status eq "Payment Pending"}
                                        <span class="invoice-status label label-lg label-warning">{$LANG.invoicesPaymentPending}</span>          
                                    {/if}
                                </span>
                            </div>
                            <div class="col-sm-5">
                                <ul class="list-info list-info-50">
                                    <li>
                                        <span class="list-info-text">{$LANG.invoicesdatecreated}</span>
                                        <span class="list-info-title">{$date}</span>
                                    </li>
                                    {if $status eq "Unpaid" || $status eq "Draft"}
                                        <li>
                                            <span class="list-info-text">{$LANG.invoicesdatedue}</span>
                                            <span class="list-info-title">{$datedue}</span>
                                        </li>
                                    {/if}
                                    {if $status neq "Unpaid"}
                                        <li>
                                            <span class="list-info-text">{$LANG.orderpaymentmethod}</span>
                                            <span class="list-info-title">{$paymentmethod}{if $paymethoddisplayname} ({$paymethoddisplayname}){/if}</span>
                                        </li>
                                    {/if}
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="section">
                        <div class="row">
                            <div class="col-sm-7">
                                <h3>{$LANG.invoicespayto}:</h3>
                                <address>
                                    {$payto}
                                    {if $taxCode}<br />{$taxIdLabel}: {$taxCode}{/if}
                                </address>
                            </div>
                            <div class="col-sm-5">
                                <h3>{$LANG.invoicesinvoicedto}:</h3>
                                <address> {if $clientsdetails.companyname}{$clientsdetails.companyname}<br />{/if}
                                        {$clientsdetails.firstname} {$clientsdetails.lastname}<br />
                                        {$clientsdetails.address1}, {$clientsdetails.address2}<br />
                                        {$clientsdetails.city}, {$clientsdetails.state}, {$clientsdetails.postcode}<br />
                                        {$clientsdetails.country}
                                        {if $clientsdetails.tax_id}<br />{$taxIdLabel}: {$clientsdetails.tax_id}{/if}
                                        {if $customfields}
                                        <br /><br />
                                        {foreach from=$customfields item=customfield}
                                        {$customfield.fieldname}: {$customfield.value}<br />
                                        {/foreach}
                                        {/if}
                                </address>
                            </div>
                        </div>
                    </div>
                    <div class="section">
                        <h3>{$LANG.invoicelineitems}</h3>
                        <div class="table-responsive">
                            <table class="table table-condensed">
                                <thead>
                                    <tr>
                                        <th width="61%">{$LANG.invoicesdescription}</th>
                                        <th width="20%"></th>
                                        <th width="19%" class="text-center">{$LANG.invoicesamount}</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {foreach from=$invoiceitems item=item}
                                        <tr>
                                            <td colspan="2">{$item.description}{if $item.taxed eq "true"} *{/if}</td>
                                            <td class="text-center">{$item.amount}</td>
                                        </tr>
                                    {/foreach}
                                    <tr class="sub-total-row first">
                                        <td></td>
                                        <td>{$LANG.invoicessubtotal}</td>
                                        <td>{$subtotal}</td>
                                    </tr>
                                    {if $taxname}
                                        <tr class="sub-total-row">
                                            <td></td>
                                            <td>{$taxrate}% {$taxname}</td>
                                            <td>{$tax}</td>
                                        </tr>
                                    {/if}
                                    {if $taxname2}
                                        <tr class="sub-total-row">
                                            <td></td>
                                            <td>{$taxrate2}% {$taxname2}</td>
                                            <td>{$tax2}</td>
                                        </tr>
                                    {/if}
                                    <tr class="sub-total-row last">
                                        <td></td>
                                        <td>{$LANG.invoicescredit}</td>
                                        <td>{$credit}</td>
                                    </tr>
                                    <tr class="total-row">
                                        <td></td>
                                        <td class="h3">{$LANG.invoicestotal}</td>
                                        <td class="h3">{$total}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        {if $taxrate}
                            <p>* {$LANG.invoicestaxindicator}</p>
                        {/if}
                    </div>

                    <div class="section">
                        <h3>{$LANG.invoicestransactions}</h3>
                        <div class="table-responsive">    
                            <table class="table table-condensed m-b-0">
                                <thead>
                                    <tr>
                                        <th width="41%" class="text-center"><strong>{$LANG.invoicestransdate}</strong></th>
                                        <th width="20%" class="text-center"><strong>{$LANG.invoicestransgateway}</strong></th>
                                        <th width="20%" class="text-center"><strong>{$LANG.invoicestransid}</strong></th>
                                        <th width="19%" class="text-center"><strong>{$LANG.invoicestransamount}</strong></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {foreach from=$transactions item=transaction}
                                        <tr>
                                            <td class="text-center">{$transaction.date}</td>
                                            <td class="text-center">{$transaction.gateway}</td>
                                            <td class="text-center">{$transaction.transid}</td>
                                            <td class="text-center">{$transaction.amount}</td>
                                        </tr>
                                    {foreachelse}
                                        <tr>
                                            <td class="text-center" colspan="4">{$LANG.invoicestransnonefound}</td>
                                        </tr>
                                    {/foreach}
                                    <tr class="total-row">
                                        <td></td>
                                        <td></td>
                                        <td>{$LANG.invoicesbalance}</td>
                                        <td>{$balance}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div> 
                                    
                    {if $notes}
                    <div class="notes">
                            <div class="notes-heading">
                                <h3 class="notes-title"><strong>{$LANG.invoicesnotes}</strong></h3>
                            </div>
                        <div class="well notes-body">
                            {$notes}
                        </div>
                    </div>      
                    {/if}
                </div>    
            </div>
                                                                                            
            <div class="col-md-3 sidebar hidden-print">
                <div class="sticky-sidebar">
                    <div class="sticky-sidebar-inner">
                        {if $status == "Unpaid"}
                            <div menuitemname="Client Details" class="panel panel-sidebar panel-payment">
                                <div class="panel-body" data-role="paymethod-info">
                                    <div class="total">
                                        <span class="total-text">{$LANG.invoicestotaldue}</span> 
                                        <span class="total-price">{$balance}<i class="ls ls-exclamation-circle"></i></span>
                                    </div>
                                    {if $status eq "Unpaid" && $allowchangegateway}
                                        <label>{$LANG.orderpaymentmethod}:</label>
                                        <form method="post" action="{$smarty.server.PHP_SELF}?id={$invoiceid}">
                                            <div class="form-group">
                                                {$gatewaydropdown}
                                            </div>
                                        </form>
                                    {else}
                                        {$paymentmethod}{if $paymethoddisplayname} ({$paymethoddisplayname}){/if}
                                    {/if}
                                    {if $status eq "Unpaid" || $status eq "Draft"}
                                        <span class="small-text"></span>
                                        <div class="payment-form payment-btn-container" data-btntext="{$LANG.makepayment}" data-btnsubscribetext="{$rslang->trans('billing.subscribe')}">
                                            {$paymentbutton}
                                        </div>
                                    {/if}
                                </div>
                            </div>

                            {if $manualapplycredit}
                                <div menuitemname="Add Funds" class="panel panel-sidebar panel panel-info panel-add-funds">
                                    <div class="panel-heading">
                                        <h3 class="panel-title">{$LANG.invoiceaddcreditapply}</h3>
                                    </div>
                                    <div class="panel-body">
                                    <form method="post" action="{$smarty.server.PHP_SELF}?id={$invoiceid}">
                                            <input type="hidden" name="applycredit" value="true">                              
                                            <div class="text-small text-light m-b-6">{$LANG.invoiceaddcreditdesc1}</div>
                                            <div class="alert alert-info">{$totalcredit}</div>
                                            <div class="form-group m-b-0">
                                                <label class="control-label">{$LANG.invoiceaddcreditamount}</label>
                                                <div class="input-group">
                                                    <input type="text" name="creditamount" value="{$creditamount}" class="form-control" />
                                                    <span class="input-group-btn">
                                                        <input type="submit" value="{$LANG.invoiceaddcreditapply}" class="btn btn-success" id="btnInvoiceAddCreditApply"/>
                                                    </span>
                                                </div>
                                            </div>
                                        </form>    
                                    </div>
                                </div>
                            {/if}
                        {/if}    
                        <div menuitemname="Client Shortcuts" class="panel panel-sidebar panel-sidebar">
                            <div class="panel-heading">
                                <h3 class="panel-title">
                                    <i class="fa fa-bookmark"></i>&nbsp; {$LANG.actions}
                                    <i class="fa fa-chevron-up panel-minimise pull-right"></i>
                                </h3>
                            </div>
                            <div class="list-group">
                                {* <a href="javascript:window.print()" class="list-group-item">
                                    <i class="ls ls-printer"></i>{$LANG.print}
                                </a> *}
                                <a href="dl.php?type=i&amp;id={$invoiceid}" class="list-group-item">
                                    <i class="ls ls-download"></i>{$LANG.invoicesdownload}
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    {/if}
{/if}

{include file="{$template}/footer.tpl"}

