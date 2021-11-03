{if isset($RSThemes['pages']['supportticketsubmit-steptwo'])}
    {include file=$RSThemes['pages']['supportticketsubmit-steptwo']['fullPath']}
{else}    
    {if $errormessage}
        {include file="$template/includes/alert.tpl" type="error" errorshtml=$errormessage}
    {/if}
    {* 
        -- Start of integration code --
        - Integration code for: Premium Support Tickets For WHMCS from ModulesGarden
        - Module URL: https://www.modulesgarden.com/products/whmcs/premium-support-tickets
    *}
    {if $PremiumSupportTickets && $PremiumSupportTickets.canCreate}
        <div class="alert alert-info alert-premium-support-tickets">
            <div class="alert-body">
                {$PremiumSupportTickets.haveInCreatePointsMsg} <b class="ticket-points">{$PremiumSupportTickets.havePoints}</b>
            </div>
        </div>
        <script type="text/javascript">
        {literal}
        $(document).ready(function() {
            $('select[name=deptid]').change(function() {
                window.location.href = 'submitticket.php?step=2&deptid='+$(this).val();
            });
        });
        {/literal}
        </script>
    {/if}
    {* -- End of integration code -- *}
    <form method="post" action="{$smarty.server.PHP_SELF}?step=3" enctype="multipart/form-data" role="form">
        <div class="section">
            <div class="section-header">
                <h3>{$LANG.ticketinfo}</h3>
            </div>
            <div class="section-body">
                <div class="panel panel-default panel-form">
                    <div class="panel-body">
                        <div class="row">
                            <div class="form-group col-sm-6">
                                <label for="inputName">{$LANG.supportticketsclientname}</label>
                                <input type="text" name="name" id="inputName" value="{$name}" class="form-control{if $loggedin} disabled{/if}"{if $loggedin} disabled="disabled"{/if} />
                            </div>
                            <div class="form-group col-sm-6">
                                <label for="inputEmail">{$LANG.supportticketsclientemail}</label>
                                <input type="email" name="email" id="inputEmail" value="{$email}" class="form-control{if $loggedin} disabled{/if}"{if $loggedin} disabled="disabled"{/if} />
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group {if $relatedservices}col-sm-4{else}col-sm-6{/if}">
                                <label for="inputDepartment">{$LANG.supportticketsdepartment}</label>
                                <select name="deptid" id="inputDepartment" class="form-control" onchange="refreshCustomFields(this)">
                                    {foreach from=$departments item=department}
                                        <option value="{$department.id}"{if $department.id eq $deptid} selected="selected"{/if}>
                                            {$department.name}
                                        </option>
                                    {/foreach}
                                </select>
                            </div>
                            {if $relatedservices}
                                <div class="form-group col-sm-4">
                                    <label for="inputRelatedService">{$LANG.relatedservice}</label>
                                    <select name="relatedservice" id="inputRelatedService" class="form-control">
                                        <option value="">{$LANG.none}</option>
                                        {foreach from=$relatedservices item=relatedservice}
                                            <option value="{$relatedservice.id}">
                                                {$relatedservice.name} ({$relatedservice.status})
                                            </option>
                                        {/foreach}
                                    </select>
                                </div>
                            {/if}                            
                            <div class="form-group {if $relatedservices}col-sm-4{else}col-sm-6{/if}">
                                {* 
                                    -- Start of integration code --
                                    - Integration code for: Premium Support Tickets For WHMCS from ModulesGarden
                                    - Module URL: https://www.modulesgarden.com/products/whmcs/premium-support-tickets
                                *}
                                {if $PremiumSupportTicketsAddonIsActive}
                                    <label for="inputPriority">{$LANG.supportticketspriority}</label>
                                    <select name="urgency" id="inputPriority" class="form-control">
                                        <option value="High"{if $urgency eq "High"} selected="selected"{/if}>
                                            {$LANG.supportticketsticketurgencyhigh} - {$PremiumSupportTickets.requiredPlusHigh} SCP
                                        </option>
                                        <option value="Medium"{if $urgency eq "Medium" || !$urgency} selected="selected"{/if}>
                                            {$LANG.supportticketsticketurgencymedium} - {$PremiumSupportTickets.requiredPlusNormal} SCP
                                        </option>
                                        <option value="Low"{if $urgency eq "Low"} selected="selected"{/if}>
                                            {$LANG.supportticketsticketurgencylow} - {$PremiumSupportTickets.requiredPlusLow} SCP
                                        </option>
                                    </select>                            
                                {* -- End of integration code -- *}
                                {else}
                                    <label for="inputPriority">{$LANG.supportticketspriority}</label>
                                    <select name="urgency" id="inputPriority" class="form-control">
                                        <option value="High"{if $urgency eq "High"} selected="selected"{/if}>
                                            {$LANG.supportticketsticketurgencyhigh}
                                        </option>
                                        <option value="Medium"{if $urgency eq "Medium" || !$urgency} selected="selected"{/if}>
                                            {$LANG.supportticketsticketurgencymedium}
                                        </option>
                                        <option value="Low"{if $urgency eq "Low"} selected="selected"{/if}>
                                            {$LANG.supportticketsticketurgencylow}
                                        </option>
                                    </select>
                                {/if}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="section">
            <div class="section-header">
                <h3>{$LANG.contactmessage}</h3>
            </div>
            <div class="section-body">
                <div class="panel panel-default panel-form">
                    <div class="panel-body">
                        <div class="row">
                            <div class="form-group col-sm-12">
                                <label for="inputSubject">{$LANG.supportticketsticketsubject}</label>
                                <input type="text" name="subject" id="inputSubject" value="{$subject}" class="form-control" />
                            </div>
                            <div class="form-group col-sm-12">
                                <label for="inputMessage">{$LANG.contactmessage}</label>
                                <textarea name="message" id="inputMessage" rows="12" class="form-control markdown-editor" data-auto-save-name="client_ticket_open">{$message}</textarea>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="section">
            <div class="section-header">
                <h3>{$LANG.supportticketsticketattachments}</h3>
            </div>
            <div class="section-body">
                <div class="panel panel-default panel-form">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-sm-9">
                                <div class="file-input form-control">
                                    <input type="file" name="attachments[]" id="inputAttachments" class="form-control" />
                                    <span class="file-input-button btn btn-default">
                                        {$rslang->trans('support.select_file')}
                                    </span>
                                    <span class="file-input-text text-light">{$rslang->trans('support.no_file_selected')}</span>
                                </div>
                                <div id="fileUploadsContainer"></div>
                            </div>
                            <div class="col-sm-3">
                                <button type="button" class="btn btn-info btn-block add-extra-attachement mob-m-t-16" data-nofiletext="{$rslang->trans('support.no_file_selected')}" data-selectfiletext="{$rslang->trans('support.select_file')}" data-removetext="{$LANG.orderForm.remove}">
                                    <i class="ls ls-plus"></i>{$LANG.addmore}
                                </button>
                            </div>
                        </div>
                        <p class=" ticket-attachments-message text-muted m-b-0">
                            {$LANG.supportticketsallowedextensions}: {$allowedfiletypes}
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <div id="customFieldsContainer">
            {include file="$template/supportticketsubmit-customfields.tpl"}
        </div>
        <div id="autoAnswerSuggestions" class="hidden m-t-32"></div>
         {if $captcha->isEnabled()}    
            <div class="text-center margin-bottom">
                {include file="$template/includes/captcha.tpl"}
            </div>
        {/if}
        <div class="form-actions">
            <input type="submit" id="openTicketSubmit" value="{$LANG.supportticketsticketsubmit}" class="btn btn-primary{$captcha->getButtonClass($captchaForm)}" />
            <a href="supporttickets.php" class="btn btn-default">{$LANG.cancel}</a>
        </div>
    </form>
    {if $kbsuggestions}
        <script>
            jQuery(document).ready(function () {
                getTicketSuggestions();
            });
        </script>
    {/if}
{/if}