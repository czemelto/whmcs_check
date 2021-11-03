{if file_exists("templates/$template/includes/overwrites/sidebar-custom.tpl")}
    {include file="{$template}/includes/overwrites/sidebar-custom.tpl"}  
{else}    
    {if $templatefile == "clientareaaddfunds" && !$addfundsdisabled}
        <div class="panel panel-sidebar panel panel-info panel-payment">  
            <div class="panel-body">
                <div class="total">
                    <span class="total-text">
                        {$LANG.invoiceaddcreditdesc1}
                    </span> 
                    <span class="total-price">
                        {$clientsstats.creditbalance}
                    </span>
                </div>
                <ul class="list-info list-info-sm list-info-50">
                    <li>
                        <span class="list-info-text">{$LANG.addfundsminimum}</span>
                        <span class="list-info-title">{$minimumamount}</span>
                    </li>
                    <li>
                        <span class="list-info-text">{$LANG.addfundsmaximum}</span>
                        <span class="list-info-title">{$maximumamount}</span>
                    </li>
                    <li>
                        <span class="list-info-text">{$LANG.addfundsmaximumbalance}</span>
                        <span class="list-info-title">{$maximumbalance}</span>
                    </li>
                </ul>
            </div>
        </div>
        <div class="alert alert-info alert-sm alert-panel">
            <div class="alert-icon ls ls-info-circle"></div>
            {$LANG.addfundsnonrefundable|replace:"*":""|replace:".":""}
        </div>
    {/if}

    {if $templatefile == "affiliates" && !$inactive}
        <div menuitemname="Client Details" class="panel panel-payment panel-sidebar panel panel-info panel-add-funds">
            <div class="panel-body">
                <div class="total">
                    <span class="total-text">{$LANG.affiliatescommissionsavailable}</span>
                    <span class="total-price">{$balance}<i class="ls ls-bank-note"></i></span>
                </div>
                <ul class="list-info list-info-sm m-b-24">
                    <li>
                        <span class="list-info-title">{$LANG.affiliatescommissionspending}</span>
                        <span class="list-info-text">{$pendingcommissions}</span>
                    </li>
                    <li>
                        <span class="list-info-title">{$LANG.affiliateswithdrawn}</span>
                        <span class="list-info-text">{$withdrawn}</span>
                    </li>
                </ul>
                {if !$withdrawlevel || $withdrawrequestsent}
                <button href="{$smarty.server.PHP_SELF}?action=withdrawrequest" class="btn btn-info btn-block"{if !$withdrawlevel || $withdrawrequestsent} disabled{/if}>
                    <i class="ls ls-bank-note"></i> {$LANG.affiliatesrequestwithdrawal}
                </button>
            
                {else}
                <a href="{$smarty.server.PHP_SELF}?action=withdrawrequest" class="btn btn-info btn-block"{if !$withdrawlevel || $withdrawrequestsent} disabled="true"{/if}>
                    <i class="ls ls-bank-note"></i> {$LANG.affiliatesrequestwithdrawal}
                </a>
                {/if}
            </div>
        </div>
        {if $withdrawrequestsent}
            <div class="alert alert-success alert-sm alert-panel">
                <i class="alert-icon ls ls-info-circle"></i>
                <p>{$LANG.affiliateswithdrawalrequestsuccessful}</p>
            </div>
        {else}
            {if !$withdrawlevel}
                <div class="alert alert-info alert-sm alert-panel"><i class="alert-icon ls ls-info-circle"></i>{lang key="affiliateWithdrawalSummary" amountForWithdrawal=$affiliatePayoutMinimum}</div>
            {/if}
        {/if}
    {/if}

    {if $templatefile == "clientareainvoices" && $clientsstats.numdueinvoices !=0}
        <div class="panel panel-sidebar panel-payment">
            <div class="panel-body">
                <div class="total">
                    <span class="total-text">{$LANG.invoicesduemsg|sprintf2:$clientsstats.numdueinvoices}</span>
                    <span class="total-price">{$clientsstats.dueinvoicesbalance}<i class="ls ls-exclamation-circle"></i></span>
                </div>
                {if $condlinks.masspay && $clientsstats.numdueinvoices !=0}
                    <a href="clientarea.php?action=masspay&all=true" class="btn btn-info btn-block" data-btn-loader>                        
                        <span><i class="ls ls-share"></i>{$LANG.invoicespaynow}</span>
                        <div class="loader loader-button hidden" >
                            {include file="$template/includes/loader.tpl" classes="spinner-sm"}  
                        </div>
                    </a>
                {/if}
            </div>
        </div>
    {/if}
  {if $templatefile == "serverstatus"}
        <div menuitemname="Network Status" class="panel panel-sidebar panel-default panel-actions view-filter-btns">
            <div class="list-group">
                <a menuitemname="View RSS Feed" href="{$WEB_ROOT}/networkissuesrss.php" class="list-group-item" id="Primary_Sidebar-Network_Status-View_RSS_Feed">
                    <i class="ls ls-rss"></i>&nbsp; {$LANG.announcementsrss} 
                </a>
            </div>
        </div>
    {/if}
{/if}    