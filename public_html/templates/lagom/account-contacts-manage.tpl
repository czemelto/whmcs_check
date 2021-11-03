{if isset($RSThemes['pages']['account-contacts-manage'])}
    {include file=$RSThemes['pages']['account-contacts-manage']['fullPath']}
{else} 
    {include file="$template/includes/flashmessage.tpl"}
    {if $errorMessageHtml}
        {include file="$template/includes/alert.tpl" type="error" errorshtml=$errorMessageHtml}
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
                                    <option value="{$contact.id}"{if $contact.id eq $contactid} selected="selected"{/if}>{$contact.name} - {$contact.email}</option>
                                {/foreach}
                                <option value="new">{$LANG.clientareanavaddcontact}</option>
                            </select>
                        </div>
                    </div>
                </form>
                </div>
            </div>
        </div> 
    </div>  
    <div class="section">
        <form role="form" method="post" action="{routePath('account-contacts-save')}">
            <input type="hidden" name="contactid" value="{$contactid}" />
            <input type="hidden" name="contact_manage_from_form" value="1" />
            <div class="section">
                <div class="section-header">
                    <h3>{$rslang->trans('generals.contact_details')}</h3>
                </div>
                <div class="section-body">
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
                                        <input type="text" name="firstname" id="inputFirstName" value="{$formdata.firstname}" class="form-control" readonly="readonly"/>
                                    </div>
                                </div>    
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="inputLastName" class="control-label">{$LANG.clientarealastname}</label>
                                        <input type="text" name="lastname" id="inputLastName" value="{$formdata.lastname}" class="form-control" readonly="readonly"/>
                                    </div>
                                </div>     
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="inputEmail" class="control-label">{$LANG.clientareaemail}</label>
                                        <input type="email" name="email" id="inputEmail" value="{$formdata.email}" class="form-control" readonly="readonly"/>
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
                                        <input type="text" name="tax_id" id="domaincontact_szig" class="form-control" value="{$formdata.tax_id}" disabled>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="inputDCTaxId">
                                            {lang key=\WHMCS\Billing\Tax\Vat::getLabel()} ({$LANG.orderForm.optional})
                                        </label>
                                        <input type="text" name="tax_id" id="inputDCTaxId" class="form-control" placeholder="{lang key=\WHMCS\Billing\Tax\Vat::getLabel()} ({$LANG.orderForm.optional})" value="{$formdata.tax_id}" disabled>
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
            <div class="form-actions">
                <input class="btn btn-primary" type="submit" name="save" value="{$LANG.clientareasavechanges}" />
                <input class="btn btn-default m-r-a" type="reset" value="{$LANG.cancel}" />
                <button type="button" class="btn btn-default" data-toggle="modal" data-target="#modalDeleteContact">{lang key='clientareadeletecontact'}</button>
            </div>

            <input type="hidden" name="tax_id" value="{$formdata.tax_id}">

        </form>
    </div>
{/if}

<form method="post" action="{routePath('account-contacts-delete')}">
    <input type="hidden" name="contactid" value="{$contactid}">
    <div class="modal fade" id="modalDeleteContact">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><i class="lm lm-close"></i></button>
                    <h3 class="modal-title">
                        {lang key="clientareadeletecontact"}
                    </h3>
                </div>
                <div class="modal-body">
                    <p>{lang key="clientareadeletecontactareyousure"}</p>
                </div>
                <div class="modal-footer">                    
                    <button type="submit" class="btn btn-primary" id="btnCancelInviteConfirm">
                        {lang key="confirm"}
                    </button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        {lang key="cancel"}
                    </button>
                </div>
            </div>
        </div>
    </div>
</form>
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