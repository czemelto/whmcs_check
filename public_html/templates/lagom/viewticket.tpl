{if isset($RSThemes.pages.viewticket)}
    {include file=$RSThemes['pages']['viewticket']['fullPath']}
{else}     
    {if $invalidTicketId}
        {include file="$template/includes/alert.tpl" type="danger" title=$LANG.thereisaproblem msg=$LANG.supportticketinvalid}
    {else}
        {if $closedticket}
            {include file="$template/includes/alert.tpl" type="warning" msg=$LANG.supportticketclosedmsg}
        {/if}

        {if $errormessage}
            {include file="$template/includes/alert.tpl" type="error" errorshtml=$errormessage}
        {/if}
    {/if}

    {if !$invalidTicketId}
        <div class="panel panel-collapsable{if !$postingReply} panel-collapsed{/if} hidden-print">
            <div class="panel-heading" id="ticketReply">
                <div class="collapse-icon pull-right">
                    <i class="ls ls-caret {if !$postingReply}plus{else}minus{/if}"></i>
                </div>
                <h4 class="panel-title">
                    <i class="ls ls-pen"></i> &nbsp; {$LANG.supportticketsreply}
                </h4>
            </div>
            <div class="panel-body{if !$postingReply} panel-body-collapsed{/if}">
                <form method="post" action="{$smarty.server.PHP_SELF}?tid={$tid}&amp;c={$c}&amp;postreply=true" enctype="multipart/form-data" role="form" id="frmReply">
                    <div class="row">
                        <div class="form-group col-sm-6">
                            <label for="inputName">{$LANG.supportticketsclientname}</label>
                            {if $loggedin}
                                <input class="form-control disabled" type="text" id="inputName" value="{$clientname}" disabled="disabled" />{else}<input class="form-control" type="text" name="replyname" id="inputName" value="{$replyname}" />
                            {/if}
                        </div>
                        <div class="form-group col-sm-6">
                            <label for="inputEmail">{$LANG.supportticketsclientemail}</label>
                            {if $loggedin}
                                <input class="form-control disabled" type="text" id="inputEmail" value="{$email}" disabled="disabled" />{else}<input class="form-control" type="text" name="replyemail" id="inputEmail" value="{$replyemail}" />
                            {/if}
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputMessage">{$LANG.contactmessage}</label>
                        <textarea name="replymessage" id="inputMessage" rows="12" class="form-control markdown-editor" data-auto-save-name="client_ticket_reply_{$tid}">{$replymessage}</textarea>
                    </div>
                    <div class="row form-group">
                        <div class="col-sm-12">
                            <label for="inputAttachments">{$LANG.supportticketsticketattachments}</label>
                        </div>
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
                        <div class="col-xs-12 ticket-attachments-message text-muted">
                            {$LANG.supportticketsallowedextensions}: {$allowedfiletypes}
                        </div>
                    </div>
                    <div class="ticket-actions">
                        <input class="btn btn-primary" type="submit" name="save" value="{$LANG.supportticketsticketsubmit}" />
                        <input class="btn btn-default" type="reset" value="{$LANG.cancel}" onclick="jQuery('#ticketReply').click()" />
                    </div>
                </form>
            </div>
        </div>

        <div class="panel panel-info visible-print-block">
            <div class="panel-heading">
                <h3 class="panel-title">
                    {$LANG.ticketinfo}
                </h3>
            </div>
            <div class="panel-body container-fluid">
                <div class="row">
                    <div class="col-md-2 col-xs-6">
                        <b>{$LANG.supportticketsticketid}</b><br />{$tid}
                    </div>
                    <div class="col-md-4 col-xs-6">
                        <b>{$LANG.supportticketsticketsubject}</b><br />{$subject}
                    </div>
                    <div class="col-md-2 col-xs-6">
                        <b>{$LANG.supportticketspriority}</b><br />{$urgency}
                    </div>
                    <div class="col-md-4 col-xs-6">
                        <b>{$LANG.supportticketsdepartment}</b><br />{$department}
                    </div>
                </div>
            </div>
        </div>

        {foreach from=$descreplies key=num item=reply}
            <div class="ticket-reply markdown-content{if $reply.admin} staff{/if}">
                <div class="ticket-reply-top">
                    <div class="user">
                        <i class="ls ls-user"></i>
                        <span class="name">{$reply.name}</span>
                    </div>
                    <div class="info">
                        <span class="type">{if $reply.admin}
                            {$LANG.supportticketsstaff}
                        {elseif $reply.contactid}
                            {$LANG.supportticketscontact}
                        {elseif $reply.userid}
                            {$LANG.supportticketsclient}
                        {else}
                            {$reply.email}
                        {/if} </span>
                        <div class="date">{$reply.date}</div>
                    </div>
                </div>
            
            <div class="ticket-message">
                    {$reply.message}
                    {if $reply.id && $reply.admin && $ratingenabled}
                        <div class="clearfix">
                            {if $reply.rating}
                                <div class="rating-done">
                                    {for $rating=1 to 5}
                                        <span class="star{if (5 - $reply.rating) < $rating} active{/if}"></span>
                                    {/for}
                                    <div class="rated">{$LANG.ticketreatinggiven}</div>
                                </div>
                            {else}
                                <div class="rating" ticketid="{$tid}" ticketkey="{$c}" ticketreplyid="{$reply.id}">
                                    <span class="star" rate="5"></span>
                                    <span class="star" rate="4"></span>
                                    <span class="star" rate="3"></span>
                                    <span class="star" rate="2"></span>
                                    <span class="star" rate="1"></span>
                                </div>
                            {/if}
                        </div>
                    {/if}
                </div>
                {if $reply.attachments}
                    <div class="attachments">
                        <strong>{$LANG.supportticketsticketattachments} ({$reply.attachments|count})</strong>
                        {if $reply.attachments_removed}({lang key='support.attachmentsRemoved'}){/if}
                        <ul>
                            {foreach from=$reply.attachments key=num item=attachment}
                                {if $reply.attachments_removed}
                                    <li>
                                        <i class="ls ls-minus"></i>
                                        {$attachment}
                                    </li>
                                {else}
                                    <li><a href="dl.php?type={if $reply.id}ar&id={$reply.id}{else}a&id={$id}{/if}&i={$num}"><i class="ls ls-download"></i> {$attachment}</a></li>
                                {/if}
                            {/foreach}
                        </ul>
                    </div>
                {/if}
            </div>
        {/foreach}

    {/if}
{/if}    
