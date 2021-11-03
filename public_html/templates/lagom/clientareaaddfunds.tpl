{if isset($RSThemes.pages.clientareaaddfunds)}
    {include file=$RSThemes['pages']['clientareaaddfunds']['fullPath']}
{else} 
    {if !$addfundsdisabled}    
        <p class="text-light">{$LANG.addfundsdescription}</p>
    {/if}

    {if $addfundsdisabled}
        {include file="$template/includes/message.tpl" type="danger" customClass="message-no-data" msg=$LANG.clientareaaddfundsdisabled}
    {elseif $notallowed}
        {include file="$template/includes/message.tpl" type="danger" customClass="message-no-data" msg=$LANG.clientareaaddfundsnotallowed}
    {elseif $errormessage}
        {include file="$template/includes/alert.tpl" type="danger" msg=$errormessage}
    {/if}

    {if !$addfundsdisabled && !$notallowed}    
        <div class="panel panel-default pnale-form well-lg m-b-6">
            <div class="panel-body">
            <form method="post" action="{$smarty.server.PHP_SELF}?action=addfunds" class="m-w-416 m-a m-t-neg-6">
                <div class="form-group">
                    <label for="paymentmethod" class="control-label">{$LANG.orderpaymentmethod}:</label>
                    <select name="paymentmethod" id="paymentmethod" class="form-control">
                        {foreach from=$gateways item=gateway}
                            <option value="{$gateway.sysname}">{$gateway.name}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="form-group m-b-0">
                    <label for="amount" class="control-label">{$LANG.addfundsamount}:</label>
                    <div class="buttons-group buttons-5" id="add-credits-buttons">
                        <button class="btn btn-outline text-primary {if $amount == 10.00}active{/if}" type="button" data-price="10.00">{$WHMCSCurrency.prefix}10</button>
                        <button class="btn btn-outline text-primary {if $amount == 25.00}active{/if}" type="button" data-price="25.00">{$WHMCSCurrency.prefix}25</button>
                        <button class="btn btn-outline text-primary {if $amount == 50.00}active{/if}" type="button" data-price="50.00">{$WHMCSCurrency.prefix}50</button>
                        <button class="btn btn-outline text-primary {if $amount == 75.00}active{/if}" type="button" data-price="75.00">{$WHMCSCurrency.prefix}75</button>
                        <button class="btn btn-outline text-primary {if $amount == 100.00}active{/if}" type="button" data-price="100.00">{$WHMCSCurrency.prefix}100</button>
                    </div>
                    <div class="input-group">
                        <input type="text" name="amount" id="amount" value="{$amount}" class="form-control" required />
                        <span class="input-group-btn">
                            <button type="submit" value="{$LANG.addfunds}" class="btn btn-primary" data-btn-loader>
                                <span>{$LANG.addfunds}</span>
                                <div class="loader loader-button hidden" >
                                    {include file="$template/includes/loader.tpl" classes="spinner-sm spinner-light"}  
                                </div>
                            </button>
                        </span>
                    </div>
                </div>    
            </form>
            </div>
        </div>
    {/if}
{/if}