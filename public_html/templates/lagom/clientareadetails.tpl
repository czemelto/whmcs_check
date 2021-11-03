{if isset($RSThemes.pages.clientareadetails)}
    {include file=$RSThemes['pages']['clientareadetails']['fullPath']}
{else}  	
    {if $successful}
        {include file="$template/includes/alert.tpl" type="success" msg=$LANG.changessavedsuccessfully}
    {/if}

    {if $errormessage}
        {include file="$template/includes/alert.tpl" type="error" errorshtml=$errormessage}
    {/if}

    <script type="text/javascript" src="{$BASE_PATH_JS}/StatesDropdown.js"></script>

    <style>
        .domaincontact-panel-account-type {
            display: flex;
        }
        .account-type-label {
            position: relative;
        }
    </style>

    <form method="post" action="?action=details" role="form">
        <h3>{$LANG.orderForm.personalInformation}</h3>
        <div class="panel panel-default panel-form">
            <div class="panel-body">
                <div class="panel-default check domaincontact-panel-account-type">
                    <label class="account-type-label">
                        <input type="radio" class="icheck-control" name="domaincontact_account_type" value="personal" {if $formdata.companyname eq ""} checked="checked"{/if} disabled/>
                        <div class="check-content">
                            <span>Magánszemély</span>
                        </div>
                    </label>
                    <label class="account-type-label">
                        <input type="radio" class="icheck-control" name="domaincontact_account_type" value="company" {if $formdata.companyname} checked="checked"{/if} disabled/>
                        <div class="check-content">
                            <span>Vállalkozás</span>
                        </div>
                    </label>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label for="inputFirstName" class="control-label">{$LANG.clientareafirstname}</label>
                            <input type="text" name="firstname" id="inputFirstName" value="{$clientfirstname}"{if in_array('firstname', $uneditablefields)} disabled="disabled"{/if} class="form-control" />
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label for="inputLastName" class="control-label">{$LANG.clientarealastname}</label>
                            <input type="text" name="lastname" id="inputLastName" value="{$clientlastname}"{if in_array('lastname', $uneditablefields)} disabled="disabled"{/if} class="form-control" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label for="inputEmail" class="control-label">{$LANG.clientareaemail}</label>
                            <input type="email" name="email" id="inputEmail" value="{$clientemail}"{if in_array('email', $uneditablefields)} disabled="disabled"{/if} class="form-control" />
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label for="inputPhone" class="control-label">{$LANG.clientareaphonenumber}</label>
                            <input type="tel" name="phonenumber" id="inputPhone" value="{$clientphonenumber}"{if in_array('phonenumber',$uneditablefields)} disabled=""{/if} class="form-control" />
                        </div>
                    </div>
                    <div class="col-sm-6 domaincontact-szig">
                        <div class="form-group">
                            <label for="domaincontact_szig" class="control-label">Személyi igazolvány szám</label>
                            <input type="text" name="szigszam" id="domaincontact_szig" class="form-control" value="{($customfields[0]['value'])}" disabled>
                            <input type="hidden" name="customfield[1]" class="form-control" value="{($customfields[0]['value'])}">

                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label for="inputDCTaxId">
                                {lang key=\WHMCS\Billing\Tax\Vat::getLabel()} ({$LANG.orderForm.optional})
                            </label>
                            <input type="text" name="adoszam" id="inputDCTaxId" class="form-control" placeholder="{lang key=\WHMCS\Billing\Tax\Vat::getLabel()} ({$LANG.orderForm.optional})" value="{$customfields[1]['value']}" disabled>
                            <input type="hidden" name="customfield[2]" id="inputDCTaxId" class="form-control" value="{$customfields[1]['value']}">
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label for="inputCompanyName" class="control-label">{$LANG.clientareacompanyname}</label>
                            <input type="text" name="companyname" id="inputCompanyName" value="{$clientcompanyname}"{if in_array('companyname', $uneditablefields)} disabled="disabled"{/if} class="form-control" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <h3 class="m-t-16">{$LANG.orderForm.billingAddress}</h3>
        <div class="panel panel-default panel-form">
            <div class="panel-body">
                <div class="row">
                    {if $showTaxIdField}
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label for="inputTaxId" class="control-label">{lang key=$taxIdLabel}</label>
                                <input type="text" name="tax_id" id="inputTaxId" class="form-control" value="{$clientTaxId}"{if in_array('tax_id', $uneditablefields)} disabled="disabled"{/if} />
                            </div>
                        </div>
                    {/if}

                    <div class="col-sm-6">
                        <div class="form-group">
                            <label for="inputAddress1" class="control-label">{$LANG.clientareaaddress1}</label>
                            <input type="text" name="address1" id="inputAddress1" value="{$clientaddress1}"{if in_array('address1', $uneditablefields)} disabled="disabled"{/if} class="form-control" />
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label for="inputAddress2" class="control-label">{$LANG.clientareaaddress2}</label>
                            <input type="text" name="address2" id="inputAddress2" value="{$clientaddress2}"{if in_array('address2', $uneditablefields)} disabled="disabled"{/if} class="form-control" />
                        </div>
                    </div>

                    <div class="col-sm-6">
                        <div class="form-group">
                            <label for="inputCity" class="control-label">{$LANG.clientareacity}</label>
                            <input type="text" name="city" id="inputCity" value="{$clientcity}"{if in_array('city', $uneditablefields)} disabled="disabled"{/if} class="form-control" />
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label for="inputState" class="control-label">{$LANG.clientareastate}</label>
                                    <input type="text" name="state" id="inputState" value="{$clientstate}"{if in_array('state', $uneditablefields)} disabled="disabled"{/if} class="form-control" />
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label for="inputPostcode" class="control-label">{$LANG.clientareapostcode}</label>
                                    <input type="text" name="postcode" id="inputPostcode" value="{$clientpostcode}"{if in_array('postcode', $uneditablefields)} disabled="disabled"{/if} class="form-control" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="control-label" for="country">{$LANG.clientareacountry}</label>
                            {$clientcountriesdropdown}
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label for="inputPaymentMethod" class="control-label">{$LANG.paymentmethod}</label>
                            <select name="paymentmethod" id="inputPaymentMethod" class="form-control">
                                <option value="none">{$LANG.paymentmethoddefault}</option>
                                {foreach from=$paymentmethods item=method}
                                    <option value="{$method.sysname}"{if $method.sysname eq $defaultpaymentmethod} selected="selected"{/if}>{$method.name}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>

                    <div class="col-sm-6">
                        <div class="form-group">
                            <label for="inputBillingContact" class="control-label">{$LANG.defaultbillingcontact}</label>
                            <select name="billingcid" id="inputBillingContact" class="form-control">
                                <option value="0">{$LANG.usedefaultcontact}</option>
                                {foreach from=$contacts item=contact}
                                    <option value="{$contact.id}"{if $contact.id eq $billingcid} selected="selected"{/if}>{$contact.name}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>					
                </div>
            </div>
        </div>
        {*
        {if $customfields}
            <h3 class="m-t-16">{$LANG.additionalInfo}</h3>
            <div class="panel panel-default panel-form">
                <div class="panel-body">
                    <div class="row">
                        {foreach from=$customfields key=num item=customfield}
                            <div class="col-sm-6">
                                <div class="form-group"> 
                                    {if $customfield.type eq 'tickbox'}            
                                        <label class="checkbox" for="customfield{$customfield.id}">
                                            {$customfield.input|replace:'type="checkbox"':'class="form-checkbox icheck-control" type="checkbox"'}
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
                </div>    
            </div>
        {/if}
        *}

        {if $emailPreferencesEnabled}
             <div class="section">
                <div class="section-header">
                    <h3>{$LANG.clientareacontactsemails}</h3>
                </div>
                <div class="section-body">
                    <div class="panel panel-default panel-form">
                        <div class="panel-body">    
                            {foreach $emailPreferences as $emailType => $value}
                                <div class="checkbox">
                                    <label>
                                        <input type="hidden" name="email_preferences[{$emailType}]" value="0">
                                        <input class="icheck-control" type="checkbox" name="email_preferences[{$emailType}]" id="{$emailType}Emails" value="1"{if $value} checked="checked"{/if} />
                                        {lang key="emailPreferences."|cat:$emailType}
                                    </label>
                                </div>    
                            {/foreach}
                        </div>
                    </div>        
                </div>            
            </div>
        {/if}


        {if $showMarketingEmailOptIn}
            <h3 class="m-t-16">{lang key='emailMarketing.joinOurMailingList'}</h3>
            <div class="panel panel-default panel-form">
                <div class="panel-body">
                    <p>{$marketingEmailOptInMessage}</p>
                    <div class="panel panel-switch m-w-288 m-b-0">
                        <div class="panel-body">
                            <span class="switch-label">{$rslang->trans('generals.receive_emails')}: </span>
                            <label class="switch switch--lg switch--text">
                                <input class="switch__checkbox" type="checkbox" name="marketingoptin" value="1"{if $marketingEmailOptIn} checked{/if}>
                                <span class="switch__container"><span class="switch__handle"></span></span>
                            </label> 
                        </div>
                    </div>
                </div>
            </div>
        {/if}
        <div class="form-actions">
            <input class="btn btn-primary" type="submit" name="save" value="{$LANG.clientareasavechanges}" />
            <input class="btn btn-default" type="reset" value="{$LANG.clientareacancel}" />
        </div>
    </form>
{/if}

<script>
    jQuery(document).ready(function($){
        setTimeout(function(){

            if( $("input[name=custtype]:checked").val() == "existing" ) {
                $(".panel-account-type").hide();
            } else {
                $(".panel-account-type").show();
            }

            $(".panel-group-condensed").on("hidden.bs.collapse", function() {
                if( $("input[name=custtype]:checked").val() == "existing" ) {
                    $(".panel-account-type").hide();
                } else {
                    $(".panel-account-type").show();
                }
            });

            hideDomainContactFields( $(".domaincontact-panel-account-type input[name=domaincontact_account_type]:checked").val() );

            $('.domaincontact-panel-account-type .account-type-label').on("click", function(){
                setTimeout(function(){
                    hideDomainContactFields( $("input[name=domaincontact_account_type]:checked").val() );
                },200);
            });

            $('.domaincontact-panel-account-type .radio-styled .iCheck-helper').on("click", function(){
                setTimeout(function(){
                    hideDomainContactFields( $("input[name=domaincontact_account_type]:checked").val() );
                },200);
            });

            function hideDomainContactFields( inputVal ){
                if( inputVal == 'personal' ) {
                    $("#inputCompanyName").parent().closest('.col-sm-6').hide();
                    $("#inputCompanyName").prop('disabled', 'disabled');
                    $("#inputDCTaxId").parent().closest('.col-sm-6').hide();
                    $("#inputDCTaxId").prop('disabled', 'disabled');
                    $(".domaincontact-szig").show();
                }

                if( inputVal == 'company' ) {
                    $("#inputCompanyName").parent().closest('.col-sm-6').show();
                    $("#inputCompanyName").prop('disabled', '');
                    $("#inputDCTaxId").parent().closest('.col-sm-6').show();
                    $(".domaincontact-szig").hide();
                    $(".domaincontact-szig input").prop('disabled', 'disabled');
                }
            }

        },500);
    });
</script>