<link href="modules/servers/cpanel/css/client.css" rel="stylesheet">
<script src="modules/servers/cpanel/js/client.js"></script>
<div class="product-details">
    <div class="row row-eq-height row-eq-height-sm">
        <div class="col-sm-6">
            <div class="product-icon" id="cPanelPackagePanel">
                <div class="product-content">
                    <div class="product-image">
                        <svg class="svg-icon svg-icon-on-dark" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="64px" height="64px" viewBox="0 0 64 64" style="enable-background:new 0 0 64 64;" xml:space="preserve">
                        <line class="outline stroke" x1="32" y1="1.5" x2="32" y2="8.4"></line>
                        <polygon class="prime stroke" points="17,23 32,31.7 47,23 47,16.9 17,16.9"></polygon>
                        <polygon class="prime-l stroke" points="32,25.2 17,16.6 32,7.9 47,16.6"></polygon>
                        <line class="outline stroke" x1="32" y1="32.7" x2="32" y2="62.5"></line>
                        <polyline class="outline stroke" points="58.5,16.9 32,32.2 5.5,16.9"></polyline>
                        <polygon class="outline stroke" points="32,63 5,47.4 5,16.6 32,1 59,16.6 59,47.4"></polygon>
                        </svg>
                    </div>
                    <h2 class="product-name">{$groupname} - {$product}</h2>
                    <div class="product-status">{$LANG.clientareastatus}:
                        <span class="label label-success">{$status}</span>
                    </div>
                </div>
                 {if $domain}  
                 <a class="product-footer" href="http://{$domain}">{$domain}</a>
                 {/if}
            </div>
        </div>
        <div class="col-sm-6">
            <div class="panel panel-default" id="cPanelUsagePanel">
                <div class="panel-body text-center cpanel-usage-stats">
                    <div class="row">
                        <div class="col-sm-5 col-sm-offset-1 col-xs-6" id="diskUsage">
                            <div class="usage-stats">
                                <span>{$LANG.cPanel.diskUsage}</span>
                                <div class="knob-dial">
                                <input type="text" value="{$diskpercent|substr:0:-1}" class="usage-dial" data-bgColor="#e6e8ec" data-fgColor="#0c70de" data-angleOffset="-125" data-angleArc="250" data-min="0" data-max="{if substr($diskpercent, 0, -1) > 100}{$diskpercent|substr:0:-1}{else}100{/if}" data-readOnly="true" data-width="104" data-thickness=.3 data-height="80" />        
                                </div>
                                <span>{$diskusage} M / {$disklimit} M</span>
                            </div>
                        </div>
                        <div class="col-sm-5 col-xs-6" id="bandwidthUsage">
                            <div class="usage-stats">
                                <span>{$LANG.cPanel.bandwidthUsage}</span>
                                <input type="text" value="{$bwpercent|substr:0:-1}" class="usage-dial" data-bgColor="#e6e8ec" data-fgColor="#0c70de" data-angleOffset="-125" data-angleArc="250" data-min="0" data-max="{if substr($bwpercent, 0, -1) > 100}{$bwpercent|substr:0:-1}{else}100{/if}" data-readOnly="true" data-width="104" data-thickness=.3 data-height="80" />
                                <span>{$bwusage} M / {$bwlimit} M</span>
                            </div>
                        </div>
                    </div>
                    <script src="{$BASE_PATH_JS}/jquery.knob.js"></script>
                    <script type="text/javascript">
                        jQuery(function() {
                            jQuery(".usage-dial").knob({
                                'change': function (v) { console.log(v); },
                                draw: function () {
                                    if ($(this.i).val() > 0){
                                        $(this.i).val(this.cv + '%');
                                    }
                                
                                }
                            });
                        });
                    </script>
                </div>
                <div class="panel-footer">
                    {if $bwpercent|substr:0:-1 > 75}
                        <div class="text-danger text-center limit-near">
                            {if $bwpercent|substr:0:-1 > 100}
                                {$LANG.cPanel.usageStatsBwOverLimit}
                            {else}
                                {$LANG.cPanel.usageStatsBwLimitNear}
                            {/if}
                            {if $packagesupgrade}
                                <a href="upgrade.php?type=package&id={$serviceid}" class="btn btn-xs btn-danger">
                                    <i class="fa fa-arrow-circle-up"></i>
                                    {$LANG.cPanel.usageUpgradeNow}
                                </a>
                            {/if}
                        </div>
                    {elseif $diskpercent|substr:0:-1 > 75}
                        <div class="text-danger text-center limit-near">
                            {if $diskpercent|substr:0:-1 > 100}
                                {$LANG.cPanel.usageStatsDiskOverLimit}
                            {else}
                                {$LANG.cPanel.usageStatsDiskLimitNear}
                            {/if}
                            {if $packagesupgrade}
                                <a href="upgrade.php?type=package&id={$serviceid}" class="btn btn-xs btn-danger">
                                    <i class="fa fa-arrow-circle-up"></i>
                                    {$LANG.cPanel.usageUpgradeNow}
                                </a>
                            {/if}
                        </div>
                    {else}
                        <div class="text-center text-center limit-near">
                            {$LANG.cPanel.usageLastUpdated} {$lastupdate}
                        </div>
                    {/if}
                </div>
            </div>
        </div>
    </div>
</div>

{* Quick Shortcuts *}
{if $systemStatus == 'Active'}
    <div class="section">
        <h3>{$LANG.cPanel.quickShortcuts}</h3>
        <div class="panel panel-default" id="cPanelQuickShortcutsPanel">
            <div class="panel-body text-center">
                <div class="row cpanel-feature-row">
                    <div class="col-sm-3 col-xs-6" id="cPanelEmailAccounts">
                        <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=Email_Accounts" target="_blank">
                            <i class="lm lm-user"></i>
                            {$LANG.cPanel.emailAccounts}
                        </a>
                    </div>
                    <div class="col-sm-3 col-xs-6" id="cPanelForwarders">
                        <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=Email_Forwarders" target="_blank">
                            <i class="lm lm-arrow-fat-right"></i>
                            {$LANG.cPanel.forwarders}
                        </a>
                    </div>
                    <div class="col-sm-3 col-xs-6" id="cPanelAutoResponders">
                        <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=Email_AutoResponders" target="_blank">
                            <i class="lm lm-arrow-fat-left"></i>
                            {$LANG.cPanel.autoresponders}
                        </a>
                    </div>
                    <div class="col-sm-3 col-xs-6" id="cPanelFileManager">
                        <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=FileManager_Home" target="_blank">
                            <i class="lm lm-folder"></i>
                            {$LANG.cPanel.fileManager}
                        </a>
                    </div>
                </div>
                <div class="row cpanel-feature-row">
                    <div class="col-sm-3 col-xs-6" id="cPanelBackup">
                        <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=Backups_Home" target="_blank">
                            <i class="lm lm-backup"></i>
                            {$LANG.cPanel.backup}
                        </a>
                    </div>
                    <div class="col-sm-3 col-xs-6" id="cPanelSubdomains">
                        <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=Domains_SubDomains" target="_blank">
                            <i class="lm lm-globe"></i>
                            {$LANG.cPanel.subdomains}
                        </a>
                    </div>
                    <div class="col-sm-3 col-xs-6" id="cPanelAddonDomains">
                        <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=Domains_AddonDomains" target="_blank">
                            <i class="lm lm-plus-circle"></i>
                            {$LANG.cPanel.addonDomains}
                        </a>
                    </div>
                    <div class="col-sm-3 col-xs-6" id="cPanelCronJobs">
                        <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=Cron_Home" target="_blank">
                            <i class="lm lm-clock"></i>
                            {$LANG.cPanel.cronJobs}
                        </a>
                    </div>
                </div>
                <div class="row cpanel-feature-row">
                    <div class="col-sm-3 col-xs-6" id="cPanelMySQLDatabases">
                        <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=Database_MySQL" target="_blank">
                            <i class="lm lm-database"></i>
                            {$LANG.cPanel.mysqlDatabases}
                        </a>
                    </div>
                    <div class="col-sm-3 col-xs-6" id="cPanelPhpMyAdmin">
                        <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=Database_phpMyAdmin" target="_blank">
                            <i class="lm lm-php-admin"></i>
                            {$LANG.cPanel.phpMyAdmin}
                        </a>
                    </div>
                    <div class="col-sm-3 col-xs-6" id="cPanelAwstats">
                        <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=Stats_AWStats" target="_blank">
                            <i class="lm lm-line-graph"></i>
                            {$LANG.cPanel.awstats}
                        </a>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <div class="section">
        <h3>{$LANG.cPanel.createEmailAccount}</h3>
        <div class="panel panel-default panel-form" id="cPanelQuickEmailPanel">
            <div class="panel-body">
                {include file="$template/includes/alert.tpl" type="success" msg=$LANG.cPanel.emailAccountCreateSuccess textcenter=true hide=true idname="emailCreateSuccess" additionalClasses="email-create-feedback"}
                {include file="$template/includes/alert.tpl" type="danger" msg=$LANG.cPanel.emailAccountCreateFailed|cat:' <span id="emailCreateFailedErrorMsg"></span>' textcenter=true hide=true idname="emailCreateFailed" additionalClasses="email-create-feedback"}
                <form id="frmCreateEmailAccount" onsubmit="doEmailCreate();return false">
                    <input type="hidden" name="id" value="{$serviceid}" />
                    <input type="hidden" name="email_quota" value="250" />
                    <div class="row">
                        <div class="col-sm-6">
                            <label>{$LANG.contactemail}</label>
                            <div class="input-group">
                                <input type="text" name="email_prefix" class="form-control" placeholder="{$LANG.cPanel.usernamePlaceholder}">
                                <span class="input-group-addon">@{$domain}</span>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <label>{$LANG.clientareapassword}</label>
                            <input type="password" name="email_pw" class="form-control" placeholder="{$LANG.cPanel.passwordPlaceholder}">
                        </div>
                        <div class="col-sm-2">
                            <button type="submit" class="btn btn-primary btn-block">{$LANG.cPanel.create}</button>
                        </div>
                    </div>
                </form>

            </div>
        </div>
    </div>
{else}
    <div class="alert alert-warning text-center" role="alert" id="cPanelSuspendReasonPanel">
        {if $suspendreason}
            <strong>{$suspendreason}</strong><br />
        {/if}
        {$LANG.cPanel.packageNotActive} {$status}.<br />
        {if $systemStatus eq "Pending"}
            {$LANG.cPanel.statusPendingNotice}
        {elseif $systemStatus eq "Suspended"}
            {$LANG.cPanel.statusSuspendedNotice}
        {/if}
    </div>
{/if}
{foreach $hookOutput as $output}
    <div class="section section-hook-output">
        {$output}
    </div>
{/foreach}
<div class="section">
    <div class="panel panel-default">
        <div class="panel-nav">
            <ul class="nav nav-tabs">
                <li class="dropdown pull-right tabdrop hide">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="icon-align-justify"></i>
                        <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu"></ul>
                </li>
				<li class="active">
					<a href="#billingInfo" data-toggle="tab"><i class="ls ls-wallet"></i> {$LANG.cPanel.billingOverview}</a>
				</li>
                <li>
                    <a href="#domainInfo" data-toggle="tab" aria-expanded="true"><i class="ls ls-location"></i>{$LANG.clientareahostingdomain}</a>
                </li>
                {if $metricStats}
                <li>
                    <a href="#metrics" data-toggle="tab" aria-expanded="true"><i class="ls ls-location"></i>{$LANG.metrics.title}</a>
                </li>
                {/if}
				{if $customfields}
                <li>
                    <a href="#customFields" data-toggle="tab" aria-expanded="true"><i class="ls ls-hosting"></i> {$LANG.additionalInfo}</a>
                </li>
				{/if}
				{if $configurableoptions}
                <li>
                    <a href="#confiOptions" data-toggle="tab" aria-expanded="false"><i class="ls ls-configure"></i> {$LANG.orderconfigpackage}</a>
                </li>
				{/if}
            </ul>
        </div>
        <div class="tab-content">
			<div class="tab-pane active billingOverview" id="billingInfo">
				<div class="row row-eq-height row-eq-height-sm ">				
					{if $firstpaymentamount neq $recurringamount}
					<div class="col-sm-6 col-md-3">
						<div class="row" id="firstPaymentAmount">
							<div class="col-xs-12" >
								<span class="gray-base">
									{$LANG.firstpaymentamount}
								</span>
							</div>
							<div class="col-xs-12">
								{$firstpaymentamount}
							</div>
						</div>
					</div>
					{/if}
					<div class="col-sm-6 col-md-3">
						<div class="row" id="registrationDate">
							<div class="col-xs-12">
								<span class="gray-base">
									{$LANG.clientareahostingregdate}
								</span>
							</div>
							<div class="col-xs-12">
								{$regdate}
							</div>
						</div>
					</div>
					{if $billingcycle != $LANG.orderpaymenttermonetime && $billingcycle != $LANG.orderfree}
						<div class="col-sm-6 col-md-3">
							<div class="row" id="recurringAmount">
								<div class="col-xs-12">
									<span class="gray-base">
										{$LANG.recurringamount}
									</span>
								</div>
								<div class="col-xs-12">
									{$recurringamount}
								</div>
							</div>
						</div>
					{/if}
					<div class="col-sm-6 col-md-3">
						<div class="row" id="nextDueDate">
							<div class="col-xs-12">
								<span class="gray-base">
									{$LANG.clientareahostingnextduedate}
								</span>
							</div>
							<div class="col-xs-12">
								{$nextduedate}
							</div>
						</div>
					</div>
					<div class="col-sm-6 col-md-3">
						<div class="row" id="billingCycle">
							<div class="col-xs-12">
								<span class="gray-base">
									{$LANG.orderbillingcycle}
								</span>
							</div>
							<div class="col-xs-12">
								{$billingcycle}
							</div>
						</div>
					</div>
					<div class="col-sm-6 col-md-3">
						<div class="row" id="paymentMethod">
							<div class="col-xs-12">
								<span class="gray-base">
									{$LANG.orderpaymentmethod}
								</span>
							</div>
							<div class="col-xs-12">
								{$paymentmethod}
							</div>
						</div>
					</div>
				</div>			
			</div>
            <div class="tab-pane" id="domainInfo">
                <div class="cpanel-actions-container">
                    <p class="text-center">{$domain}</p>
                    <div class="cpanel-actions-btn">
                        <a href="http://{$domain}" class="btn btn-primary" target="_blank">{$LANG.visitwebsite}</a>
                        {if $domainId}
                            <a href="clientarea.php?action=domaindetails&id={$domainId}" class="btn btn-primary" target="_blank">{$LANG.managedomain}</a>
                        {/if}
                        <input type="button" onclick="popupWindow('whois.php?domain={$domain}','whois',650,420);return false;" value="{$LANG.whoisinfo}" class="btn btn-primary" />
                    </div>
                </div>
            </div>
            {if $metricStats}
            <div class="tab-pane" id="metrics">
                <div id="cPanelMetricStatsPanel">
                    {include file="$template/clientareaproductusagebilling.tpl"}
                </div>
            </div>    
            {/if}
			{if $customfields}
            <div class="tab-pane" id="customFields">
                <ul class="list-info list-info-50 list-info-bordered">
                    {foreach from=$customfields item=field}
                        <li>
                            <span class="list-info-title">{$field.name}</span>
                            <span class="list-info-text">
                                {if empty($field.value)}
                                    {$LANG.blankCustomField}
                                {else}
                                    {$field.value}
                                {/if}
                            </span>
                        </li>
                    {/foreach}
                </ul>
            </div>
			{/if}
			{if $configurableoptions}
            <div class="tab-pane" id="confiOptions">
                <ul class="list-info list-info-50 list-info-bordered">
                    {foreach from=$configurableoptions item=configoption}
                        <li>
                            <span class="list-info-title">{$configoption.optionname}</span>
                            <span class="list-info-text">{if $configoption.optiontype eq 3}{if $configoption.selectedqty}{$LANG.yes}{else}{$LANG.no}{/if}{elseif $configoption.optiontype eq 4}{$configoption.selectedqty} x {$configoption.selectedoption}{else}{$configoption.selectedoption}{/if}</span>
                        </li>
                    {/foreach}
                </ul>
            </div>
			{/if}
        </div>
        <script src="assets/js/bootstrap-tabdrop.js"></script>
        <script type="text/javascript">
            jQuery('.nav-tabs-overflow').tabdrop();
        </script>
    </div>
</div>


{if $availableAddonProducts}
    <div class="section">
        <h3>{$LANG.cPanel.addonsExtras}</h3>
        <div class="panel panel-form" id="cPanelExtrasPurchasePanel">
            <div class="panel-body">
                <form method="post" action="cart.php?a=add">
                    <input type="hidden" name="serviceid" value="{$serviceid}" />
                    <div class="row">
                        <div class="col-sm-8">
                        <select name="aid" class="form-control">
                            {foreach $availableAddonProducts as $addonId => $addonName}
                                <option value="{$addonId}">{$addonName}</option>
                            {/foreach}
                        </select>
                        </div>
                        <div class="col-sm-4">
                            <button type="submit" class="btn btn-primary btn-block">
                                {$LANG.cPanel.purchaseActivate}
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>    
{/if}