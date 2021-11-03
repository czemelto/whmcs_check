{if isset($RSThemes.pages.upgrade)}
    {include file=$RSThemes['pages']['upgrade']['fullPath']}
{else} 	    
    {if $overdueinvoice}
        <div class="message message-danger message-lg message-no-data">
            <div class="message-icon">
                <i class="lm lm-close"></i>
            </div>
            <h2 class="message-text">{$rslang->trans('nodata.upgrade_not_available')}</h2>
            <h6 class="text-center text-light">{$LANG.upgradeerroroverdueinvoice}</h6>
            <a href="clientarea.php?action=productdetails&id={$id}" class="btn btn-default">
                {$LANG.backtoservicedetails}
            </a>
        </div>
    {elseif $existingupgradeinvoice}
        <div class="message message-danger message-lg message-no-data">
            <div class="message-icon">
                <i class="lm lm-close"></i>
            </div>
            <h2 class="message-text">{$rslang->trans('nodata.upgrade_not_available')}</h2>
            <h6 class="text-center text-light">{$LANG.upgradeexistingupgradeinvoice}</h6>
            <a href="submitticket.php" class="btn btn-default">
                {$LANG.submitticketdescription}
            </a>
        </div>
    {elseif $upgradenotavailable}
        <div class="message message-danger message-lg message-no-data">
            <div class="message-icon">
                <i class="lm lm-close"></i>
            </div>
            <h2 class="message-text">{$rslang->trans('nodata.upgrade_not_available')}</h2>
            <h6 class="text-center text-light">{$LANG.upgradeNotPossible}</h6>
            <a href="submitticket.php" class="btn btn-default">
                {$LANG.submitticketdescription}
            </a>
        </div>
    {else}
        {if $type eq "package"}
            <p>{$LANG.upgradechoosepackage}</p>
            <div class="section">
                <div class="section-header">
                    <h3>{$LANG.upgradecurrentconfig}:</h3>
                </div>
                <div class="section-body">
                    <div class="panel panel-default active">
                        <div class="panel-body">
                            <strong>{$groupname} - {$productname}</strong> {if $domain} ({$domain}){/if}
                        </div>
                    </div>
                </div>
            </div>
            <div class="section">
                <div class="section-header">
                    <h3>{$LANG.upgradenewconfig}:</h3>
                </div>
                <div class="section-body">
                    <div class="row row-eq-height">
                        {foreach key=num item=upgradepackage from=$upgradepackages}
                            <div class="col-md-4">
                                <form class="package" method="post" action="{$smarty.server.PHP_SELF}">
                                    <input type="hidden" name="step" value="2">
                                    <input type="hidden" name="type" value="{$type}">
                                    <input type="hidden" name="id" value="{$id}">
                                    <input type="hidden" name="pid" value="{$upgradepackage.pid}">
                                    <h3 class="package-name">{$upgradepackage.groupname} - {$upgradepackage.name}</h3>
                                    <div class="package-content">
                                        <ul class="package-features">
                                            <li>
                                                {$upgradepackage.description|replace:"<br/>":"</li>"}
                                            </li>
                                        </ul>
                                        <div class="form-group m-b-8 m-t-16">
                                            {if $upgradepackage.pricing.type eq "free"}
                                                <input type="hidden" name="billingcycle" value="free">
                                                <div class="package-price">
                                                    <div class="price">
                                                        {$LANG.orderfree}
                                                    </div>
                                                </div>
                                            {elseif $upgradepackage.pricing.type eq "onetime"}
                                                <input type="hidden" name="billingcycle" value="onetime">
                                                <div class="package-price">
                                                    <div class="price">{$upgradepackage.pricing.onetime}</span>
                                                    </div>
                                                    <div class="package-setup-fee">{$LANG.orderpaymenttermonetime}</div>
                                                </div>        
                                            {elseif $upgradepackage.pricing.type eq "recurring"}
                                                <select name="billingcycle" class="form-control input-lg">
                                                    {if $upgradepackage.pricing.monthly}<option value="monthly">{$upgradepackage.pricing.monthly}</option>{/if}
                                                    {if $upgradepackage.pricing.quarterly}<option value="quarterly">{$upgradepackage.pricing.quarterly}</option>{/if}
                                                    {if $upgradepackage.pricing.semiannually}<option value="semiannually">{$upgradepackage.pricing.semiannually}</option>{/if}
                                                    {if $upgradepackage.pricing.annually}<option value="annually">{$upgradepackage.pricing.annually}</option>{/if}
                                                    {if $upgradepackage.pricing.biennially}<option value="biennially">{$upgradepackage.pricing.biennially}</option>{/if}
                                                    {if $upgradepackage.pricing.triennially}<option value="triennially">{$upgradepackage.pricing.triennially}</option>{/if}
                                                </select>
                                            {/if}
                                        </div>   
                                    </div>
                                    <div class="package-footer">
                                        <div class="package-actions">
                                            <input type="submit" value="{$LANG.upgradedowngradechooseproduct}" class="btn btn-lg btn-primary" id="btnUpgradeDowngradeChooseProduct"/>                                        
                                        </div>
                                    </div>
                                    
                                </form>    
                            </div>
                        {/foreach}
                    </div>    
                </div>
            </div>
        {elseif $type eq "configoptions"}
            <p>{$LANG.upgradechooseconfigoptions}</p>
            {if $errormessage}
                {include file="$template/includes/alert.tpl" type="error" errorshtml=$errormessage}
            {/if}
            <form method="post" action="{$smarty.server.PHP_SELF}">
                <input type="hidden" name="step" value="2" />
                <input type="hidden" name="type" value="{$type}" />
                <input type="hidden" name="id" value="{$id}" />
                {foreach key=num item=configoption from=$configoptions}
                <div class="upgrade-config-option">
                    <h3>{$configoption.optionname}</h3>
                    <div class=" row row-eq-height m-b-neg-24">
                        <div class="upgrade-current col-sm-6">          
                            <div class="panel panel-default panel-form active">
                                <div class="panel-body">
                                    <h6>{$LANG.upgradecurrentconfig}</h6>						
                                    {if $configoption.optiontype eq 1 || $configoption.optiontype eq 2}	
                                        <input class="form-control" type="text" value="{$configoption.selectedname}" disabled="">
                                    {elseif $configoption.optiontype eq 3}
                                        <label class="switch switch--lg switch--text">
                                            <input class="switch__checkbox" type="checkbox" {if $configoption.selectedqty}checked=""{/if} disabled="">
                                            <span class="switch__container"><span class="switch__handle"></span></span>
                                        </label>
                                    {elseif $configoption.optiontype eq 4}
                                        <div class="input-group">
                                            <input class="form-control" type="number" value="{$configoption.selectedqty}" disabled="">
                                            <span class="input-group-addon">x {$configoption.options.0.name}</span>
                                        </div>
                                    {/if}
                                </div>
                            </div>
                        </div>
                        <div class="upgrade-new col-sm-6">          
                            <div class="panel panel-default panel-form">
                                <div class="panel-body">
                                    <h6>{$LANG.upgradenewconfig}</h6>
                                    {if $configoption.optiontype eq 1 || $configoption.optiontype eq 2}	
                                        <select name="configoption[{$configoption.id}]" class="form-control">
                                            {foreach key=num item=option from=$configoption.options}
                                                {if $option.selected}<option value="{$option.id}" selected>{$LANG.upgradenochange}</option>{else}<option value="{$option.id}">{$option.nameonly} {$option.price}{/if}</option>
                                            {/foreach}
                                        </select>
                                    {elseif $configoption.optiontype eq 3}
                                        <label class="switch switch--lg switch--text">
                                            <input class="switch__checkbox" type="checkbox" name="configoption[{$configoption.id}]" value="1"{if $configoption.selectedqty} checked{/if}>
                                            <span class="switch__container"><span class="switch__handle"></span></span>
                                        </label>
                                    {elseif $configoption.optiontype eq 4}
                                        <div class="input-group">
                                            <input class="form-control" name="configoption[{$configoption.id}]" value="{$configoption.selectedqty}">
                                            <span class="input-group-addon">x {$configoption.options.0.name}</span>
                                        </div>
                                    {/if}
                                </div>
                            </div>                            
                        </div>
                    </div>
                </div>
                {/foreach}
                <div class="form-actions">
                    <input type="submit" value="{$LANG.ordercontinuebutton}" class="btn btn-primary" />
                </div>
            </form>
        {/if}
    {/if}
{/if}