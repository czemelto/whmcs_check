<div class="section">
    <p>{lang key='ox.intro'}</p>
    <div id="oxSuccess" class="alert alert-success hidden"></div>
    <div id="oxLoadError" class="alert alert-success hidden"></div>
    <div class="panel panel-default">
         <div class="panel-heading d-flex align-center">
            <h3 class="panel-title">
                <span id="accountCount"><span class="number">{lang key='ox.accountCount' number='-' limit=$model->qty}</span></span>
            </h3>
            <div class="panel-heading-actions d-flex align-center m-l-a">
                 <form action="{$upgradeUrl}" method="post">
                    <input type="hidden" name="isproduct" value="{$isService}">
                    <input type="hidden" name="serviceid" value="{$model->id}">
                    <button type="submit" class="btn btn-sm btn-default m-r-8">{lang key='upgrade'}</button>
                </form>
                <button id="btnRefresh" type="button" class="btn btn-sm btn-default disabled m-r-8" disabled="disabled">
                    <i class="fas fa-sync-alt fa-spin" aria-hidden="true"></i>
                    {lang key='ox.refresh'}
                </button>
                <button id="btnAddAccount" type="button" class="btn btn-default btn-sm">
                    <i class="fal fa-plus"></i>
                    {lang key='ox.createUser'}
                </button>
            </div>
        </div>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th width="30%">{lang key='ox.emailAddress'}</th>
                    <th width="20%">{lang key='ox.mailboxSize'}</th>
                    <th></th>
                </tr>
                <tr class="clone hidden" data-account-id="" data-account="" data-first-name="" data-last-name="" data-display-name="">
                    <td><span class="account"></span>@{$domain}</td>
                    <td><span class="limit"></span>GB</td>
                    <td>
                        <button class="btn btn-default btn-sm manage-account">{lang key='ox.manageAccount'}</button>
                        <button class="btn btn-default btn-sm set-ox-password">{lang key='ox.setPassword'}</button>
                        <button class="btn btn-danger btn-sm ox-delete">{lang key='ox.delete'}</button>
                    </td>
                </tr>
                <tr class="loading">
                    <td colspan="3">
                        {include file="$template/includes/loader.tpl" classes="spinner-sm"}  
                    </td>
                </tr>
                <tr class="no-accounts hidden">
                    <td colspan="3">{lang key='ox.noAccounts'}</td>
                </tr>
            </thead>
            <tbody id="tableBodyAccounts">
            </tbody>
        </table>
    </div>
</div>
<div class="section">
    <div class="panel panel-default">
        <div class="panel-nav">
            <ul class="nav nav-tabs">		
                <li class="active">
                    <a href="#retrievalsettings" data-toggle="tab">
                        <i class="ls ls-envelope"></i>
                        {lang key='ox.settings.retrieval'}
                    </a>
                </li>
                <li>
                    <a href="#davsettings" data-toggle="tab">
                        <i class="ls ls-calendar"></i>
                        {lang key='ox.settings.davSettings'}
                    </a>
                </li>
                <li>
                    <a href="#usage" data-toggle="tab">
                        <i class="ls ls-document-info"></i>
                        {lang key='ox.settings.usageInstructions'}
                    </a>
                </li>
            </ul>
        </div>
        <div class="tab-content">
            <div class="tab-pane fade in active" id="retrievalsettings">
                <div class="panel-body">{lang key='ox.settings.retrievalIntro'}</div>
                <table class="table m-b-0">
                    <tbody>
                        <tr>
                            <td>{lang key='ox.settings.username'}</td>
                            <td>{lang key='ox.settings.email' domain=$domain}</td>
                        </tr>
                        <tr>
                            <td>{lang key='clientareapassword'}</td>
                            <td>{lang key='ox.settings.password'}</td>
                        </tr>
                        <tr>
                            <td>{lang key='ox.settings.pop'}</td>
                            <td class="d-flex align-center">
                                <span class="pop-hostname">
                                    {include file="$template/includes/loader.tpl" classes="spinner-sm"}  
                                </span> &nbsp; <span class="pop-port"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>{lang key='ox.settings.incoming'}</td>
                            <td class="d-flex align-center">
                                <span class="incoming-hostname">
                                    {include file="$template/includes/loader.tpl" classes="spinner-sm"}                                    
                                </span>&nbsp;<span class="incoming-port"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>{lang key='ox.settings.outgoing'}</td>
                            <td class="d-flex align-center">
                                <span class="outgoing-hostname">
                                    {include file="$template/includes/loader.tpl" classes="spinner-sm"}  
                                </span>&nbsp;<span class="outgoing-port"></span>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="tab-pane fade" id="davsettings">
                <div class="panel-body">{lang key='ox.settings.davSettingsIntro'}</div>
                <table class="table m-b-0">
                    <tbody>
                        <tr>
                            <td>{lang key='ox.settings.username'}</td>
                            <td>{lang key='ox.settings.email' domain=$domain}</td>
                        </tr>
                        <tr>
                            <td>{lang key='clientareapassword'}</td>
                            <td>{lang key='ox.settings.caldavPassword'}</td>
                        </tr>
                        <tr>
                            <td>{lang key='ox.settings.serverUrl'}</td>
                            <td>
                                <span class="calendar-server">
                                    {include file="$template/includes/loader.tpl" classes="spinner-sm"}  
                                    
                                </span>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="tab-pane fade" id="usage">
                <table class="table m-b-0">
                    <thead id="tablePanelUsageHead">
                        <tr class="loading">
                            <td>
                                {include file="$template/includes/loader.tpl" classes="spinner-sm"}  
                            </td>
                        </tr>
                    </thead>
                    <tbody id="tablePanelUsage">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>    

<form id="frmOxAddAccount" action="{$addAccountUrl}" method="post">
    <div class="modal fade modal-lg" id="modalAddAccount">
        <div class="modal-dialog ">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="{lang key='close'}"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="modalAddAccountTitle">
                        {lang key='ox.createUser'}
                    </h4>
                </div>
                <div class="modal-body" id="modalSetPasswordBody">
                    <div class="alert alert-danger modal-error hidden"></div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="inputFirstName">{lang key='orderForm.firstName'}</label>
                                <input id="inputFirstName" type="text" autocomplete="off" class="form-control required" name="first">
                                <span class="field-error-msg">{lang key='ox.required.firstName'}</span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="inputLastName">{lang key='orderForm.lastName'}</label>
                                <input id="inputLastName" type="text" autocomplete="off" class="form-control required" name="last">
                                <span class="field-error-msg">{lang key='ox.required.lastName'}</span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="inputDisplayName">{lang key='ox.displayName'}</label>
                                <input id="inputDisplayName" type="text" autocomplete="off" class="form-control required" name="display">
                                <span class="field-error-msg">{lang key='ox.required.displayName'}</span>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="inputEmailAddress">{lang key='orderForm.emailAddress'}</label>
                                <div class="input-group">
                                    <input id="inputEmailAddress" type="text" autocomplete="off" class="form-control required" name="email">
                                    <span class="input-group-addon">@{$domain}</span>
                                </div>
                                <span class="field-error-msg">{lang key='ox.required.email'}</span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group" id="newPassword1">
                                <label for="inputPassword">{lang key='clientareapassword'}</label>
                                <div class="input-password-strenght">
                                    <input type="password" class="form-control required" name="password" id="inputNewPassword1" data-error-threshold="{$pwStrengthErrorThreshold}" data-warning-threshold="{$pwStrengthWarningThreshold}" placeholder="{lang key="loginpassword"}" autocomplete="off" />
                                    <span class="text-small text-lighter"><span id="passwordStrengthTextLabel">{$rslang->trans('login.at_least_pass')}</span><i data-toggle="tooltip" title="{$LANG.passwordtips}" data-html="true" data-container="body" class="ls ls-info-circle"></i></span>
                                </div>
                                {include file="$template/includes/pwstrength.tpl"}
                                <span class="field-error-msg">{lang key='ox.required.password'}</span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group" id="newPassword2">
                                <label for="inputConfirmPassword">{lang key='clientareaconfirmpassword'}</label>
                                <input id="inputNewPassword2" type="password" autocomplete="off" class="form-control required match" data-match-field="inputNewPassword1" name="password2">
                                <span class="field-error-msg">{lang key='ox.required.passwordMatch'}</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">  
                    <button type="button" class="btn btn-primary ox-submit-button">
                        {lang key='orderForm.add'}
                    </button>                  
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        {lang key='close'}
                    </button>
                   
                    <div class="pull-right loader hidden">
                        {include file="$template/includes/loader.tpl" classes="spinner-sm"}  
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
<form id="frmOxManageAccount" action="{$manageAccountUrl}" method="post">
    <div class="modal fade" id="modalManageAccount">
        <input type="hidden" value="" name="account">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="{lang key='close'}"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="modalManageAccountTitle">
                        {lang key='ox.manageAccount'}
                    </h4>
                </div>
                <div class="modal-body" id="modalSetPasswordBody">
                    <div class="alert alert-danger modal-error hidden"></div>
                    <div class="form-group">
                        <label for="inputManageDisplayName">{lang key='ox.displayName'}</label>
                        <input id="inputManageDisplayName" type="text" autocomplete="off" class="form-control required" name="display">
                        <span class="field-error-msg">{lang key='ox.required.displayName'}</span>
                    </div>
                    <div class="form-group">
                        <label for="inputManageFirstName">{lang key='orderForm.firstName'}</label>
                        <input id="inputManageFirstName" type="text" autocomplete="off" class="form-control required" name="first">
                        <span class="field-error-msg">{lang key='ox.required.firstName'}</span>
                    </div>
                    <div class="form-group">
                        <label for="inputManageLastName">{lang key='orderForm.lastName'}</label>
                        <input id="inputManageLastName" type="text" autocomplete="off" class="form-control required" name="last">
                        <span class="field-error-msg">{lang key='ox.required.lastName'}</span>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="pull-right loader hidden">
                       {include file="$template/includes/loader.tpl" classes="spinner-sm"}  
                    </div>
                    <button type="button" class="btn btn-primary ox-submit-button">
                        {lang key='clientareasavechanges'}
                    </button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        {lang key='close'}
                    </button>
                   
                </div>
            </div>
        </div>
    </div>
</form>
<form id="frmOxSetPassword" action="{$setPasswordUrl}" method="post">
    <div class="modal fade" id="modalSetPassword">
        <input type="hidden" value="" name="account">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="{lang key='close'}"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="modalSetPasswordTitle">
                        {lang key='ox.setPasswordFor'}
                    </h4>
                </div>
                <div class="modal-body" id="modalSetPasswordBody">
                    <div class="alert alert-danger modal-error hidden"></div>
                    <div class="form-group">
                        <label for="inputChangePassword">{lang key='clientareapassword'}</label>
                        <div class="input-group">
                            <input type="password" class="form-control required" name="password" id="inputChangePassword" data-error-threshold="{$pwStrengthErrorThreshold}" data-warning-threshold="{$pwStrengthWarningThreshold}" placeholder="{lang key="loginpassword"}" autocomplete="off" />
                            <span class="input-group-btn">
                            <button type="button" class="btn btn-default generate-password" data-targetfields="inputChangePassword,inputChangePasswordConfirm">
                                {lang key="generatePassword.btnShort"}
                            </button>
                        </span>
                        </div>

                        <div class="password-strength-meter">
                            <div class="progress" style="height: 10px; margin-top: 10px">
                                <div class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" id="passwordStrengthMeterBar">
                                </div>
                            </div>
                            <p class="text-center small text-muted" id="passwordStrengthTextLabel">{lang key="pwstrength"}: {lang key="pwstrengthenter"}</p>
                        </div>
                        <span class="field-error-msg">{lang key='ox.required.password'}</span>
                    </div>
                    <div class="form-group">
                        <label for="inputChangePasswordConfirm">{lang key='clientareaconfirmpassword'}</label>
                        <input id="inputChangePasswordConfirm" type="password" autocomplete="off" class="form-control required match" data-match-field="inputChangePassword" name="password2">
                        <span class="field-error-msg">{lang key='ox.required.passwordMatch'}</span>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="pull-right loader hidden">
                        {include file="$template/includes/loader.tpl" classes="spinner-sm"}  
                    </div>
                    <button type="button" class="btn btn-primary ox-submit-button">
                        {lang key='ox.setPassword'}
                    </button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        {lang key='close'}
                    </button>
                </div>
            </div>
        </div>
    </div>
</form>
<form id="frmOxDeleteAccount" action="{$deleteAccountUrl}" method="post">
    <div class="modal fade" id="modalDeleteAccount">
        <input type="hidden" value="" name="account">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="{lang key='close'}"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="modalDeleteAccountTitle">
                        {lang key='ox.deleteAccount'}
                    </h4>
                </div>
                <div class="modal-body" id="modalDeleteAccountBody">
                    <div class="alert alert-danger modal-error hidden"></div>
                    {lang key='ox.deleteAccountQuestion'}
                </div>
                <div class="modal-footer">
                    <div class="pull-right loader hidden">
                        {include file="$template/includes/loader.tpl" classes="spinner-sm"}  
                    </div>
                    <button type="button" class="btn btn-danger ox-submit-button" id="btnDoDelete">
                        {lang key='ox.delete'}
                    </button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        {lang key='close'}
                    </button>
                </div>
            </div>
        </div>
    </div>
</form>

<script>
    function loadAccounts(force)
    {
        var tableBody = jQuery('#tableBodyAccounts'),
            trLoading = jQuery('tr.loading'),
            divError = jQuery('#oxLoadError'),
            trNoAccounts = jQuery('tr.no-accounts');

        force = force || 0;

        if (!divError.hasClass('hidden')) {
            divError.addClass('hidden');
        }

        jQuery('#btnRefresh').addClass('disabled').prop('disabled', 'disabled')
            .find('i').addClass('fa-spin');

        if (trLoading.hasClass('hidden')) {
            trLoading.removeClass('hidden');
        }
        tableBody.html('');
        WHMCS.http.jqClient.jsonPost({
            url: '{$listAccountsUrl}',
            data: {
                token: csrfToken,
                force: force
            },
            success: function(data) {
                if (data.failedMessage) {
                    jQuery('#oxLoadError').text(data.failedMessage).removeClass('hidden');
                } else {
                    if (typeof data.accounts.length === "undefined" || data.accounts.length === 0) {
                        trNoAccounts.removeClass('hidden');
                    } else {
                        jQuery.each(data.accounts, function (index, account) {
                            addAccountToTable(account);
                        });
                    }
                    jQuery('#accountCount').find('.number').text(data.accounts.length);
                }
            },
            always: function() {
                trLoading.addClass('hidden');
                if (jQuery('#tableBodyAccounts').find('tr').length === 0) {
                    trNoAccounts.removeClass('hidden');
                }
                jQuery('#btnRefresh').removeClass('disabled').prop('disabled', false)
                    .find('i').removeClass('fa-spin');
            }
        });
    }

    function addAccountToTable(data)
    {
        var tableBody = jQuery('#tableBodyAccounts'),
            clone = jQuery('tr.clone').clone();
        clone.attr('id', '');
        clone.find('.account')
            .text(data.username);
        clone.find('.limit')
            .text(data.quota);
        clone.attr('data-account-id', data.id)
            .attr('data-first-name', data.first_name)
            .attr('data-last-name', data.last_name)
            .attr('data-display-name', data.display_name)
            .attr('data-account', data.username + '@{$domain}');
        clone.removeClass('clone hidden');
        tableBody.append(clone);
    }

    function loadConfiguration(force)
    {
        var tablePanelUsage = jQuery('#tablePanelUsage'),
            tablePanelUsageHead = jQuery('#tablePanelUsageHead');

        if (tablePanelUsageHead.find('tr.loading').hasClass('hidden')) {
            tablePanelUsageHead.find('tr.loading').removeClass('hidden');
        }
        force = force || 0;
        WHMCS.http.jqClient.jsonPost({
            url: '{$configurationUrl}',
            data: {
                force: force,
                token: csrfToken
            },
            success: function(data) {
                if (data.settings) {
                    jQuery('.incoming-hostname').text(data.settings.incoming.hostname);
                    jQuery('.incoming-port').text(data.settings.incoming.port);
                    jQuery('.pop-hostname').text(data.settings.pop.hostname);
                    jQuery('.pop-port').text(data.settings.pop.port);
                    jQuery('.outgoing-hostname').text(data.settings.outgoing.hostname);
                    jQuery('.outgoing-port').text(data.settings.outgoing.port);
                    jQuery('.calendar-server').text(data.settings.calendar.hostname);
                } else {
                    var error = '{lang key="unavailable"}';
                    jQuery('.incoming-hostname').text(error);
                    jQuery('.incoming-port').text(error);
                    jQuery('.pop-hostname').text(error);
                    jQuery('.pop-port').text(error);
                    jQuery('.outgoing-hostname').text(error);
                    jQuery('.outgoing-port').text(error);
                    jQuery('.calendar-server').text(error);
                }
                if (data.usage) {
                    tablePanelUsage.find('tr').remove();
                    jQuery.each(data.usage, function(index, value) {
                        tablePanelUsage.append(
                            '<tr><td>' + value + '</td></tr>'
                        );
                    });
                }
            },
            always: function() {
                tablePanelUsageHead.find('tr.loading').addClass('hidden');
            }
        });
    }
    jQuery(document).on('ready', function() {
        loadAccounts();
        loadConfiguration();
        jQuery('button.btn-add').width(function() {
            return jQuery(this).outerWidth(true);
        }).find('span.loading').toggleClass('hidden loading');
        jQuery('#modalAddAccount,#modalSetPassword').on('shown.bs.modal', function() {
            jQuery('.modal-backdrop.fade.in').css('zIndex', 1030);
            jQuery(this).css('zIndex', 1035);
        });
        jQuery(document)
            .on('click', '#btnRefresh', function() {
                jQuery(this).addClass('disabled').prop('disabled', true);
                loadAccounts(true);
                loadConfiguration(true);
            })
            .on('click', '#btnAddAccount', function() {
                jQuery('#modalAddAccount').modal('show');
            })
            .on('click', '.manage-account', function() {
                var tr = jQuery(this).closest('tr'),
                    accountId = tr.data('account-id'),
                    account = tr.data('account'),
                    modalManageAccount = jQuery('#modalManageAccount');

                modalManageAccount.find('input[name="account"]').val(accountId);
                modalManageAccount.find('span.email').text(account);
                jQuery('#inputManageDisplayName').val(tr.attr('data-display-name'));
                jQuery('#inputManageFirstName').val(tr.attr('data-first-name'));
                jQuery('#inputManageLastName').val(tr.attr('data-last-name'));
                modalManageAccount.modal('show');
            })
            .on('click', '.set-ox-password', function() {
                var accountId = jQuery(this).closest('tr').data('account-id'),
                    account = jQuery(this).closest('tr').data('account'),
                    modalSetPassword = jQuery('#modalSetPassword');

                modalSetPassword.find('input[name="account"]').val(accountId);
                modalSetPassword.find('span.email').text(account);
                modalSetPassword.modal('show');
            })
            .on('click', '.ox-delete', function() {
                var accountId = jQuery(this).closest('tr').data('account-id'),
                    account = jQuery(this).closest('tr').data('account'),
                    modalDeleteAccount = jQuery('#modalDeleteAccount');

                modalDeleteAccount.find('input[name="account"]').val(accountId);
                modalDeleteAccount.find('span.email').text(account);
                modalDeleteAccount.modal('show');
            })
            .on('click', '.ox-submit-button', function() {
                var frm = jQuery(this).closest('form'),
                    formId = frm.attr('id'),
                    modal = frm.find('div.modal'),
                    formData = frm.serialize(),
                    oxError = modal.find('.modal-error'),
                    oxSuccess = jQuery('#oxSuccess'),
                    tableBody = jQuery('#tableBodyAccounts'),
                    trNoAccounts = jQuery('tr.no-accounts'),
                    accountCount = jQuery('#accountCount').find('.number'),
                    err = false;

                oxError.addClass('hidden').text('');
                oxSuccess.addClass('hidden');

                frm.find('.form-group').removeClass('has-error');
                frm.find('.field-error-msg').hide();

                frm.find('.required').each(function() {
                    if (jQuery(this).val() === '') {
                        if (jQuery(this).hasClass('match')) {
                            jQuery(this).setInputError("{lang key='ox.required.passwordMatchMissing'}");
                        }
                        jQuery(this).showInputError();
                        err = true;
                    }
                });

                frm.find('.match').each(function() {
                    var matchInput = jQuery(this).data('match-field');
                    if (jQuery('#' + matchInput).val() !== jQuery(this).val()) {
                        jQuery(this).setInputError("{lang key='ox.required.passwordMatch'}").showInputError();
                        err = true;
                    }
                });
                if (formId === 'frmOxAddAccount') {
                    var verify = jQuery('#inputConfirmPassword');
                    if (jQuery('#inputPassword').val() !== verify.val()) {
                        verify.showInputError();
                        err = true;
                    }
                }
                if (formId === 'frmOxSetPassword') {
                    var verify2 = jQuery('#inputChangePasswordConfirm');
                    if (jQuery('#inputChangePassword').val() !== verify2.val()) {
                        verify2.showInputError();
                        err = true;
                    }
                }
                if (!err) {
                    modal.find('.loader').removeClass('hidden');
                    WHMCS.http.jqClient.jsonPost({
                        url: frm.attr('action'),
                        data: formData,
                        success: function(data) {
                            if (data.success === true) {
                                var accountId = frm.find('input[name="account"]').val();
                                var tr = jQuery('tr[data-account-id="' + accountId + '"]');
                                oxSuccess.text(data.successMessage).removeClass('hidden');
                                if (formId === 'frmOxDeleteAccount') {
                                    tr.slideUp().remove();
                                } else if (formId === 'frmOxAddAccount') {
                                    addAccountToTable(data);
                                }
                                if (formId === 'frmOxManageAccount') {
                                    tr.attr('data-display-name', data.display_name);
                                    tr.attr('data-first-name', data.first_name);
                                    tr.attr('data-last-name', data.last_name);
                                }
                                frm.find('input').not('[name="token"]').each(function() {
                                    jQuery(this).val('');
                                });
                                modal.modal('hide');
                            } else {
                                oxError.text(data.failedMessage);
                                oxError.removeClass('hidden');
                            }
                        },
                        always: function() {
                            var count = tableBody.find('tr').length;
                            if (count === 0) {
                                trNoAccounts.removeClass('hidden');
                            } else {
                                trNoAccounts.addClass('hidden');
                            }
                            accountCount.text(count);
                            modal.find('.loader').addClass('hidden');
                        }
                    });
                }
            });
    });
</script>