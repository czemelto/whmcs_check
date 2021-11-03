{if isset($RSThemes.pages.affiliates)}
    {include file=$RSThemes['pages']['affiliates']['fullPath']}
{else}
    {if $inactive}
        {include file="$template/includes/alert.tpl" type="danger" msg=$LANG.affiliatesdisabled textcenter=true}
    {else}
        <div class="tiles clearfix swiper-container">
            <div class="row swiper-wrapper">
                <div class="col-sm-4 swiper-slide">
                    <div class="tile">
                        <div class="icon">
                            <i class="lm lm-mouse"></i>
                        </div>
                        <div class="stat">{$visitors}</div>
                        <div class="title">{$LANG.affiliatesclicks}</div>
                    </div>
                </div>
                <div class="col-sm-4 swiper-slide">
                    <div class="tile">
                        <div class="icon">
                            <i class="lm lm-user"></i>
                        </div>
                        <div class="stat">{$signups}</div>
                        <div class="title">{$LANG.affiliatessignups}</div>
                    </div>
                </div>
                <div class="col-sm-4 swiper-slide">
                    <div class="tile">
                        <div class="icon">
                            <i class="lm lm-bar-graph"></i>
                        </div>  
                        <div class="stat">{if $conversionrate|string_format:"%d" < 100}{$conversionrate}{else}{$conversionrate|string_format:"%.1f"}{/if}%</div>
                        <div class="title">{$LANG.affiliatesconversionrate}</div>
                    </div>
                </div>
            </div>
            <div class="swiper-pagination"></div>
        </div>
        <div class="section">
            <div class="panel panel-default panel-form">
                <div class="panel-body">
                    <div class="input-group input-group-xlg input-group-vertical-sm">
                        <div class="input-group-addon">{$LANG.affiliatesreferallink}</div>
                        <input class="form-control text-primary bg-white" type="text" readonly value="{$referrallink}"> 
                    </div>
                </div>
            </div>
        </div>
        <div class="section">
            <div class="d-flex space-between align-center m-b-16">
                <h3 class="m-b-0">{$LANG.affiliatesreferals}</h3>
                {if $referrals}
                    <div class="search-group">
                        <input type="text" class="form-control" id="table-search" placeholder="{$LANG.tableentersearchterm}"> 
                    </div>
                {/if}
            </div>
            {if $referrals}
            {include file="$template/includes/tablelist.tpl" tableName="AffiliatesList" filterColumn="4"}
            <script type="text/javascript">
                jQuery(document).ready( function ()
                {
                    var table = jQuery('#tableAffiliatesList').removeClass('hidden').DataTable();
                    {if $orderby == 'regdate'}
                        table.order(0, '{$sort}');
                    {elseif $orderby == 'product'}
                        table.order(1, '{$sort}');
                    {elseif $orderby == 'amount'}
                        table.order(2, '{$sort}');
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
                                {foreach key=num item=status from=$RSReferralsStatuses}
                                    <li><a href="#"><span data-value="{$status.statustext}">{$status.statustext}</span></a></li>
                                {/foreach}
                            </ul>
                        </div>
                    </div>  
                </div>
                <table id="tableAffiliatesList" class="table table-list">
                    <thead>
                        <tr>
                            <th data-priority="1"><button type="button" class="btn-table-collapse"></button>{$LANG.affiliatessignupdate}</th>
                            <th data-priority="3">{$LANG.orderproduct}</th>
                            <th data-priority="4">{$LANG.affiliatesamount}</th>
                            <th data-priority="5">{$LANG.affiliatescommission}</th>
                            <th data-priority="2">{$LANG.affiliatesstatus}</th>
                        </tr>
                    </thead>
                    <tbody>
                    {foreach from=$referrals item=referral}
                        <tr class="text-center">
                            <td><button type="button" class="btn-table-collapse"></button><span class="hidden">{$referral.datets}</span>{$referral.date}</td>
                            <td>{$referral.service}</td>
                            <td data-order="{$referral.amountnum}">{$referral.amountdesc}</td>
                            <td data-order="{$referral.commissionnum}">{$referral.commission}</td>
                            <td><span class='status status-{$referral.rawstatus|strtolower}'>{$referral.status}</span></td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
                <div class="loader loader-table" id="tableLoading">
                    {include file="$template/includes/loader.tpl"}    
                </div>
            </div>
        </div>   
        {else}
        <div class="message message-no-data">
            <div class="message-image">
                {include file="$template//assets/svg-icon/track.tpl"}    
            </div>
            <h6 class="message-text">{$LANG.norecordsfound}</h6>
            </div>
        </div>
        {/if} 

                                        
        {if $affiliatelinkscode}
            <div class="section">
                <h3>{$LANG.affiliateslinktous}</h3>
                <div class="panel panel-default">
                    <div class="panel-body">
                        {$affiliatelinkscode}
                    </div>
                </div>
            </div>    
        {/if}
    {/if}
{/if}