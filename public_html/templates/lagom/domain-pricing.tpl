{if isset($RSThemes['pages']['domain-pricing'])}
    {include file=$RSThemes['pages']['domain-pricing']['fullPath']}
{else}
    <div class="domain-pricing">

        {if $featuredTlds}
            <div class="featured-tlds-container">
                <div class="row">
                    {foreach $featuredTlds as $num => $tldinfo}
                        <div class="col-md-3 col-sm-4 col-xs-6">
                            <div class="featured-tld">
                                <div class="img-container">
                                    <img src="{$BASE_PATH_IMG}/tld_logos/{$tldinfo.tldNoDots}.png">
                                </div>
                                <div class="price {$tldinfo.tldNoDots}">
                                    {if is_object($tldinfo.register)}
                                        {$tldinfo.register}{if $tldinfo.period > 1}{lang key="orderForm.shortPerYears" years={$tldinfo.period}}{else}{lang key="orderForm.shortPerYear" years=''}{/if}
                                    {else}
                                        {lang key="domainregnotavailable"}
                                    {/if}
                                </div>
                            </div>
                        </div>
                    {/foreach}
                </div>
            </div>
        {/if}

        <div class="tld-filters m-t-16">
            <div class="value"></div>
            <div class="d-flex space-between">
                <select multiple class="form-control custom-multiselect m-t-16" id="domain-filter">
                    <option value="" disabled selected>{lang key='pricing.browseExtByCategory'}</option>
                    {foreach $tldCategories as $category => $count}
                        <option value="{$category}">{lang key="domainTldCategory.$category" defaultValue=$category} ({$count})</option>
                    {/foreach}
                </select>
                <div class="d-flex m-t-16">
                    <div class="search-group">
                        <input type="text" id="table-search" class="form-control" placeholder="Enter search term...">
                    </div>
                    {if !$loggedin && $currencies}
                        <form method="post" action="" class="m-l-8">
                            <select name="currency" class="form-control currency-selector" onchange="submit()">
                                <option>
                                    {lang key="changeCurrency"} ({$activeCurrency.prefix} {$activeCurrency.code})
                                </option>
                                {foreach $currencies as $currency}
                                    <option value="{$currency['id']}">
                                        {$currency['prefix']} {$currency['code']}
                                    </option>
                                {/foreach}
                            </select>
                        </form>
                    {/if}
                </div>    
            </div>
        </div>

        {include file="$template/includes/tablelist.tpl" tableName="DomainPricing" noOrdering=true}
        <script type="text/javascript">
            jQuery(document).ready(function(){
                var table = jQuery('#tableDomainPricing').removeClass('hidden').DataTable();
                {if $orderby == 'date'}
                table.order(0, '{$sort}');
                {elseif $orderby == 'subject'}
                table.order(1, '{$sort}');
                {/if}
                table.draw();
                jQuery('#tableLoading').addClass('hidden');
                $('#domain-filter').on('change',function(){
                    var val = $(this).val()
                    if (val == undefined){
                       val = "";
                    }
                    else{
                        val = val.toString()
                    }                   
                    var newVal = val.replace(',','|');
                    table.column(1).search(newVal, true, false).draw();
                })
                var alreadyReady = false;
                var rememberedFilterTerm = table.state().columns[1].search.search;
                
                if (rememberedFilterTerm && !alreadyReady) {
                    var values = rememberedFilterTerm.split("|");
                    $.each(values, function(i,e){
                        $("#domain-filter option[value='" + e + "']").prop("selected", true);
                    });
                    //console.log(rememberedFilterTerm);   
                }
            });
        </script>

        <div class="table-container clearfix">
            <table class="table table-list hidden" id="tableDomainPricing">
                <thead>
                <tr>
                    <th>{lang key='domaintld'}</th>
                    <th>{lang key='category'}</th>
                    <th>{lang key='pricing.register'}</th>
                    <th>{lang key='pricing.transfer'}</th>
                    <th>{lang key='pricing.renewal'}</th>
                    <th>{lang key='gracePeriod'}</th>
                    <th>{lang key='redemptionPeriod'}</th>
                </tr>
                </thead>
                <tbody>
                {foreach $pricing as $extension => $data}
                    <tr>
                        <td>
                            {$extension}
                            {if $data.group}
                                <span class="tld-sale-group tld-sale-group-{$data.group}">
                                    {$data.group}!
                                </span>
                            {/if}
                        </td>
                        <td>
                            {$data.categories[0]}
                            <span class="hidden">
                                {foreach $data.categories as $category}
                                    {$category}
                                {/foreach}
                            </span>
                        </td>
                        {foreach $data.register as $years => $price}
                            <td>
                                {if $price >= 0}
                                    {$price}<br>
                                    <small>{$years} {if $years > 1}{lang key="orderForm.years"}{else}{lang key="orderForm.year"}{/if}</small>
                                {else}
                                    <small>{lang key="domainregnotavailable"}</small>
                                {/if}
                            </td>
                            {break}
                            {foreachelse}
                            <td>-</td>
                        {/foreach}
                        {foreach $data.transfer as $years => $price}
                            <td>
                                {if $price >= 0}
                                    {$price}<br>
                                    <small>{$years} {if $years > 1}{lang key="orderForm.years"}{else}{lang key="orderForm.year"}{/if}</small>
                                {else}
                                    <small>{lang key="domainregnotavailable"}</small>
                                {/if}
                            </td>
                            {break}
                            {foreachelse}
                            <td>-</td>
                        {/foreach}
                        {foreach $data.renew as $years => $price}
                            <td>
                                {if $price >= 0}
                                    {$price}<br>
                                    <small>{$years} {if $years > 1}{lang key="orderForm.years"}{else}{lang key="orderForm.year"}{/if}</small>
                                {else}
                                    <small>{lang key="domainregnotavailable"}</small>
                                {/if}
                            </td>
                            {break}
                            {foreachelse}
                            <td>-</td>
                        {/foreach}
                        <td>
                            {if is_null($data.grace_period)}
                                -
                            {else}
                                {$data.grace_period.days} {lang key='domainrenewalsdays'}<br>
                                <small>({$data.grace_period.price})</small>
                            {/if}
                        </td>
                        <td>
                            {if is_null($data.redemption_period)}
                                -
                            {else}
                                {$data.redemption_period.days} {lang key='domainrenewalsdays'}<br>
                                <small>({$data.redemption_period.price})</small>
                            {/if}
                        </td>
                    </tr>
                    {foreachelse}
                    <tr>
                        <td colspan="7">{lang key="pricing.noExtensionsDefined"}</td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
            <div class="loder loader-table" id="tableLoading">
                {include file="$template/includes/loader.tpl"}
            </div>
        </div>

    </div>
{/if}
