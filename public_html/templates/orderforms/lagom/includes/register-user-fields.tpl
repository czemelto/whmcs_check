{if file_exists("templates/orderforms/$carttpl/includes/overwrites/register-user-fields.tpl")}
    {include file="templates/orderforms/$carttpl/includes/overwrites/register-user-fields.tpl"}
{else}
    {include file="orderforms/$carttpl/linkedaccounts.tpl" linkContext="checkout-new"}
    <h6>{$LANG.orderForm.personalInformation}</h6>
    <div class="row">
        <div class="col-sm-6">
            <div class="form-group">
                <label for="inputFirstName" class="control-label">{$LANG.orderForm.firstName}{if in_array('firstname', $clientsProfileOptionalFields)} ({$LANG.orderForm.optional}){/if}</label>
                <input type="text" name="firstname" maxlength="50" id="inputFirstName" class="form-control" value="{$clientsdetails.firstname}">
            </div>
        </div>
        <div class="col-sm-6">
            <div class="form-group">
                <label for="inputLastName" class="control-label">{$LANG.orderForm.lastName}{if in_array('lastname', $clientsProfileOptionalFields)} ({$LANG.orderForm.optional}){/if}</label>
                <input type="text" name="lastname" maxlength="100" id="inputLastName" class="form-control" value="{$clientsdetails.lastname}">
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-6">
            <div class="form-group">
                <label for="inputEmail" class="control-label">{$LANG.orderForm.emailAddress}</label>
                <input type="email" name="email" id="inputEmail" class="form-control" value="{$clientsdetails.email}">
            </div>
        </div>
        <div class="col-sm-6">
            <div class="form-group">
                <label for="inputPhone" class="control-label">{$LANG.orderForm.phoneNumber}{if in_array('phonenumber', $clientsProfileOptionalFields)} ({$LANG.orderForm.optional}){/if}</label>
                <input type="tel" name="phonenumber" id="inputPhone" class="form-control" value="{$clientsdetails.phonenumber}">
            </div>
        </div>
    </div>
    <h6 class="m-t-16">{$LANG.orderForm.billingAddress}</h6>
    <div class="row">
        <div class="col-sm-6">
            <div class="form-group">
                <label for="inputCompanyName" class="control-label">{$LANG.orderForm.companyName} ({$LANG.orderForm.optional})</label>
                <input type="text" name="companyname" id="inputCompanyName" class="form-control" value="{$clientsdetails.companyname}">
            </div>
        </div>
        {if $showTaxIdField}
            <div class="col-sm-6">
                <div class="form-group">
                    <label for="inputTaxId">
                        {lang key=\WHMCS\Billing\Tax\Vat::getLabel()} ({$LANG.orderForm.optional})
                    </label>
                    <input type="text" name="tax_id" id="inputTaxId" class="form-control" placeholder="" value="{$clientsdetails.tax_id}">
                </div>
            </div>
        {/if}
        <div class="col-sm-6">
            <div class="form-group">
                <label for="inputAddress1" class="control-label">{$LANG.orderForm.streetAddress} {if in_array('address1', $clientsProfileOptionalFields)} ({$LANG.orderForm.optional}){/if} </label>
                <input type="text" name="address1" id="inputAddress1" class="form-control" value="{$clientsdetails.address1}">
            </div>
        </div>
    
        <div class="col-sm-6">
            <div class="form-group">
                <label for="inputAddress2" class="control-label">{$LANG.orderForm.streetAddress2}</label>
                <input type="text" name="address2" id="inputAddress2" class="form-control" value="{$clientsdetails.address2}">
            </div>
        </div>
        <div class="col-sm-6">
            <div class="form-group">
                <label for="inputCity" class="control-label">{$LANG.orderForm.city} {if in_array('city', $clientsProfileOptionalFields)} ({$LANG.orderForm.optional}){/if} </label>
                <input type="text" name="city" id="inputCity" class="form-control" value="{$clientsdetails.city}">
            </div>
        </div>
    
        <div class="col-sm-6">
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label for="inputState" class="control-label">{$LANG.orderForm.state}{if in_array('state', $clientsProfileOptionalFields)} ({$LANG.orderForm.optional}){/if}</label>
                        <input type="text" name="state" id="inputState" class="form-control" placeholder="{$LANG.orderForm.state}" value="{$clientsdetails.state}">
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label for="inputPostcode" class="control-label">{$LANG.orderForm.postcode}{if in_array('postcode', $clientsProfileOptionalFields)} ({$LANG.orderForm.optional}){/if}</label>
                        <input type="text" name="postcode" id="inputPostcode" class="form-control" value="{$clientsdetails.postcode}">
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-6">
            <div class="form-group">
                <label class="control-label" for="country">{$LANG.orderForm.country}</label>
                <select name="country" id="inputCountry" class="form-control">
                    {foreach $countries as $countrycode => $countrylabel}
                        <option value="{$countrycode}" {if (!$country && $countrycode==$defaultcountry) || $countrycode eq $country} selected{/if}>
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
                                {$customfield.input|replace:'type="checkbox"':'type="checkbox" class="icheck-control"'}
                                {$customfield.name}
                            </label>
                            {if $customfield.description}<span class="help-block">{$customfield.description}</span>{/if}
                        {else}
                            <label class="control-label" for="customfield{$customfield.id}">{$customfield.name}</label>
                            {if $customfield.type == "link"}
                                <div class="input-group">
                                    {$customfield.input|replace:"<a":"<a class='input-group-addon'"|replace:" www":"<i class='ls ls-chain'></i>"}
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
    <div id="containerNewUserSecurity" {if $remote_auth_prelinked && !$securityquestions} class="hidden" {/if}>
        <h6 class="m-t-16">{$LANG.orderForm.accountSecurity}</h6>
        <div id="containerPassword" class="row{if $remote_auth_prelinked && $securityquestions} hidden{/if}">
            <div id="passwdFeedback" style="display:none;" class="alert alert-info text-center col-sm-12"></div>
            <div class="col-sm-6">
                <div class="form-group ">
                    <label for="inputNewPassword1">
                        {$LANG.clientareapassword}
                    </label>
                    <div class="input-password-strenght">
                        <input type="password" name="password" id="inputNewPassword1" data-error-threshold="{$pwStrengthErrorThreshold}" data-warning-threshold="{$pwStrengthWarningThreshold}" class="form-control" autocomplete="off" {if $remote_auth_prelinked} value="{$password}" {/if}>
                        <span class="text-small text-lighter"><span id="passwordStrengthTextLabel">{$rslang->trans('login.at_least_pass')}</span><i data-toggle="tooltip" title="{$LANG.passwordtips}" data-html="true" data-container="body" class="ls ls-info-circle"></i></span>
                    </div>
                    {include file="$template/includes/pwstrength.tpl"}
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-group ">
                    <label for="inputNewPassword2">
                        {$LANG.clientareaconfirmpassword}
                    </label>
                    <input type="password" name="password2" id="inputNewPassword2" class="form-control" autocomplete="off" {if $remote_auth_prelinked} value="{$password}" {/if}>
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
                            <option value="{$question.id}" {if $question.id eq $securityqid} selected{/if}>
                                {$question.question}
                            </option>
                        {/foreach}
                    </select>
                </div>
                <div class="col-sm-6">
                    <div class="form-group ">
                        <label for="inputSecurityQAns">
                            {$LANG.clientareasecurityanswer}
                        </label>
                        <input type="password" name="securityqans" id="inputSecurityQAns" class="form-control" autocomplete="off">
                    </div>
                </div>
            </div>
        {/if}
    </div>
{/if}