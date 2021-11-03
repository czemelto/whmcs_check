{if isset($RSThemes.pages.upgradesummary)}
    {include file=$RSThemes['pages']['upgradesummary']['fullPath']}
{else} 	
    <div class="order-content">
        {if $promoerror}
            {include file="$template/includes/alert.tpl" type="error" msg=$promoerror textcenter=true}
        {/if}
        {if $promorecurring}
            {include file="$template/includes/alert.tpl" type="info"
            msg=$LANG.recurringpromodesc|sprintf2:$promorecurring textcenter=true}
        {/if}
        <div class="upgrade-summary">
            <div class="section">
                <div class="section-body">
                    <div class="panel panel-default">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th width="60%">{$LANG.orderdesc}</th>
                                    <th width="40%" class="text-center">{$LANG.orderprice}</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach key=num item=upgrade from=$upgrades}
                                    {if $type eq "package"}
                                        <tr>
                                            <td><input type="hidden" name="pid" value="{$upgrade.newproductid}" /><input type="hidden" name="billingcycle" value="{$upgrade.newproductbillingcycle}" />{$upgrade.oldproductname} => {$upgrade.newproductname}</td>
                                            <td class="text-center">{$upgrade.price}</td>
                                        </tr>
                                    {elseif $type eq "configoptions"}
                                        <tr>
                                            <td>{$upgrade.configname}: {$upgrade.originalvalue} => {$upgrade.newvalue}</td>
                                            <td class="text-center">{$upgrade.price}</td>
                                        </tr>
                                    {/if}
                                {/foreach}
                            </tbody>
                        </table>
                    </div>
                    {if $type eq "package"}
                        <div class="alert alert-sm alert-panel alert-warning">
                            <div class="alert-icon ls ls-info-circle"></div>
                            <div class="alert-body">{$LANG.upgradeproductlogic|cat:' ('|cat:$upgrade.daysuntilrenewal|cat:' '|cat:$LANG.days|cat:')'}</div>
                        </div>
                    {/if} 
                </div>
            </div>
            <div class="section">
                <div class="section-header">
                    <h3>{$LANG.orderpromotioncode}</h3>
                </div>
                <div class="section-body">
                    <div class="panel panel-form">
                        <div class="panel-body">
                            <form method="post" action="{$smarty.server.PHP_SELF}" role="form">
                                <input type="hidden" name="step" value="2" />
                                <input type="hidden" name="type" value="{$type}" />
                                <input type="hidden" name="id" value="{$id}" />
                                {if $type eq "package"}
                                    <input type="hidden" name="pid" value="{$upgrades.0.newproductid}" />
                                    <input type="hidden" name="billingcycle" value="{$upgrades.0.newproductbillingcycle}" />
                                {/if}
                                {foreach from=$configoptions key=cid item=value}
                                    <input type="hidden" name="configoption[{$cid}]" value="{$value}" />
                                {/foreach}
                                <div class="form-group promo-code">
                                    <input class="form-control" type="text" name="promocode" placeholder="{$LANG.orderpromotioncode}" {if $promocode}value="{$promocode} - {$promodesc}" disabled="disabled"{/if}>
                                    {if $promocode}
                                        <input type="submit" name="removepromo" value="{$LANG.orderdontusepromo}" class="btn btn-danger" />
                                    {else}
                                        <input type="submit" value="{$LANG.orderpromovalidatebutton}" class="btn btn-primary" />
                                    {/if}
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>   
            <div class="section">
                <div class="section-header">
                    <h3>{$LANG.orderpaymentmethod}</h3>
                </div>
                <div class="section-body">
                    <div class="panel panel-form">
                        <div class="panel-body">                                      
                            <form method="post" action="{$smarty.server.PHP_SELF}">
                                <input type="submit" value="{$LANG.ordercontinuebutton}" class="hidden" id="submit-upgrade" />
                                <input type="hidden" name="step" value="3" />
                                <input type="hidden" name="type" value="{$type}" />
                                <input type="hidden" name="id" value="{$id}" />
                                {if $type eq "package"}
                                    <input type="hidden" name="pid" value="{$upgrades.0.newproductid}" />
                                    <input type="hidden" name="billingcycle" value="{$upgrades.0.newproductbillingcycle}" />
                                {/if}
                                {foreach from=$configoptions key=cid item=value}
                                    <input type="hidden" name="configoption[{$cid}]" value="{$value}" />
                                {/foreach}
                                {if $promocode}<input type="hidden" name="promocode" value="{$promocode}">{/if}
                                <select name="paymentmethod" id="inputPaymentMethod" class="form-control">
                                    {if $allowgatewayselection}
                                        <option value="none">{$LANG.paymentmethoddefault}</option>
                                    {/if}
                                    {foreach key=num item=gateway from=$gateways}
                                        <option value="{$gateway.sysname}"{if $gateway.sysname eq $selectedgateway} selected="selected"{/if}>{$gateway.name}</option>
                                    {/foreach}
                                </select>
                            </form>
                        </div>
                    </div>
                </div>
            </div>         
        </div>
    </div>
    <div class="order-sidebar" id="scrollingPanelContainer">		
        <div id="sticky-sidebar">
            <div class="sticky-sidebar-inner">
                <div class="order-summary" id="orderSummary">
                    <div class="loader" id="orderSummaryLoader" style="display: none;">
                        {include file="$template/includes/loader.tpl" classes="spinner-sm spinner-light"}  
                    </div>                    
                    <h2>{$LANG.ordersummary}</h2>
                    <div class="summary-container">
                        <div class="content">
                            <ul class="order-summary-list">
                                <li class="list-item">
                                    <span class="item-name">{$LANG.ordersubtotal}</span>
                                    <span class="item-value">{$subtotal}</span>
                                </li>
                            </ul>
                            {if $promocode || $taxrate || $taxrate2}
                                <ul class="order-summary-list faded">
                                    {if $taxrate}
                                        <li class="list-item">
                                            <span class="item-name">{$taxname} @ {$taxrate}%</span>
                                            <span class="item-value" id="taxTotal1">{$taxtotal}</span>
                                        </li>
                                    {/if}
                                    {if $taxrate2}
                                        <li class="list-item">
                                            <span class="item-name">{$taxname2} @ {$taxrate2}%</span>
                                            <span class="item-value" id="taxTotal2">{$taxtotal2}</span>
                                        </li>
                                    {/if}
                                    {if $promocode}
                                        <li class="list-item light">
                                            <span class="item-name">{$promodesc}</span>
                                            <span class="item-value">{$discount}</span>
                                        </li>
                                    {/if}
                                </ul>
                            {/if}
                        </div>
                        <div class="total-due-today">
                            <div class="content">
                                <span id="totalDueToday" class="amt">{$total}</span>
                                <span class="total-due-today-text">{$LANG.ordertotalduetoday}</span>
                            </div>
                        </div>
                        <div class="order-summary-actions">
                            <button type="button" class="btn btn btn-info btn-checkout" data-trigger-click data-target="#submit-upgrade">
                                <i class="ls ls-share"></i>{$LANG.orderForm.checkout}
                            </button>
                        </div>
                    </div>
                </div>
            </div>    
        </div>
    </div>
                                 
    <div class="order-summary order-summary-mob" id="orderSummaryMob">
        <div class="loader" id="orderSummaryLoaderMob" style="display: none;">
            {include file="$template/includes/loader.tpl" classes="spinner-sm spinner-light"}  
        </div>
        <h2>{$LANG.ordersummary}</h2>
        <div class="summary-container">
            <div class="summary-container" id="producttotalmob">
                <div class="content">
                    <ul class="order-summary-list">
                        <li class="list-item">
                            <span class="item-name">{$LANG.ordersubtotal}</span>
                            <span class="item-value">{$subtotal}</span>
                        </li>
                    </ul>
                    {if $promocode || $taxrate || $taxrate2}
                        <ul class="order-summary-list faded">
                            {if $taxrate}
                                <li class="list-item">
                                    <span class="item-name">{$taxname} @ {$taxrate}%</span>
                                    <span class="item-value" id="taxTotal1">{$taxtotal}</span>
                                </li>
                            {/if}
                            {if $taxrate2}
                                <li class="list-item">
                                    <span class="item-name">{$taxname2} @ {$taxrate2}%</span>
                                    <span class="item-value" id="taxTotal2">{$taxtotal2}</span>
                                </li>
                            {/if}
                            {if $promocode}
                                <li class="list-item light">
                                    <span class="item-name">{$promodesc}</span>
                                    <span class="item-value">{$discount}</span>
                                </li>
                            {/if}
                        </ul>
                    {/if}
                </div>
                 <div class="total-due-today">
                    <div class="content">
                         <span class="amt">{$total}</span>
                        <span class="total-due-today-text">{$LANG.ordertotalduetoday}</span>
                    </div>
                    <button type="button" class="btn btn-icon btn-primary btn-rounded btn-sm hidden-md hidden-lg">
                        <i class="fa fa-chevron-up"></i>
                    </button>
                    <div class="basket-icon hidden-sm hidden-xs">
                        <i class="ls ls-basket"></i>
                    </div>
                </div>
            </div>
            <div class="order-summary-actions">
                <button type="button" data-trigger-click data-target="#submit-upgrade" class="btn btn-info btn-checkout" id="checkout"><i class="ls ls-share"></i>{$LANG.continue}</button>
            </div>
        </div>
    </div>
{/if}	
