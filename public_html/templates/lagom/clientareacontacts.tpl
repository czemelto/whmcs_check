{if isset($RSThemes.pages.clientareacontacts)}
    {include file=$RSThemes['pages']['clientareacontacts']['fullPath']}
{else} 
    {if $contactid}
        {if $successful}
            {include file="$template/includes/alert.tpl" type="success" msg=$LANG.changessavedsuccessfully textcenter=true}
        {/if}
        {if $errormessage}
            {include file="$template/includes/alert.tpl" type="error" errorshtml=$errormessage}
        {/if}
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
            <form role="form" method="post" action="{$smarty.server.PHP_SELF}?action=contacts&id={$contactid}">
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
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="inputTaxId" class="control-label">{lang key=$taxIdLabel}</label>
                                            <input type="text" name="tax_id" id="inputTaxId" class="form-control" value="{$contactTaxId}" />
                                        </div>
                                    </div>  
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
                            <label id="subaccountActivate">
                                <input class="icheck-control" type="checkbox" name="subaccount" {if $subaccount} checked{/if} /> {$LANG.subaccountactivatedesc}
                            </label>
                        </div>
                        <div id="subacct-container"  class="collapse {if $subaccount}in{/if}">              
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
                                {if $hasLinkedProvidersEnabled}
                                    <div class="section">
                                        <div class="section-header">
                                            <h3>{$LANG.remoteAuthn.titleLinkedAccounts}</h3>
                                        </div>
                                        <div class="section-body">
                                            <div class="table-container table-responsive">
                                                {include file="$template/includes/linkedaccounts.tpl" linkContext="linktable" }
                                            </div>
                                        </div>
                                    </div>
                                {/if}
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
                                {foreach $emailPreferences as $emailType => $value}
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
                    <input class="btn btn-default  m-r-a" type="reset" value="{$LANG.clientareacancel}" />
                    <a class="btn btn-default" data-toggle="confirmation" data-btn-ok-label="{lang key='yes'}" data-btn-ok-icon="fa fa-check" data-btn-ok-class="btn-success" data-btn-cancel-label="{lang key='no'}" data-btn-cancel-icon="fa fa-ban" data-btn-cancel-class="btn-default" data-title="{lang key='clientareadeletecontact'}" data-content="{lang key='clientareadeletecontactareyousure'}" data-popout="true" href="clientarea.php?action=contacts&delete=true&id={$contactid}&token={$token}">{lang key='clientareadeletecontact'}</a>
                </div>
            </form>
        </div>    
    {else}
        {include file="$template/clientareaaddcontact.tpl"}
    {/if}

    <script type="text/javascript">
        jQuery(document).ready( function ()
        {
            jQuery('.removeAccountLink').click(function (e) {
                e.preventDefault();
                var authUserID = jQuery(this).data('authid');
                swal(
                    {
                        title: "Are you sure?",
                        text: "This permanently unlinks the authorized account.",
                        type: "warning",
                        showCancelButton: true,
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "Yes, unlink it!",
                        closeOnConfirm: false
                    },
                    function(){
                        jQuery.post('{routePath('auth-manage-client-delete')}' + authUserID,
                            {
                                'token': '" . generate_token("plain") . "'
                            }).done(function(data) {
                            if (data.status == 'success') {
                                jQuery('#remoteAuth' + authUserID).remove();
                                swal("Unlinked!", data.message, "success");
                            } else {
                                swal("Error!", data.message, "error");
                            }
                        });
                    });
            });
        });
    </script>
{/if}
