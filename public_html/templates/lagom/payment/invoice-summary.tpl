<div class="order-sidebar">                    
    <div id="sticky-sidebar">
        <div class="sticky-sidebar-inner">
            <div class="order-summary" id="orderSummary">
                <h2>{$LANG.invoicenumber}{$invoiceid}</h2>
                <div class="summary-container">
                    <div class="content">
                        <ul class="order-summary-list">
                            {foreach $invoiceitems as $item}
                                <li class="list-item">
                                    <span class="item-name">{$item.description}</span>
                                    <span class="item-value">{$item.amount}</span>
                                </li>
                            {/foreach}
                        </ul>
                        <ul class="order-summary-list faded">
                            <li class="list-item">
                                <span class="item-name">{$LANG.invoicessubtotal}</span>
                                <span class="item-value">{$invoice.subtotal}</span>
                            </li>
                            {if $invoice.taxrate}
                                <li class="list-item">
                                    <span class="item-name">{$invoice.taxrate}% {$invoice.taxname}</span>
                                    <span class="item-value">{$invoice.tax}</span>
                                </li>
                            {/if}
                            {if $invoice.taxrate2}
                                <li class="list-item">
                                    <span class="item-name">{$invoice.taxrate2}% {$invoice.taxname2}</span>
                                    <span class="item-value">{$invoice.tax2}</span>
                                </li>                                          
                            {/if}
                            <li class="list-item">
                                <span class="item-name">{$LANG.invoicescredit}</span>
                                <span class="item-value">{$invoice.credit}</span>
                            </li>
                            <li class="list-item">
                                <span class="item-name">{$LANG.paymentstodate}</span>
                                <span class="item-value">{$invoice.amountpaid}</span>
                            </li>
                            <li class="list-item">
                                <span class="item-name">{$LANG.balancedue}</span>
                                <span class="item-value">{$balance}</span>
                            </li>
                        </ul>
                    </div>
                    <div class="total-due-today">
                        <div class="content">
                            <span id="totalDueToday" class="amt">{$invoice.total}</span>
                            <span class="total-due-today-text">{$LANG.invoicestotaldue}</span>
                        </div>
                    </div>
                    <div class="order-summary-actions">                                    
                        <button type="submit" class="btn btn-info btn-checkout" id="btnSubmit" value="{$LANG.submitpayment}" data-btn-loader>                            
                            <span><i class="ls ls-share"></i>{$LANG.masspaymakepayment}</span>
                            <div class="loader loader-button hidden" >
                                {include file="$template/includes/loader.tpl" classes="spinner-sm"}  
                            </div>
                        </button>
                    </div>
                </div>    
            </div>
        </div>    
    </div>
</div>    

<div class="order-summary order-summary-mob" id="orderSummary">
    <h2>{$LANG.ordersummary}</h2>
    <div class="summary-container">
        <div class="content">
            <ul class="order-summary-list">
                {foreach $invoiceitems as $item}
                    <li class="list-item">
                        <span class="item-name">{$item.description}</span>
                        <span class="item-value">{$item.amount}</span>
                    </li>
                {/foreach}
            </ul>
            <ul class="order-summary-list faded">
                <li class="list-item">
                    <span class="item-name">{$LANG.invoicessubtotal}</span>
                    <span class="item-value">{$invoice.subtotal}</span>
                </li>
                {if $invoice.taxrate}
                    <li class="list-item">
                        <span class="item-name">{$invoice.taxrate}% {$invoice.taxname}</span>
                        <span class="item-value">{$invoice.tax}</span>
                    </li>
                {/if}
                {if $invoice.taxrate2}
                    <li class="list-item">
                        <span class="item-name">{$invoice.taxrate2}% {$invoice.taxname2}</span>
                        <span class="item-value">{$invoice.tax2}</span>
                    </li>                                          
                {/if}
                <li class="list-item">
                    <span class="item-name">{$LANG.invoicescredit}</span>
                    <span class="item-value">{$invoice.credit}</span>
                </li>
                <li class="list-item">
                    <span class="item-name">{$LANG.paymentstodate}</span>
                    <span class="item-value">{$invoice.amountpaid}</span>
                </li>
                <li class="list-item">
                    <span class="item-name">{$LANG.balancedue}</span>
                    <span class="item-value">{$balance}</span>
                </li>
            </ul>
            
        </div>
        <div class="total-due-today">
            <div class="content">
                <span id="totalDueToday" class="amt">{$invoice.total}</span>
                <span class="total-due-today-text">{$LANG.invoicestotaldue}</span>
            </div>
            <button type="button" class="btn btn-icon btn-primary btn-rounded btn-sm">
                <i class="fa fa-chevron-up"></i>
            </button>
        </div>
        <div class="order-summary-actions">
            <button type="submit" class="btn btn-info btn-checkout" id="btnSubmitMob" value="{$LANG.submitpayment}" data-btn-loader>
                <span><i class="ls ls-share"></i>{$LANG.masspaymakepayment}</span>
                <div class="loader loader-button hidden" >
                    {include file="$template/includes/loader.tpl" classes="spinner-sm"}  
                </div>
            </button>
        </div>
    </div>
</div>