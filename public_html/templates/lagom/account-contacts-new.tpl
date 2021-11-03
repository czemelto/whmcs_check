{if isset($RSThemes['pages']['account-contacts-new'])}
    {include file=$RSThemes['pages']['account-contacts-new']['fullPath']}
{else}
    {if $errorMessageHtml}
        {include file="$template/includes/alert.tpl" type="error" errorshtml=$errorMessageHtml}
    {/if}
    <script>
        var stateNotRequired = true;
        jQuery(document).ready(function() {
            WHMCS.form.register();
        });
    </script>
    <script src="{$BASE_PATH_JS}/StatesDropdown.js"></script>
    <style>
        .domaincontact-panel-account-type {
            display: flex;
        }
        .account-type-label {
            position: relative;
        }
    </style>
    <div class="section">
        <div class="section-header">
            <h3>{$LANG.clientareachoosecontact}</h3>
        </div>    
        <div class="section-body">
            <div class="panel panel-default panel-form">
                <div class="panel-body">
                <form class="form-horizontal" role="form" method="post" action="{routePath('account-contacts')}">
                    <div class="row">
                        <div class="col-sm-6">
                            <select name="contactid" id="inputContactId" onchange="submit()" class="form-control">
                                {foreach item=contact from=$contacts}
                                    <option value="{$contact.id}">{$contact.name} - {$contact.email}</option>
                                {/foreach}
                                <option value="new" selected="selected">{$LANG.clientareanavaddcontact}</option>
                            </select>
                        </div>
                    </div>
                </form>
                </div>
            </div>
        </div> 
    </div>
    <div class="section">
        <form role="form" method="post" action="{routePath('account-contacts-new')}">
            <div class="section">
                <div class="section-header">
                    <h3>{$rslang->trans('generals.contact_details')}</h3>
                </div>
                <div class="section-body">
                    <div class="panel panel-default panel-form">
                        <div class="panel-body">

                            <div class="panel-default check domaincontact-panel-account-type">
                                <label class="account-type-label">
                                    <input type="radio" class="icheck-control" name="domaincontact_account_type" value="personal" checked />
                                    <div class="check-content">
                                        <span>Magánszemély</span>
                                    </div>
                                </label>
                                <label class="account-type-label">
                                    <input type="radio" class="icheck-control" name="domaincontact_account_type" value="company" />
                                    <div class="check-content">
                                        <span>Vállalkozás</span>
                                    </div>
                                </label>
                            </div>

                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="inputFirstName" class="control-label">{$LANG.clientareafirstname}</label>
                                        <input type="text" name="firstname" id="inputFirstName" value="{$formdata.firstname}" class="form-control" />
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="inputLastName" class="control-label">{$LANG.clientarealastname}</label>
                                        <input type="text" name="lastname" id="inputLastName" value="{$formdata.lastname}" class="form-control" />
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="inputEmail" class="control-label">{$LANG.clientareaemail}</label>
                                        <input type="email" name="email" id="inputEmail" value="{$formdata.email}" class="form-control" />
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="inputPhone" class="control-label">{$LANG.clientareaphonenumber}</label>
                                        <input type="tel" name="phonenumber" id="inputPhone" value="{$formdata.phonenumber}" class="form-control" />
                                    </div>
                                </div>
                                <div class="col-sm-6 domaincontact-szig">
                                    <div class="form-group">
                                        <label for="domaincontact_szig" class="control-label">Személyi igazolvány szám</label>
                                        <input type="text" name="tax_id" id="domaincontact_szig" class="form-control" value="{$formdata.tax_id}">
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="inputDCTaxId">
                                            {lang key=\WHMCS\Billing\Tax\Vat::getLabel()} ({$LANG.orderForm.optional})
                                        </label>
                                        <input type="text" name="tax_id" id="inputDCTaxId" class="form-control" placeholder="{lang key=\WHMCS\Billing\Tax\Vat::getLabel()} ({$LANG.orderForm.optional})" value="{$formdata.tax_id}">
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="inputCompanyName" class="control-label">{$LANG.clientareacompanyname}</label>
                                        <input type="text" name="companyname" id="inputCompanyName" value="{$formdata.companyname}" class="form-control" />
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="inputAddress1" class="control-label">{$LANG.clientareaaddress1}</label>
                                        <input type="text" name="address1" id="inputAddress1" value="{$formdata.address1}" class="form-control" />
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="inputAddress2" class="control-label">{$LANG.clientareaaddress2}</label>
                                        <input type="text" name="address2" id="inputAddress2" value="{$formdata.address2}" class="form-control" />
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="inputCity" class="control-label">{$LANG.clientareacity}</label>
                                        <input type="text" name="city" id="inputCity" value="{$formdata.city}" class="form-control" />
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label for="inputState" class="control-label">{$LANG.clientareastate}</label>
                                                <input type="text" name="state" id="inputState" value="{$formdata.state}" class="form-control" />
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label for="inputPostcode" class="control-label">{$LANG.clientareapostcode}</label>
                                                <input type="text" name="postcode" id="inputPostcode" value="{$formdata.postcode}" class="form-control" />
                                            </div>
                                        </div>
                                    </div>
                                </div>        
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="control-label" for="country">{$LANG.clientareacountry}</label>
                                        {$countriesdropdown}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>   
                <div class="section">
                    <div class="section-header">
                        <h3>{$LANG.clientareacontactsemails}</h3>
                    </div>
                    <div class="section-body">
                        <div class="panel panel-default panel-form">
                            <div class="panel-body">
                                 {foreach $formdata.emailPreferences as $emailType => $value}
                                    <div class="checkbox">
                                        <label>
                                            <input type="hidden" name="email_preferences[{$emailType}]" value="0">
                                            <input class="icheck-control" type="checkbox" name="email_preferences[{$emailType}]" id="{$emailType}emails" value="1"{if $value} checked="checked"{/if} />
                                            {lang key="clientareacontactsemails"|cat:$emailType}
                                        </label>
                                    </div>    
                                {/foreach}
                            </div>
                        </div>
                    </div>        
                </div>    
            </div>    
            <div class="form-actions">
                <input class="btn btn-primary" type="submit" name="save" value="{$LANG.clientareasavechanges}" />
                <input class="btn btn-default" type="reset" value="{$LANG.cancel}" />
            </div>
        </form>
    </div>
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
					$(".domaincontact-szig input").prop('disabled', '');
				}
				
				if( inputVal == 'company' ) {
					$("#inputCompanyName").parent().closest('.col-sm-6').show();
					$("#inputCompanyName").prop('disabled', '');
					$("#inputDCTaxId").parent().closest('.col-sm-6').show();
					$("#inputDCTaxId").prop('disabled', '');
					$(".domaincontact-szig").hide();
					$(".domaincontact-szig input").prop('disabled', 'disabled');
				}
			}
		
		},500);
	});
</script>