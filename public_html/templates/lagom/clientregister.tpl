{if isset($RSThemes.pages.clientregister)}
    {include file=$RSThemes['pages']['clientregister']['fullPath']}
{else}
    <div class="main-content col-md-12 ">
        {include file="$template/includes/pageheader.tpl" title=$LANG.register textcenter=true}
        {if in_array('state', $optionalFields)}
            <script>
                var statesTab = 10;
                var stateNotRequired = true;
            </script>
        {/if}
    
        <script type="text/javascript" src="{$BASE_PATH_JS}/StatesDropdown.js"></script>
        <script>
            window.langPasswordStrength = "{$LANG.pwstrength}";
            window.langPasswordWeak = "{$LANG.pwstrengthweak}";
            window.langPasswordModerate = "{$LANG.pwstrengthmoderate}";
            window.langPasswordStrong = "{$LANG.pwstrengthstrong}";
            window.langPasswordTooShort = "{$rslang->trans('login.at_least_pass')}";
        </script>
        {if $registrationDisabled}
            {include file="$template/includes/alert.tpl" type="error" msg=$LANG.registerCreateAccount|cat:' <strong><a href="cart.php" class="alert-link">'|cat:$LANG.registerCreateAccountOrder|cat:'</a></strong>'}
        {/if}
    
        {if !$registrationDisabled}
            <div class="logincontainer register social-wide" id="registration">
                <div class="logincontainer-body">
                    {if $errormessage}
                        {include file="$template/includes/alert.tpl" type="error" errorshtml=$errormessage}
                    {/if}
                    <form method="post" class="" action="{$smarty.server.PHP_SELF}" role="form" name="orderfrm" id="frmCheckout">
                        <input type="hidden" name="register" value="true" />
                        <div id="containerNewUserSignup" class="section">
                            {if $linkableProviders}
                                <div class="section">
                                    {include file="$template/includes/linkedaccounts.tpl" linkContext="registration"}
                                    <div class="text-lighter text-center text-small text-divider"><span>{$rslang->trans('social.fill_form_below')}</span></div>
                                </div>
                            {/if}
                            <div class="section">
                                <h3>{$LANG.orderForm.personalInformation}</h3>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group ">
                                            <label for="inputFirstName">
                                                {$LANG.orderForm.firstName} {if in_array('firstname', $optionalFields)} ({$LANG.orderForm.optional}){/if}
                                            </label>
                                            <input type="text" name="firstname" maxlength="50" id="inputFirstName" class="form-control" placeholder="" value="{$clientfirstname}" {if !in_array('firstname', $optionalFields)}required{/if} autofocus>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group ">
                                            <label for="inputLastName">
                                                {$LANG.orderForm.lastName} {if in_array('lastname', $optionalFields)} ({$LANG.orderForm.optional}){/if}
                                            </label>
                                            <input type="text" name="lastname" maxlength="100" id="inputLastName" class="form-control" placeholder="" value="{$clientlastname}" {if !in_array('lastname', $optionalFields)}required{/if}>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group ">
                                            <label for="inputEmail">
                                                {$LANG.orderForm.emailAddress}
                                            </label>
                                            <input type="email" name="email" id="inputEmail" class="form-control" placeholder="" value="{$clientemail}">
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group ">
                                            <label for="inputPhone">
                                                {$LANG.orderForm.phoneNumber} {if in_array('phonenumber', $optionalFields)} ({$LANG.orderForm.optional}){/if}
                                            </label>
                                            <input type="tel" name="phonenumber" id="inputPhone" class="form-control" placeholder="" value="{$clientphonenumber}">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="section">
                                <h3>{$LANG.orderForm.billingAddress}</h3>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group ">
                                            <label for="inputCompanyName">
                                                {$LANG.orderForm.companyName} ({$LANG.orderForm.optional})
                                            </label>
                                            <input type="text" name="companyname" id="inputCompanyName" class="form-control" placeholder="" value="{$clientcompanyname}">
                                        </div>
                                    </div>
                                    {if $showTaxIdField}
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label for="inputTaxId">
                                                    {$taxLabel} ({$LANG.orderForm.optional})
                                                </label>
                                                <input type="text" name="tax_id" id="inputTaxId" class="form-control" placeholder="" value="{$clientTaxId}">
                                            </div>
                                        </div>
                                    {/if}
                                    <div class="col-sm-6">
                                        <div class="form-group ">
                                            <label for="inputAddress1">
                                                {$LANG.orderForm.streetAddress} {if in_array('address1', $optionalFields)} ({$LANG.orderForm.optional}){/if}
                                            </label>
                                            <input type="text" name="address1" id="inputAddress1" class="form-control" placeholder="" value="{$clientaddress1}" {if !in_array('address1', $optionalFields)}required{/if}>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group ">
                                            <label for="inputAddress2">
                                                {$LANG.orderForm.streetAddress2}
                                            </label>
                                            <input type="text" name="address2" id="inputAddress2" class="form-control" placeholder="" value="{$clientaddress2}">
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group ">
                                            <label for="inputCity">
                                                {$LANG.orderForm.city} {if in_array('city', $optionalFields)} ({$LANG.orderForm.optional}){/if}
                                            </label>
                                            <input type="text" name="city" id="inputCity" class="form-control" placeholder="" value="{$clientcity}" {if !in_array('city', $optionalFields)}required{/if}>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label for="stateinput">
                                                        {$LANG.orderForm.state} {if in_array('state', $optionalFields)} ({$LANG.orderForm.optional}){/if}
                                                    </label>
                                                    <input type="text" name="state" id="state" class="form-control" placeholder="" value="{$clientstate}" {if !in_array('state', $optionalFields)}required{/if}>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label for="inputPostcode">
                                                        {$LANG.orderForm.postcode} {if in_array('postcode', $optionalFields)} ({$LANG.orderForm.optional}){/if}
                                                    </label>
                                                    <input type="text" name="postcode" id="inputPostcode" class="form-control" placeholder="" value="{$clientpostcode}" {if !in_array('postcode', $optionalFields)}required{/if}>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group ">
                                            <label for="inputCountry" id="inputCountryIcon">
                                                {$LANG.orderForm.country}
                                            </label>
                                            <select name="country" id="inputCountry" class="form-control">
                                                {foreach $clientcountries as $countryCode => $countryName}
                                                    <option value="{$countryCode}" {if (!$clientcountry && $countryCode eq $defaultCountry) || ($countryCode eq $clientcountry)} selected="selected" {/if}>
                                                        {$countryName}
                                                    </option>
                                                {/foreach}
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            {if $customfields || $currencies}
                                <div class="section">
                                    <h3>{$LANG.orderadditionalrequiredinfo}</h3>
                                    <div class="row">
                                        {if $customfields}
                                            {foreach from=$customfields key=num item=customfield }
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
                                                                    {$customfield.input|replace:"<a":"<a class='input-group-addon'"|replace:" www":"<i class='ls ls-chain'></i>"}
                                                                </div>
                                                            {else}
                                                                {$customfield.input}
                                                            {/if}
                                                            {if $customfield.description}<span class="help-block">{$customfield.description}</span>{/if}
                                                        {/if}
                                                    </div>
                                                </div>
                                                {if $customfield@iteration % 2 == 0}
                                                </div>
                                                <div class="row">
                                                {/if}
                                            {/foreach}
                                        {/if}
                                        {if $currencies}
                                            <div class="col-sm-6">
                                                <div class="form-group ">
                                                    <label for="inputCurrency">
                                                        {$LANG.choosecurrency}
                                                    </label>
                                                    <select id="inputCurrency" name="currency" class="form-control">
                                                        {foreach from=$currencies item=curr}
                                                            <option value="{$curr.id}" {if !$smarty.post.currency && $curr.default || $smarty.post.currency eq $curr.id } selected{/if}>{$curr.code}</option>
                                                        {/foreach}
                                                    </select>
                                                </div>
                                            </div>
                                        {/if}
                                    </div>
                                </div>
                            {/if}
                        </div>
                        <div id="containerNewUserSecurity" class="section {if $remote_auth_prelinked && !$securityquestions } hidden{/if}">
                            <h3>{$LANG.orderForm.accountSecurity}</h3>
                            <div id="containerPassword" class="row{if $remote_auth_prelinked && $securityquestions} hidden{/if}">
                                <div id="passwdFeedback" style="display: none;" class="alert alert-info text-center col-sm-12"></div>
                                <div class="col-sm-6">
                                    <div class="form-group has-feedback" id="newPassword1">
                                        <label for="inputNewPassword1">
                                            {$LANG.clientareapassword}
                                        </label>
                                        <div class="input-password-strenght">
                                            <input type="password" name="password" id="inputNewPassword1" data-error-threshold="{$pwStrengthErrorThreshold}" data-warning-threshold="{$pwStrengthWarningThreshold}" class="form-control" placeholder="" autocomplete="off" {if $remote_auth_prelinked} value="{$password}" {/if}>
                                            <span class="text-small text-lighter"><span id="passwordStrengthTextLabel">{$rslang->trans('login.at_least_pass')}</span><i data-toggle="tooltip" title="{$LANG.passwordtips}" data-html="true" data-container="body" class="ls ls-info-circle"></i></span>
                                        </div>
                                        {include file="$template/includes/pwstrength.tpl"}
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group has-feedback" id="newPassword2">
                                        <label for="inputNewPassword2">
                                            {$LANG.clientareaconfirmpassword}
                                        </label>
                                        <input type="password" name="password2" id="inputNewPassword2" class="form-control" placeholder="" autocomplete="off" {if $remote_auth_prelinked} value="{$password}" {/if}>
                                        <div id="inputNewPassword2Msg"></div>
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
                                            <input type="password" name="securityqans" id="inputSecurityQAns" class="form-control" placeholder="" autocomplete="off">
                                        </div>
                                    </div>
                                </div>
                            {/if}
                        </div>
                        {if $showMarketingEmailOptIn}
                            <div class="section m-t-24 {if $captcha}m-b-32{/if}">
                                <h3>{lang key='emailMarketing.joinOurMailingList'}</h3>
                                <p>{$marketingEmailOptInMessage}</p>
                                <div class="panel panel-switch m-w-288">
                                    <div class="panel-body">
                                        <span class="switch-label">{$rslang->trans('generals.receive_emails')}: </span>
                                        <label class="switch switch--lg switch--text">
                                            <input class="switch__checkbox" type="checkbox" name="marketingoptin" value="1" {if $marketingEmailOptIn} checked{/if}>
                                            <span class="switch__container"><span class="switch__handle"></span></span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                        {/if}
                        {include file="$template/includes/captcha.tpl"}
                        {if $accepttos}
                            <div class="checkbox m-t-24">
                                <label>
                                    <input class="icheck-control accepttos" type="checkbox" name="accepttos">
                                    <span>{$LANG.ordertosagreement} <a href="{$tosurl}" target="_blank">{$LANG.ordertos}</a></span>
                                </label>
                            </div>
                        {/if}
                        <div class="form-actions m-t-24">
                            <input class="btn btn-lg btn-primary btn-block {$captcha->getButtonClass($captchaForm)}" type="submit" value="{$LANG.clientregistertitle}" />
                        </div>
                    </form>
                </div>
                <div class="logincontainer-footer">
                    <div class="text-center text-light">{$rslang->trans('login.already_registered')} <a href="{$WEB_ROOT}/login.php">{$rslang->trans('login.sign_in')}</a> <span class="text-lowercase">{$LANG.remoteAuthn.titleOr}</span> <a href="{routePath('password-reset-begin')}">{$rslang->trans('login.reset_password')}</a></div>
                </div>
            </div>
        {/if}
    </div>
{/if}