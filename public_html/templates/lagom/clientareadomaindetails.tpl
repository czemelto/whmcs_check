{if isset($RSThemes.pages.clientareadomaindetails)}
    {include file=$RSThemes['pages']['clientareadomaindetails']['fullPath']}
{else}
    {if $registrarcustombuttonresult=="success"}
        {include file="$template/includes/alert.tpl" type="success" msg=$LANG.moduleactionsuccess textcenter=true}
    {elseif $registrarcustombuttonresult}
        {include file="$template/includes/alert.tpl" type="error" msg=$LANG.moduleactionfailed textcenter=true}
    {/if}

    {if $unpaidInvoice}
        <div class="alert alert-{if $unpaidInvoiceOverdue}danger{else}warning{/if}"
             id="alert{if $unpaidInvoiceOverdue}Overdue{else}Unpaid{/if}Invoice">
            <div class="alert-body">
                {$unpaidInvoiceMessage}
            </div>
            <div class="alert-actions pull-right">
                <a href="viewinvoice.php?id={$unpaidInvoice}" class="btn btn-xs btn-default">
                    {lang key='payInvoice'}
                </a>
            </div>
        </div>
    {/if}
    <div class="tab-content margin-bottom">
        <div class="tab-pane  in active" id="Overview">
            <h3>{$LANG.overview}</h3>
            {if $systemStatus != 'Active'}
                <div class="alert alert-warning text-center" role="alert">
                    {$LANG.domainCannotBeManagedUnlessActive}
                </div>
            {/if}
            {if $lockstatus eq "unlocked"}
                {capture name="domainUnlockedMsg"}<strong>{$LANG.domaincurrentlyunlocked}</strong>
                    <br/>
                    {$LANG.domaincurrentlyunlockedexp}{/capture}
                {include file="$template/includes/alert.tpl" type="error" msg=$smarty.capture.domainUnlockedMsg}
            {/if}


            <div class="product-details clearfix">
                <div class="row row-eq-height row-eq-height-sm">
                    <div class="col-sm-6">
                        <div class="product-icon">
                            <div class="product-image">
                                {include file="$template//assets/svg-icon/domain.tpl" onDark="true"}
                            </div>
                            <h2 class="product-name"><a href="http://{$domain}" target="_blank">{$domain}</a></h2>
                            <div class="product-status">{$LANG.clientareastatus}: <span
                                        class="label {if $domain_hureg_status == ""} {else} {$domain_hureg_status_color}{/if}">{if $domain_hureg_status == ""}{$status} {else} {$domain_hureg_status}{/if}</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="product-info">
                            <ul class="list-info list-info-v">
                                <li>
                                    <span class="list-info-title">{$LANG.clientareahostingregdate}:</span>
                                    <span class="list-info-text">{$registrationdate}</span>
                                </li>
                                <li>
                                    <span class="list-info-title">{$LANG.clientareahostingnextduedate}:</span>
                                    <span class="list-info-text">{$nextduedate}</span>
                                </li>
                                <li>
                                    <span class="list-info-title">{$LANG.firstpaymentamount}:</span>
                                    <span class="list-info-text">{$firstpaymentamount}</span>
                                </li>
                                <li>
                                    <span class="list-info-title">{$LANG.recurringamount}:</span>
                                    <span class="list-info-text">{$recurringamount} {$LANG.every} {$registrationperiod} {$LANG.orderyears}</span>
                                </li>
                                <li>
                                    <span class="list-info-title">{$LANG.orderpaymentmethod}:</span>
                                    <span class="list-info-text">{$paymentmethod}</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <!--
            {if $sslStatus}
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">SSL</h3>
                    </div>
                    <ul class="list-info list-info-50 list-info-bordered">
                        <li class="{if $sslStatus->isInactive()} ssl-required{/if}">
                            <span class="list-info-title">{$LANG.sslState.sslStatus}</span>
                            <span class="list-info-text">
                                {assign var="awords" value="/"|explode:$sslStatus->getImagePath()}
                                {section name=i loop=$awords}
                                    {assign var="imageSSL" value=$awords[i]|escape}
                                {/section}
                                <img class="m-r-8 {$sslStatus->getClass()}" src="{$WEB_ROOT}/templates/{$template}/assets/img/ssl/{$imageSSL|replace:".png":".svg"}" width="18" data-type="domain" data-domain="{$domain}" data-showlabel="1">
                                <span id="statusDisplayLabel">
                                    {if !$sslStatus->needsResync()}
                                        {$sslStatus->getStatusDisplayLabel()}
                                    {else}
                                        {$LANG.loading}
                                    {/if}
                                </span>
                            </span>
                        </li>
                        {if $sslStatus->isActive() || $sslStatus->needsResync()}
                            <li>
                                <span class="list-info-title">{$LANG.sslState.startDate}</span>
                                <span class="list-info-text" id="ssl-startdate">
                                    {if !$sslStatus->needsResync() || $sslStatus->startDate}
                                        {$sslStatus->startDate->toClientDateFormat()}
                                    {else}
                                        {$LANG.loading}
                                    {/if}
                                </span>
                            </li>
                            <li>
                                <span class="list-info-title">{$LANG.sslState.issuerName}</span>
                                <span class="list-info-text" id="ssl-issuer">
                                    {if !$sslStatus->needsResync() || $sslStatus->issuerName}
                                        {$sslStatus->issuerName}
                                    {else}
                                        {$LANG.loading}
                                    {/if}
                                </span>
                            </li>
                            <li>
                                <span class="list-info-title">{$LANG.sslState.expiryDate}</span>
                                <span class="list-info-text" id="ssl-expirydate">
                                    {if !$sslStatus->needsResync() || $sslStatus->expiryDate}
                                        {$sslStatus->expiryDate->toClientDateFormat()}
                                    {else}
                                        {$LANG.loading}
                                    {/if}
                                </span>
                            </li>
                        {/if}
                    </ul>
                </div>
            {/if}
            -->

            {if $registrarclientarea}
                <div class="moduleoutput">
                    {$registrarclientarea|replace:'modulebutton':'btn'}
                </div>
            {/if}

            {foreach $hookOutput as $output}
                <div>
                    {$output}
                </div>
            {/foreach}

            {if $canDomainBeManaged
            and (
            $managementoptions.nameservers or
            $managementoptions.contacts or
            $managementoptions.locking or
            $renew)}
                {* No reason to show this section if nothing can be done here! *}
                <div class="panel panel-sidebar m-b-0">
                    <div class="panel-heading">
                        <h3 class="panel-title">{$LANG.doToday}</h3>
                    </div>
                    <ul class="list-group list-group-v">
                        {if $systemStatus == 'Active' && $managementoptions.nameservers}
                            <li class="list-group-item">
                                <a class="tabControlLink" data-toggle="tab" href="#tabNameservers">
                                    <i class="ls ls-share"></i>{$LANG.changeDomainNS}
                                </a>
                            </li>
                        {/if}
                        {if $systemStatus == 'Active' && $managementoptions.contacts}
                            <li class="list-group-item">
                                <a href="clientarea.php?action=domaincontacts&domainid={$domainid}">
                                    <i class="ls ls-user"></i>{$LANG.updateWhoisContact}
                                </a>
                            </li>
                        {/if}
                        {if $systemStatus == 'Active' && $managementoptions.locking}
                            <li class="list-group-item">
                                <a class="tabControlLink" data-toggle="tab" href="#tabReglock">
                                    <i class="ls ls-shield"></i>{$LANG.changeRegLock}
                                </a>
                            </li>
                        {/if}
                        {if $renew}
                            <li class="list-group-item">
                                <a href="{routePath('domain-renewal', $domain)}">
                                    <i class="ls ls-refresh"></i>{$LANG.renewYourDomain}
                                </a>
                            </li>
                        {/if}
                    </ul>
                </div>
            {/if}
        </div>
        <div class="tab-pane " id="Autorenew">
            <div class="section">
                <div class="section-header">
                    <h3>{$LANG.domainsautorenew}</h3>
                    <p>{$LANG.domainrenewexp}</p>
                </div>
                <div class="section-body">
                    {if $changeAutoRenewStatusSuccessful}
                        {include file="$template/includes/alert.tpl" type="success" msg=$LANG.changessavedsuccessfully}
                    {/if}
                    <div class="section-body">
                        <form method="post" action="{$smarty.server.PHP_SELF}?action=domaindetails#tabAutorenew">
                            <input type="hidden" name="id" value="{$domainid}">
                            <input type="hidden" name="sub" value="autorenew"/>
                            <button class="panel panel-switch m-w-288{if $autorenew} checked{/if}" type="submit">
                                <div class="panel-body">
                                    <span class="switch-label">{$LANG.domainautorenewstatus}: </span>
                                    {if $autorenew}
                                        <input type="hidden" name="autorenew" value="disable">
                                    {else}
                                        <input type="hidden" name="autorenew" value="enable">
                                    {/if}
                                    <label class="switch switch--lg switch--text" submit-form>
                                        <input class="switch__checkbox" type="checkbox" {if $autorenew}checked{/if}>
                                        <span class="switch__container"><span class="switch__handle"></span></span>
                                    </label>
                                </div>
                                <div class="loader loader-panel">
                                    {include file="$template/includes/loader.tpl"}
                                </div>
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="tab-pane " id="auditlogs">
            <h3>Domainhez kapcsolódó audit logok</h3>

            <table class="datatable">
                <tr>
                    <th>Állapot</th>
                    <th>Idő</th>
                    <th>Bejegyzés</th>
                </tr>
                {foreach $domainlogs as $log_entry}
                    <tr>
                        <td>
                            {if $log_entry->event_type == "success"}
                                <span class="status status-paid"> OK</span>
                            {elseif $log_entry->event_type == "info"}
                                <span class="status status-custom"> INFO</span>
                            {else}
                                <span class="status status-unpaid"> HIBA</span>
                            {/if}
                        </td>
                        <td>
                            {$log_entry->event_time}
                        </td>
                        <td>
                            {$log_entry->event_text}
                        </td>
                    </tr>
                {/foreach}
            </table>

        </div>
        <div class="tab-pane " id="Nameservers">
            <div class="section">
                <div class="section-header">
                    <h3>{$LANG.domainnameservers}</h3>
                    <p>{$LANG.domainnsexp}</p>
                </div>
                <div class="section-body">
                    {if $nameservererror}
                        {include file="$template/includes/alert.tpl" type="error" msg=$nameservererror}
                    {/if}
                    {if $subaction eq "savens"}
                        {if $updatesuccess}
                            {include file="$template/includes/alert.tpl" type="success" msg=$LANG.changessavedsuccessfully}
                        {elseif $error}
                            {include file="$template/includes/alert.tpl" type="error" msg=$error}
                        {/if}
                    {/if}
                    <form role="form" method="post"
                          action="{$smarty.server.PHP_SELF}?action=domaindetails#tabNameservers">
                        <input type="hidden" name="id" value="{$domainid}"/>
                        <input type="hidden" name="sub" value="savens"/>
                        <div class="panel-group panel-group-condensed" data-inputs-container>
                            <div class="panel panel-check {if $defaultns}checked{/if}" data-virtual-input>
                                <div class="panel-heading check">
                                    <label>
                                        <input type="radio" class="icheck-control" name="nschoice" value="default"
                                               onclick="disableFields('domnsinputs',true)"{if $defaultns} checked{/if} />
                                        <div class="check-content">
                                            <span> {$LANG.nschoicedefault}</span>
                                        </div>
                                    </label>
                                </div>
                            </div>
                            <div class="panel panel-check {if !$defaultns} checked{/if}" data-virtual-input>
                                <div class="panel-heading check">
                                    <label>
                                        <input type="radio" class="icheck-control" name="nschoice" value="custom"
                                               onclick="disableFields('domnsinputs',false)"{if !$defaultns} checked{/if} />
                                        <div class="check-content">
                                            <span>{$LANG.nschoicecustom}</span>
                                        </div>
                                    </label>
                                </div>
                                <div class="panel-collapse collapse {if !$defaultns}in{/if}" data-input-collapse>
                                    <div class="panel-body">
                                        <div class="m-w-416">
                                            {for $num=1 to 5}
                                                <div class="form-group">
                                                    <label for="inputNs{$num}"
                                                           class="control-label">{$LANG.clientareanameserver} {$num}</label>
                                                    <input type="text" name="ns{$num}" class="form-control domnsinputs"
                                                           id="inputNs{$num}" value="{$nameservers[$num].value}"/>
                                                </div>
                                            {/for}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-actions">
                            <input type="submit" class="btn btn-primary" value="{$LANG.changenameservers}"/>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="tab-pane " id="Reglock">
            <div class="section">
                <div class="section-header">
                    <h3>{$LANG.domainregistrarlock}</h3>
                    <p>{$LANG.domainlockingexp}</p>
                </div>
                <div class="section-body">
                    {if $subaction eq "savereglock"}
                        {if $updatesuccess}
                            {include file="$template/includes/alert.tpl" type="success" msg=$LANG.changessavedsuccessfully}
                        {elseif $error}
                            {include file="$template/includes/alert.tpl" type="error" msg=$error}
                        {/if}
                    {/if}
                    <form method="post" action="{$smarty.server.PHP_SELF}?action=domaindetails#tabReglock">
                        <input type="hidden" name="id" value="{$domainid}">
                        <input type="hidden" name="sub" value="savereglock"/>

                        <div class="panel panel-switch m-w-288" href="#" submit-form>
                            <div class="panel-body">
                                <span class="switch-label">{$LANG.domainreglockstatus}: </span>
                                {if $lockstatus=="locked"}

                                {else}
                                    <input type="hidden" name="autorenew" value="enable">
                                {/if}

                                <label class="switch switch--lg switch--text">
                                    <input class="switch__checkbox" name="reglock" type="checkbox"
                                           {if $lockstatus=="locked"}checked{/if}>
                                    <span class="switch__container"><span class="switch__handle"></span></span>
                                </label>
                            </div>
                            <div class="loader loader-panel">
                                {include file="$template/includes/loader.tpl"}
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="tab-pane " id="Release">
            <div class="section">
                <div class="section-header">
                    <h3>{$LANG.domainrelease}</h3>
                    <p>{$LANG.domainreleasedescription}</p>
                </div>
                <div class="section-body">
                    <form role="form" method="post" action="{$smarty.server.PHP_SELF}?action=domaindetails">
                        <input type="hidden" name="sub" value="releasedomain">
                        <input type="hidden" name="id" value="{$domainid}">
                        <div class="panel panel-default panel-form">
                            <div class="panel-body">
                                <div class="form-group m-w-416 m-b-8">
                                    <label for="inputReleaseTag" class="control-label">{$LANG.domainreleasetag}</label>
                                    <input type="text" class="form-control" id="inputReleaseTag" name="transtag"/>
                                </div>
                            </div>
                            <div class="panel-footer">
                                <input type="submit" value="{$LANG.domainrelease}" class="btn btn-primary"/>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="tab-pane " id="Addons">
            <div class="section">
                <div class="section-header">
                    <h3>{$LANG.domainaddons}</h3>
                    <p>{$LANG.domainaddonsinfo}</p>
                </div>
                <div class="section-body">
                    <div class="row row-eq-height">
                        {if $addons.idprotection}
                            <div class="col-md-6">
                                <div class="package package-horizontal m-b-24">
                                    <h3 class="package-name text-center">{$LANG.domainidprotection}</h3>
                                    <div class="package-content text-center">
                                        <div class="package-icon">
                                            {include file="$template//assets/svg-icon/addon-id-protection.tpl"}
                                        </div>
                                        <p>{$LANG.domainaddonsidprotectioninfo}</p>
                                    </div>
                                    {if $addonstatus.idprotection}
                                        <div class="package-actions">
                                            <form action="clientarea.php?action=domainaddons" method="post">
                                                <input type="hidden" name="id" value="{$domainid}"/>
                                                <input type="hidden" name="disable" value="idprotect"/>
                                                <input type="submit" value="{$LANG.disable}"
                                                       class="btn btn-lg btn-default"/>
                                            </form>
                                        </div>
                                    {else}
                                        <div class="package-footer">
                                            <div class="package-price">
                                                <div class="price"><span
                                                            class="price-prefix">{$WHMCSCurrency.prefix}</span>{$addonspricing.idprotection->toSuffixed()}
                                                </div>
                                            </div>
                                            <div class="package-actions">
                                                <form action="clientarea.php?action=domainaddons" method="post">
                                                    <input type="hidden" name="id" value="{$domainid}"/>
                                                    <input type="hidden" name="buy" value="idprotect"/>
                                                    <input type="submit" value="{$LANG.ordertitle}"
                                                           class="btn btn-lg btn-primary"/>
                                                </form>
                                            </div>
                                        </div>
                                    {/if}
                                </div>
                            </div>
                        {/if}
                        {if $addons.dnsmanagement}
                            <div class="col-md-6">
                                <div class="package package-horizontal m-b-24">
                                    <h3 class="package-name text-center">{$LANG.domainaddonsdnsmanagement}</h3>
                                    <div class="package-content text-center">
                                        <div class="package-icon">
                                            {include file="$template//assets/svg-icon/domain.tpl"}
                                        </div>
                                        <p>{$LANG.domainaddonsdnsmanagementinfo}</p>
                                    </div>
                                    {if $addonstatus.dnsmanagement}
                                        <div class="package-actions">
                                            <form action="clientarea.php?action=domainaddons" method="post">
                                                <input type="hidden" name="id" value="{$domainid}"/>
                                                <input type="hidden" name="disable" value="dnsmanagement"/>
                                                <a class="btn btn-lg btn-primary"
                                                   href="clientarea.php?action=domaindns&domainid={$domainid}">{$LANG.manage}</a>
                                                <input type="submit" value="{$LANG.disable}"
                                                       class="btn btn-lg btn-default"/>
                                            </form>
                                        </div>
                                    {else}
                                        <div class="package-footer">
                                            <div class="package-price">
                                                <div class="price"><span
                                                            class="price-prefix">{$WHMCSCurrency.prefix}</span>{$addonspricing.dnsmanagement->toSuffixed()}
                                                </div>
                                            </div>
                                            <div class="package-actions">
                                                <form action="clientarea.php?action=domainaddons" method="post">
                                                    <input type="hidden" name="id" value="{$domainid}"/>
                                                    <input type="hidden" name="buy" value="dnsmanagement"/>
                                                    <input type="submit" value="{$LANG.ordertitle}"
                                                           class="btn btn-lg btn-primary"/>
                                                </form>
                                            </div>
                                        </div>
                                    {/if}
                                </div>
                            </div>
                        {/if}
                        {if $addons.emailforwarding}
                            <div class="col-md-6">
                                <div class="package package-horizontal m-b-24">
                                    <h3 class="package-name text-center">{$LANG.domainemailforwarding}</h3>
                                    <div class="package-content text-center">
                                        <div class="package-icon">
                                            {include file="$template//assets/svg-icon/addon-email-forwarding.tpl"}
                                        </div>
                                        <p>{$LANG.domainaddonsemailforwardinginfo}</p>
                                    </div>
                                    {if $addonstatus.emailforwarding}
                                        <div class="package-actions">
                                            <form action="clientarea.php?action=domainaddons" method="post">
                                                <input type="hidden" name="id" value="{$domainid}"/>
                                                <input type="hidden" name="disable" value="emailfwd"/>
                                                <a class="btn btn-lg btn-primary"
                                                   href="clientarea.php?action=domainemailforwarding&domainid={$domainid}">{$LANG.manage}</a>
                                                <input type="submit" value="{$LANG.disable}"
                                                       class="btn btn-lg btn-default"/>
                                            </form>
                                        </div>
                                    {else}
                                        <div class="package-footer">
                                            <div class="package-price">
                                                <div class="price"><span
                                                            class="price-prefix">{$WHMCSCurrency.prefix}</span>{$addonspricing.emailforwarding->toSuffixed()}
                                                </div>
                                            </div>
                                            <div class="package-actions">
                                                <form action="clientarea.php?action=domainaddons" method="post">
                                                    <input type="hidden" name="id" value="{$domainid}"/>
                                                    <input type="hidden" name="buy" value="emailfwd"/>
                                                    <input type="submit" value="{$LANG.ordertitle}"
                                                           class="btn btn-lg btn-primary"/>
                                                </form>
                                            </div>
                                        </div>
                                    {/if}
                                </div>
                            </div>
                        {/if}
                    </div>
                </div>
            </div>
        </div>
    </div>
{/if}
