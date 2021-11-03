<script>
    window.langPasswordStrength = "{$LANG.pwstrength}";
    window.langPasswordWeak = "{$LANG.pwstrengthweak}";
    window.langPasswordModerate = "{$LANG.pwstrengthmoderate}";
    window.langPasswordStrong = "{$LANG.pwstrengthstrong}";
    window.langPasswordTooShort = "{$rslang->trans('login.at_least_pass')}";
    
</script>
<form method="post" action="{$smarty.server.PHP_SELF}?a=checkout" name="orderfrm" id="frmCheckout">
    <input type="hidden" name="submit" value="true" />
    
    <div class="section">
        <div class="section-header">
            <h3>{$LANG.billingdetails}</h3>
        </div>
        <div class="section-body">
            {if $loggedin}
                <div class="panel panel-default panel-form">
                    <div class="panel-body">
                        {if $clientsdetails.companyname}
                            <h4 class="address-heading">{$clientsdetails.companyname}</h4>
                        {/if}
                        <address>
                            <span class="address-item">{$clientsdetails.firstname} {$clientsdetails.lastname} </span> <br/>
                            <span class="address-item">{$clientsdetails.email} </span> <br/>
                            <span class="address-item">{$clientsdetails.address1}{if $clientsdetails.address2},{$clientsdetails.address2}{/if}</span><br/>
                            <span class="address-item">{$clientsdetails.city}, {$clientsdetails.postcode}</span> <br/>
                            <span class="address-item">{$clientsdetails.state}</span> <br/>
                            <span class="address-item">{$clientsdetails.country}</span> <br/>               
                            <span class="address-item">{$clientsdetails.phonenumber}</span>
                        </address>
                        <div class="hidden">
                            <input type="hidden" name="firstname" value="{$clientsdetails.firstname}">
                            <input type="hidden" name="lastname" value="{$clientsdetails.lastname}">
                            <input type="hidden" name="companyname" value="{$clientsdetails.companyname}">
                            <input type="hidden" name="address1" value="{$clientsdetails.address1}">
                            <input type="hidden" name="address2" value="{$clientsdetails.address2}">
                            <input type="hidden" name="city" value="{$clientsdetails.city}">
                            <input type="hidden" name="state" value="{$clientsdetails.state}">
                            <input type="hidden" name="postcode" value="{$clientsdetails.postcode}">
                            <input type="hidden" name="postcode" value="{$clientsdetails.country}">
                            <input type="hidden" name="email" value="{$clientsdetails.email}">
                            <input type="hidden" name="phonenumber" value="{$clientsdetails.phonenumber}">
                            {if $customfields}
                                {foreach $customfields as $customfield}                                    
                                    <div class="col-sm-6">
                                        {if $customfield.type eq 'tickbox'}
                                            <div class="form-check">
                                                <label>
                                                    {$customfield.input|replace:'type="checkbox"':'class="form-checkbox" type="checkbox"'}
                                                    <span class="form-indicator"></span>
                                                    <span class="form-text">
                                                        {$customfield.name}
                                                    </span>
                                                    {if $customfield.description}<i class="i-c-sm m-l-xxxs zmdi zmdi-help-outline tooltip" data-toggle="tooltip" data-title="{$customfield.description}"></i>{/if}
                                                </label>
                                            </div>
                                        {else}
                                            <div class="form-group">
                                                <label class="form-label">{$customfield.name}</label>
                                                {$customfield.input|replace:'style="width:90%;"':'class="form-control"'}
                                                {if $customfield.description}
                                                    <span class="form-feedback">
                                                        {$customfield.description}
                                                    </span>
                                                {/if}
                                            </div>
                                        {/if}
                                    </div>
                                {/foreach}                                      
                            {/if}
                        </div>
                    </div>
                </div>
            {else}
                <div class="panel-group panel-group-condensed m-b-0" data-inputs-container>
                    <div class="panel panel-default" data-virtual-input>
                        <div class="panel-heading check">
                            <label>                               
                                <input type="radio" name="custtype" {if $custtype eq "existing"}checked{/if} value="existing" />
                                <div class="check-content">
                                    <span>{$LANG.orderForm.existingCustomerLogin}</span>
                                </div>
                            </label>
                        </div>
                        <div class="panel-collapse collapse" data-input-collapse role="tabpanel">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="inputFirstName_exsist" class="control-label">{$LANG.orderForm.emailAddress}</label>
                                            <input type="text" name="loginemail" id="inputLoginEmail" class="form-control">
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="password_exsist" class="control-label">{$LANG.clientareapassword}</label>
                                            <input type="password" name="loginpassword" id="inputLoginPassword" class="form-control">
                                        </div>
                                    </div>
                                </div>
                                {include file="orderforms/$carttpl/linkedaccounts.tpl" linkContext="checkout-existing"}
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default checked" data-virtual-input>
                        <div class="panel-heading check">
                            <label>
                                <input type="radio" name="custtype" {if $custtype neq "existing"}checked{/if} value="new" />
                                <div class="check-content">
                                    <span>{$LANG.orderForm.createAccount}</span>
                                </div>
                            </label>
                        </div>   
                        <div class="panel-collapse collapse in" data-input-collapse role="tabpanel" >
                            <div class="panel-body">
                                <h6>{$LANG.orderForm.personalInformation}</h6>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="inputFirstName" class="control-label">{$LANG.orderForm.firstName}</label>
                                            <input type="text" name="firstname" id="inputFirstName" class="form-control" value="{$clientsdetails.firstname}"{if $loggedin} readonly="readonly"{/if}>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="inputLastName" class="control-label">{$LANG.orderForm.lastName}</label>
                                            <input type="text" name="lastname" id="inputLastName" class="form-control" value="{$clientsdetails.lastname}"{if $loggedin} readonly="readonly"{/if}>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="inputEmail" class="control-label">{$LANG.orderForm.emailAddress}</label>
                                            <input type="email" name="email" id="inputEmail" class="form-control" value="{$clientsdetails.email}"{if $loggedin} readonly="readonly"{/if}>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="inputPhone" class="control-label">{$LANG.orderForm.phoneNumber}</label>
                                             <input type="tel" name="phonenumber" id="inputPhone" class="form-control" value="{$clientsdetails.phonenumber}"{if $loggedin} readonly="readonly"{/if}>
                                        </div>
                                    </div>
                                </div>
                                <h6 class="m-t-16">{$LANG.orderForm.billingAddress}</h6>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="inputCompanyName" class="control-label">{$LANG.orderForm.companyName} ({$LANG.orderForm.optional})</label>
                                            <input type="text" name="companyname" id="inputCompanyName" class="form-control" value="{$clientsdetails.companyname}"{if $loggedin} readonly="readonly"{/if}>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="inputAddress1" class="control-label">{$LANG.orderForm.streetAddress}</label>
                                             <input type="text" name="address1" id="inputAddress1" class="form-control" value="{$clientsdetails.address1}"{if $loggedin} readonly="readonly"{/if}>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="inputAddress2" class="control-label">{$LANG.orderForm.streetAddress2}</label>
                                            <input type="text" name="address2" id="inputAddress2" class="form-control" value="{$clientsdetails.address2}"{if $loggedin} readonly="readonly"{/if}>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="inputCity" class="control-label">{$LANG.orderForm.city}</label>
                                            <input type="text" name="city" id="inputCity" class="form-control" value="{$clientsdetails.city}"{if $loggedin} readonly="readonly"{/if}>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label for="inputState" class="control-label">{$LANG.orderForm.state}</label>
                                                    <input type="text" name="state" id="inputState" class="form-control" placeholder="{$LANG.orderForm.state}" value="{$clientsdetails.state}"{if $loggedin} readonly="readonly"{/if}>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label for="inputPostcode" class="control-label">{$LANG.orderForm.postcode}</label>
                                                    <input type="text" name="postcode" id="inputPostcode" class="form-control"  value="{$clientsdetails.postcode}"{if $loggedin} readonly="readonly"{/if}>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label" for="country">{$LANG.orderForm.country}</label>
                                             <select name="country" id="inputCountry" class="form-control"{if $loggedin} disabled="disabled"{/if}>
                                                {foreach $countries as $countrycode => $countrylabel}
                                                    <option value="{$countrycode}"{if (!$country && $countrycode == $defaultcountry) || $countrycode eq $country} selected{/if}>
                                                        {$countrylabel}
                                                    </option>
                                                {/foreach}
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                {if $customfields}
                                <h6 class="m-t-16">{$LANG.orderadditionalrequiredinfo}</h6>
                                    <div class="row">
                                        {foreach from=$customfields key=num item=customfield}
                                            <div class="col-sm-6">
                                                <div class="form-group"> 
                                                    {if $customfield.type eq 'tickbox'}            
                                                        <label class="checkbox" for="customfield{$customfield.id}">
                                                            {$customfield.input}
                                                            {$customfield.name}
                                                        </label>
                                                        {if $customfield.description}<span class="help-block">{$customfield.description}</span>{/if}
                                                    {else}
                                                        <label class="control-label" for="customfield{$customfield.id}">{$customfield.name}</label>
                                                        {if $customfield.type == "link"}
                                                        <div class="input-group">
                                                            {$customfield.input|replace:"<a":"<a class='input-group-addon'"|replace:"www":"<i class='ls ls-chain'></i>"}
                                                        </div>
                                                        {else}
                                                            {$customfield.input} 
                                                        {/if}
                                                        {if $customfield.description}<span class="help-block">{$customfield.description}</span>{/if}
                                                    {/if}
                                                </div>
                                            </div>
                                        {/foreach}
                                    </div>
                                {/if}
                                <div id="containerNewUserSecurity"{if $remote_auth_prelinked && !$securityquestions} class="hidden"{/if}>
                                    <h6 class="m-t-16">{$LANG.orderForm.accountSecurity}</h6>
                                    <div id="containerPassword" class="row{if $remote_auth_prelinked && $securityquestions} hidden{/if}">
                                        <div id="passwdFeedback" style="display:none;" class="alert alert-info text-center col-sm-12"></div>
                                        <div class="col-sm-6">
                                            <div class="form-group ">
                                                <label for="inputNewPassword1" >
                                                    {$LANG.clientareapassword}
                                                </label>
                                                <div class="input-password-strenght">
                                                    <input type="password" name="password" id="inputNewPassword1" data-error-threshold="{$pwStrengthErrorThreshold}" data-warning-threshold="{$pwStrengthWarningThreshold}" class="form-control"  autocomplete="off"{if $remote_auth_prelinked} value="{$password}"{/if}>
                                                    <span class="text-small text-lighter"><span id="passwordStrengthTextLabel">{$rslang->trans('login.at_least_pass')}</span><i data-toggle="tooltip" title="{$LANG.passwordtips}" data-html="true" data-container="body" class="ls ls-info-circle"></i></span>
                                                </div> 
                        						{include file="$template/includes/pwstrength.tpl"}
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="form-group ">
                                                <label for="inputNewPassword2" >
                                                    {$LANG.clientareaconfirmpassword}
                                                </label>
                                                <input type="password" name="password2" id="inputNewPassword2" class="form-control"  autocomplete="off"{if $remote_auth_prelinked} value="{$password}"{/if}>
                                            </div>
                                        </div>     
                                    </div>
                                    {if $securityquestions}
                                        <div class="row">
                                            <div class="form-group col-sm-6">
                                                <label for="inputSecurityQId">
                                                    {$rslang->trans('login.security_question')}
                                                </label>
                                                <select name="securityqid" id="inputSecurityQId" class="form-control">
                                                    <option value="">{$LANG.clientareasecurityquestion}</option>
                                                    {foreach $securityquestions as $question}
                                                        <option value="{$question.id}"{if $question.id eq $securityqid} selected{/if}>
                                                            {$question.question}
                                                        </option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group ">
                                                    <label for="inputSecurityQAns" >
                                                        {$LANG.clientareasecurityanswer}
                                                    </label>
                                                    <input type="password" name="securityqans" id="inputSecurityQAns" class="form-control"  autocomplete="off">
                                                </div>
                                            </div>
                                        </div>
                                    {/if}
                                </div>
                                {include file="orderforms/$carttpl/linkedaccounts.tpl" linkContext="checkout-new"}
                            </div>
                        </div>
                    </div>        
                </div>
            {/if}
        </div>
    </div>
    {if $domainsinorder}
        <div class="section">
            <div class="section-header">
                <h3>{$LANG.domainregistrantinfo}</h3>
            </div>
            <div class="section-body">
                <div class="panel panel-default panel-form m-b-0">
                    <div class="panel-body">
                        <div class="section">
                            <p>{$LANG.orderForm.domainAlternativeContact}</p>
                            <select name="contact" id="inputDomainContact" class="form-control {if $contact eq "addingnew"}m-b-40{/if}">
                                <option value="">{$LANG.usedefaultcontact}</option>
                                {foreach $domaincontacts as $domcontact}
                                    <option value="{$domcontact.id}"{if $contact == $domcontact.id} selected{/if}>
                                        {$domcontact.name}
                                    </option>
                                {/foreach}
                                <option value="addingnew"{if $contact == "addingnew"} selected{/if}>
                                    {$LANG.clientareanavaddcontact}...
                                </option>
                            </select>
                        </div>    
                        <div class="section {if $contact neq "addingnew"} hidden{/if}" id="domainRegistrantInputFields">
                            <h6>{$LANG.orderForm.personalInformation}</h6>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="inputDCFirstName" class="control-label">
                                        {$LANG.orderForm.firstName}
                                        </label>
                                        <input type="text" name="domaincontactfirstname" id="inputDCFirstName" class="form-control"  value="{$domaincontact.firstname}">
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="inputDCLastName" class="control-label">
                                            {$LANG.orderForm.lastName}
                                        </label>
                                        <input type="text" name="domaincontactlastname" id="inputDCLastName" class="form-control"  value="{$domaincontact.lastname}">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="inputDCEmail" class="control-label">
                                            {$LANG.orderForm.emailAddress}
                                        </label>
                                        <input type="email" name="domaincontactemail" id="inputDCEmail" class="form-control"  value="{$domaincontact.email}">
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="inputDCPhone" class="control-label">
                                            {$LANG.orderForm.phoneNumber}
                                        </label>
                                        <input type="tel" name="domaincontactphonenumber" id="inputDCPhone" class="form-control"  value="{$domaincontact.phonenumber}">
                                    </div>
                                </div>
                            </div>
                            <h6 class="m-t-16">{$LANG.orderForm.billingAddress}</h6>
                            <div class="row">
                                 <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="inputDCCompanyName" class="control-label">
                                            {$LANG.orderForm.companyName} ({$LANG.orderForm.optional})
                                        </label>
                                        <input type="text" name="domaincontactcompanyname" id="inputDCCompanyName" class="form-control"  value="{$domaincontact.companyname}">
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="inputDCAddress1" class="control-label">
                                            {$LANG.orderForm.streetAddress}
                                        </label>
                                        <input type="text" name="domaincontactaddress1" id="inputDCAddress1" class="form-control"  value="{$domaincontact.address1}">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="inputDCAddress2" class="control-label">
                                            {$LANG.orderForm.streetAddress2}
                                        </label>
                                        <input type="text" name="domaincontactaddress2" id="inputDCAddress2" class="form-control"  value="{$domaincontact.address2}">
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="inputDCCity" class="control-label">
                                            {$LANG.orderForm.city}
                                        </label>
                                        <input type="text" name="domaincontactcity" id="inputDCCity" class="form-control"  value="{$domaincontact.city}">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label for="inputDCState" class="control-label">
                                                    {$LANG.orderForm.state}
                                                </label>
                                                <input type="text" name="domaincontactstate" id="inputDCState" class="form-control"  value="{$domaincontact.state}">
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label for="inputDCPostcode" class="control-label">
                                                    {$LANG.orderForm.postcode}
                                                </label>
                                                <input type="text" name="domaincontactpostcode" id="inputDCPostcode" class="form-control"  value="{$domaincontact.postcode}">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="inputDCPostcode" class="control-label">{$LANG.orderForm.country}</label>
                                        <select name="domaincontactcountry" id="inputDCCountry" class="form-control">
                                            {foreach $countries as $countrycode => $countrylabel}
                                                <option value="{$countrycode}"{if (!$domaincontact.country && $countrycode == $defaultcountry) || $countrycode eq $domaincontact.country} selected{/if}>
                                                    {$countrylabel}
                                                </option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>    
            </div>
        </div>  
    {/if}
    <div class="section">
        <h3>{$LANG.orderForm.paymentDetails}</h3>
        
        {if $canUseCreditOnCheckout}
        <div class="panel panel-default">
            <div class="panel-body"> 
                <p class="credit-balance-title">{lang key='cart.availableCreditBalance'}</p>
                <div class="panel panel-info">
                    <div class="panel-body bg-info">
                        <div class="credit-balance">{$creditBalance}</div>
                    </div>
                </div>
                <div id="applyCreditContainer" class="apply-credit-container radio-content" data-apply-credit="{$applyCredit}">
                    <div class="form-group">
                        {if $creditBalance->toNumeric() >= $total->toNumeric()}
                            <div class="radio">
                                <label>
                                    <input id="useFullCreditOnCheckout" type="radio" name="applycredit" value="1"{if $applyCredit} checked{/if}>
                                    <span>{lang key='cart.applyCreditAmountNoFurtherPayment' amount=$total}
                                </label>
                            </div>
                        {else}                    
                            <div class="radio">
                                <label>
                                    <input id="useCreditOnCheckout" type="radio" name="applycredit" value="1"{if $applyCredit} checked{/if}>
                                     <span>{lang key='cart.applyCreditAmount' amount=$creditBalance}</span>
                                </label>
                            </div>
                        {/if}
                    </div>
                    <div class="form-group m-b-0">
                        <div class="radio">
                            <label>
                                <input id="skipCreditOnCheckout" type="radio" name="applycredit" value="0"{if !$applyCredit} checked{/if}>
                                <span>{lang key='cart.applyCreditSkip' amount=$creditBalance}</span>
                            </label>
                        </div>
                    </div>
                </div>            
            </div>
        </div>           
        {/if}        
        <div class="panel-group panel-group-condensed m-b-0" id="paymentGatewaysContainer" data-inputs-container>
            {foreach key=num item=gateway from=$gateways}
                <div class="panel panel-default {if $selectedgateway eq $gateway.sysname}checked{/if}" data-virtual-input>
                    <div class="panel-heading check">
                        <label>
                            <input type="radio" name="paymentmethod" value="{$gateway.sysname}" class="payment-methods{if $gateway.type eq "CC"} is-credit-card{/if}"{if $selectedgateway eq $gateway.sysname} checked{/if} />
                            <div class="check-content">
                                 <span>{$gateway.name}</span>
                            </div>
                            <span class="check-icon">
                                {assign var=gatewayIcon value=$gateway.name|lower|replace:" ":"-"}
                                {if file_exists("templates/$template/core/styles/{$RSThemes.styles.name}/assets/svg-icon/gateway-$gatewayIcon.tpl")}
                                     {include file="$template/core/styles/{$RSThemes.styles.name}/assets/svg-icon/gateway-$gatewayIcon.tpl"}
                                {/if}
                            </span>
                        </label>
                        
                    </div>                   
                    {if $gateway.type eq "CC"}
                        <div class="panel-collapse collapse {if $selectedgateway eq $gateway.sysname}in{/if}" data-input-collapse role="tabpanel" >
                            <div class="alert alert-danger text-center gateway-errors hidden"></div>
                            <div id="creditCardInputFields">
                                {if $clientsdetails.cclastfour}
                                    <ul class="nav nav-tabs">
                                        <li class="active">
                                            <a href="#existingCardInfo" data-toggle="tab" aria-expanded="true">
                                                <input type="radio" name="ccinfo" class="hidden icheck-input" value="useexisting" id="useexisting" {if $clientsdetails.cclastfour} checked{else} disabled{/if} />
                                                {$LANG.creditcarduseexisting}
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#newCardInfoTab" data-toggle="tab" aria-expanded="true">
                                                <input type="radio" name="ccinfo" class="hidden icheck-input"  value="new" id="new" {if !$clientsdetails.cclastfour || $ccinfo eq "new"} checked{/if} />
                                                {$LANG.creditcardenternewcard}
                                            </a>
                                        </li>
                                    </ul>
                                {else}
                                    <input type="hidden" name="ccinfo" value="new" />
                                {/if}
                                <div class="panel-body">
                                    {if $clientsdetails.cclastfour}
                                        <div class="tab-content">
                                            <div id="existingCardInfo" class="tab-pane {if $clientsdetails.cclastfour || $ccinfo eq "new"}active{/if}">
                                                <div class="row">
                                                    <div class="col-sm-4">
                                                        <div class="form-group">
                                                            <label for="inputCardCvvExisting" class="control-label">{$LANG.creditcardcvvnumber}</label>
                                                            <div class="form-tooltip">
                                                                <input type="tel" name="cccvvexisting" id="inputCardCvvExisting" class="form-control" autocomplete="cc-cvc">
                                                                <i class="ls ls-info-circle tooltip-icon"data-cc-popover-show></i>
                                                                <div data-cc-popover class="popover top"> 
                                                                    <div class="arrow"></div>                                            
                                                                    <div class="popover-content"> 
                                                                        <img src='{$BASE_PATH_IMG}/ccv.gif' width='180' />
                                                                    </div> 
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div id="newCardInfoTab" class="tab-pane {if $clientsdetails.cclastfour && $ccinfo eq "exsisting"}active{/if}">
                                    {/if}
                                                <div id="newCardInfo" class="row">
                                                    <div class="col-sm-6">
                                                        <div class="form-group">
                                                            <label class="control-label">{$LANG.creditcardcardtype}</label>
                                                            <div id="cardType">
                                                                <select class="form-control" id="cctype" name="cctype">
                                                                    {foreach $acceptedcctypes as $cardType}
                                                                        <option>{$cardType}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <div class="form-group">
                                                            <label class="control-label">{$LANG.creditcardcardnumber}</label>
                                                            <input type="tel" name="ccnumber" id="inputCardNumber" class="form-control" placeholder="{$LANG.orderForm.cardNumber}" autocomplete="cc-number">
                                                        </div>
                                                    </div>
                                                </div>
                                                {if $showccissuestart}
                                                    <div class="row">
                                                          <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <label for="inputCardStart" class="control-label">
                                                                    {$LANG.creditcardcardstart}
                                                                </label>
                                                                <input type="tel" name="ccstartdate" id="inputCardStart" class="form-control" placeholder="MM / YY ({$LANG.creditcardcardstart})" autocomplete="cc-exp">
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <label for="inputCardIssue" class="control-label">
                                                                    {$LANG.creditcardcardissuenum}
                                                                </label>
                                                                <input type="tel" name="ccissuenum" id="inputCardIssue" class="form-control" placeholder="{$LANG.creditcardcardissuenum}">
                                                            </div>
                                                        </div>
                                                    </div>    
                                                {/if}
                                                <div class="row">
                                                    <div class="col-sm-6">
                                                        <div class="form-group">
                                                            <label for="inputCardExpiry" class="control-label">
                                                                {$LANG.creditcardcardexpires}
                                                            </label>
                                                            <input type="tel" name="ccexpirydate" id="inputCardExpiry" class="form-control" placeholder="MM / YY{if $showccissuestart} ({$LANG.creditcardcardexpires}){/if}" autocomplete="cc-exp">
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <div class="form-group">
                                                            <label for="inputCardCVV" class="control-label">
                                                                {$LANG.creditcardcvvnumber}
                                                            </label>
                                                            <div class="form-tooltip">
                                                                <input type="tel" name="cccvv" id="inputCardCVV" class="form-control" autocomplete="cc-cvc">
                                                                <i class="ls ls-info-circle tooltip-icon" data-cc-popover-show></i>
                                                                <div data-cc-popover class="popover top"> 
                                                                    <div class="arrow"></div>                                            
                                                                    <div class="popover-content"> 
                                                                        <img src='{$BASE_PATH_IMG}/ccv.gif' width='180' />
                                                                    </div> 
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                    {if $clientsdetails.cclastfour}
                                            </div>
                                        </div>
                                    {/if}
                                </div>    
                            </div>
                        </div>
                    {/if}
                </div>
            {/foreach}
        </div>
    </div>
    {if $showMarketingEmailOptIn}
        <div class="section">
            <h3>{lang key='emailMarketing.joinOurMailingList'}</h3>
            <p>{$marketingEmailOptInMessage}</p>
            <div class="panel panel-switch m-w-288{if $marketingEmailOptIn} checked{/if}">
                <div class="panel-body">
                    <span class="switch-label">{$rslang->trans('generals.receive_emails')}</span>
                    <label class="switch switch--lg switch--text" submit-form>
                        <input class="switch__checkbox" type="checkbox" name="marketingoptin" value="1"{if $marketingEmailOptIn} checked{/if}>
                        <span class="switch__container"><span class="switch__handle"></span></span>
                    </label> 
                </div>
            </div>
        </div>
    {/if}
    {if $shownotesfield}
        <div class="section">
            <h3>{$LANG.orderForm.additionalNotes}</h3>
            <textarea name="notes" class="form-control" rows="4" placeholder="{$LANG.ordernotesdescription}">{$orderNotes}</textarea>
        </div>
    {/if}
    {if $accepttos}      
        <div class="section">
            <div class="checkbox">
                <label>
                    <input type="checkbox" name="accepttos" id="accepttos" />
                    <span>{$LANG.ordertosagreement} <a href="{$tosurl}" target="_blank">{$LANG.ordertos}</a></span>
                </label>
            </div>         
        </div>          
    {/if}
    {if $servedOverSsl}
    <div class="section">
        <div class="alert alert-warning checkout-security-msg">
            <div class="alert-body">
                <i class="ls ls-lock"></i>
                {$LANG.ordersecure} (<strong>{$ipaddress}</strong>) {$LANG.ordersecure2}
            </div>
        </div>
	</div> 

    {/if}
    <button type="submit" id="submit-checkout" class="hidden btn btn-primary btn-lg"{if $cartitems==0} disabled="disabled"{/if} onclick="this.value='{$LANG.pleasewait}'">
        {$LANG.completeorder}
    </button>
</form>
<script type="text/javascript" src="{$BASE_PATH_JS}/jquery.payment.js"></script>
