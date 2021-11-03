{if isset($RSThemes.pages.clientareaaddcontact)}
    {include file=$RSThemes['pages']['clientareaaddcontact']['fullPath']}
{else}
    {if $errormessage}
        {include file="$template/includes/alert.tpl" type="error" errorshtml=$errormessage}
    {/if}
    <script>
    var stateNotRequired = true;
    </script>
    <script type="text/javascript" src="{$BASE_PATH_JS}/StatesDropdown.js"></script>
    <div class="section">
        <div class="section-header">
            <h3>{$LANG.clientareachoosecontact}</h3>
        </div>    
        <div class="section-body">
            <div class="panel panel-default panel-form">
                <div class="panel-body">
                <form class="form-horizontal" role="form" method="post" action="{$smarty.server.PHP_SELF}?action=contacts">
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
        <form role="form" method="post" action="{$smarty.server.PHP_SELF}?action=addcontact">
            <input type="hidden" name="submit" value="true" />
            <div class="section">
                <div class="section-header">
                    <h3>{$rslang->trans('generals.contact_details')}</h3>
                </div>
                <div class="section-body">				
                    <div class="panel panel-default panel-form">
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="inputFirstName" class="control-label">{$LANG.clientareafirstname}</label>
                                        <input type="text" name="firstname" id="inputFirstName" value="{$contactfirstname}" class="form-control" />
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="inputLastName" class="control-label">{$LANG.clientarealastname}</label>
                                        <input type="text" name="lastname" id="inputLastName" value="{$contactlastname}" class="form-control" />
                                    </div>
                                </div>
                           
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="inputEmail" class="control-label">{$LANG.clientareaemail}</label>
                                        <input type="email" name="email" id="inputEmail" value="{$contactemail}" class="form-control" />
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="inputPhone" class="control-label">{$LANG.clientareaphonenumber}</label>
                                        <input type="tel" name="phonenumber" id="inputPhone" value="{$contactphonenumber}" class="form-control" />
                                    </div>
                                </div>
                          
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="inputCompanyName" class="control-label">{$LANG.clientareacompanyname}</label>
                                        <input type="text" name="companyname" id="inputCompanyName" value="{$contactcompanyname}" class="form-control" />
                                    </div>
                                </div>
                                {if $showTaxIdField}
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="inputTaxId" class="control-label">{lang key=$taxIdLabel}</label>
                                            <input type="text" name="tax_id" id="inputTaxId" class="form-control" value="{$contactTaxId}" />
                                        </div>
                                    </div>
                                {/if}
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="inputAddress1" class="control-label">{$LANG.clientareaaddress1}</label>
                                        <input type="text" name="address1" id="inputAddress1" value="{$contactaddress1}" class="form-control" />
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="inputAddress2" class="control-label">{$LANG.clientareaaddress2}</label>
                                        <input type="text" name="address2" id="inputAddress2" value="{$contactaddress2}" class="form-control" />
                                    </div>
                                </div>
                            
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="inputCity" class="control-label">{$LANG.clientareacity}</label>
                                        <input type="text" name="city" id="inputCity" value="{$contactcity}" class="form-control" />
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label for="inputState" class="control-label">{$LANG.clientareastate}</label>
                                                <input type="text" name="state" id="inputState" value="{$contactstate}" class="form-control" />
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label for="inputPostcode" class="control-label">{$LANG.clientareapostcode}</label>
                                                <input type="text" name="postcode" id="inputPostcode" value="{$contactpostcode}" class="form-control" />
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
                    <h3>{$LANG.subaccountactivate}</h3>
                </div>
                <div class="section-body">
                    <div class="checkbox m-b-24">
                        <label id="subaccountActivate"><input class="icheck-control" type="checkbox" name="subaccount" {if $subaccount} checked{/if} /> {$LANG.subaccountactivatedesc}</label>
                    </div>
                    <div id="subacct-container" class="collapse {if $subaccount}in{/if}">
                        <div class="panel panel-default panel-form">
                            <div class="panel-body">
                                <div class="section">
                                    {assign var="permCounter" value="0"} 
                                     {foreach $allPermissions as $permission name=foo}
                                        {if in_array($permission, $permissions)}
                                            {math assign="permCounter" equation="x +1" x=$permCounter}
                                        {/if}
                                     {/foreach}
                                     {if $permCounter == $allPermissions|count}
                                        {assign var="permCheckedAll" value=true}
                                     {/if}
                                    
                                    <div class="section-header m-b-24 d-flex space-between align-center">
                                        <h3 class="m-b-0">{$LANG.subaccountpermissions}</h3>
                                        <a class="btn btn-sm btn-outline btn-check-all {if $permCheckedAll}checked{/if}" data-checkalltext="{$LANG.checkAll}" data-uncheckalltext="{$LANG.uncheckAll}" href="#">{if $permCheckedAll}{$LANG.uncheckAll}{else}{$LANG.checkAll}{/if}</a>
                                    </div>
                                    <div class="section-body check-all-container">
                                        <div class="row" id="contactPermissions">
                                            <div class="col-sm-6">
                                                {foreach $allPermissions as $permission name=foo}
                                                    <div class="checkbox">
                                                        <label>
                                                            <input class="icheck-control" type="checkbox" name="permissions[]" value="{$permission}"{if in_array($permission, $permissions)} checked{/if} />
                                                            <span>
                                                                {assign var='langPermission' value='subaccountperms'|cat:$permission}{$LANG.$langPermission}
                                                            </span>
                                                        </label>
                                                    </div>
                                                    {math assign="half" equation="(x / y) + 1" x=$smarty.foreach.foo.total y=2 format="%d"}
                                                    {if $smarty.foreach.foo.iteration == $half}
                                                    </div>
                                                    <div class="col-sm-6">
                                                    {/if}
                                                {/foreach}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="section">
                                    <div class="section-header">
                                        <h3>{$LANG.orderForm.accountSecurity}</h3>
                                    </div>
                                    <div class="section-body">
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div id="newPassword1" class="form-group has-feedback">
                                                    <label for="inputNewPassword1" class="control-label">{$LANG.newpassword}</label>
                                                    <div class="input-password-strenght">
                                                        <input type="password" class="form-control" id="inputNewPassword1" name="password" autocomplete="off" />
                                                        <span class="text-small text-lighter"><span id="passwordStrengthTextLabel">{$rslang->trans('login.at_least_pass')}</span><i data-toggle="tooltip" title="{$LANG.passwordtips}" data-html="true" data-container="body" class="ls ls-info-circle"></i></span>
                                                    </div>
                                                    {include file="$template/includes/pwstrength.tpl" noDisable=true}
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div id="newPassword2" class="form-group has-feedback">
                                                    <label for="inputNewPassword2" class="control-label">{$LANG.confirmnewpassword}</label>
                                                    <input type="password" class="form-control" id="inputNewPassword2" name="password2" autocomplete="off" />
                                                    <div id="inputNewPassword2Msg"></div>
                                                </div>
                                            </div>
                                        </div>                                      
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
                            <div class="checkbox">
                                <label>
                                    <input class="icheck-control" type="checkbox" name="generalemails" id="generalemails" value="1"{if $generalemails} checked{/if} />
                                    {$LANG.clientareacontactsemailsgeneral}
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input class="icheck-control" type="checkbox" name="productemails" id="productemails" value="1"{if $productemails} checked{/if} />
                                    {$LANG.clientareacontactsemailsproduct}
                                </label>
                            </div>
                            <div class="checkbox">                
                                <label>
                                    <input class="icheck-control" type="checkbox" name="domainemails" id="domainemails" value="1"{if $domainemails} checked{/if} />
                                    {$LANG.clientareacontactsemailsdomain}
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input class="icheck-control" type="checkbox" name="invoiceemails" id="invoiceemails" value="1"{if $invoiceemails} checked{/if} />
                                    {$LANG.clientareacontactsemailsinvoice}
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input class="icheck-control" type="checkbox" name="supportemails" id="supportemails" value="1"{if $supportemails} checked{/if} />
                                    {$LANG.clientareacontactsemailssupport}
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-actions">
                <input class="btn btn-primary" type="submit" name="save" value="{$LANG.clientareasavechanges}" />
                <input class="btn btn-default" type="reset" value="{$LANG.clientareacancel}" />
            </div>
        </form>
    </div>
{/if}    