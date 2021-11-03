{if isset($RSThemes.pages.contact)}
    {include file=$RSThemes['pages']['contact']['fullPath']}
{else}
    <div class="main-content col-sm-12">
        {if !$sent}
            {include file="$template/includes/pageheader.tpl" title=$displayTitle textcenter=true}
        {/if}
        <div class="logincontainer contact">
            {if $sent}
                <div class="message message-no-data  message-lg message-success">
                    <div class="message-icon">
                        <i class="lm lm-check"></i>
                    </div>
                    <h2 class="message-text"> {$LANG.contactsent}</h2>
                    <a href="{$systemurl}" class="btn btn-default">
                        {lang key="errorPage.404.home"}
                    </a>
                </div>
            {/if}
            {if !$sent}
                <div class="logincontainer-body">
                    {if $errormessage}
                        {include file="$template/includes/alert.tpl" type="error" errorshtml=$errormessage}
                    {/if}
                    <form method="post" action="contact.php" role="form">
                        <input type="hidden" name="action" value="send" />
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label for="inputName" class="control-label">{$LANG.supportticketsclientname}</label>
                                    <input type="text" name="name" value="{$name}" class="form-control" id="inputName" />
                                </div>
                            </div>    
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label for="inputEmail" class="control-label">{$LANG.supportticketsclientemail}</label>
                                    <input type="email" name="email" value="{$email}" class="form-control" id="inputEmail" />
                                </div>   
                            </div>
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label for="inputSubject" class="control-label">{$LANG.supportticketsticketsubject}</label>
                                    <input type="subject" name="subject" value="{$subject}" class="form-control" id="inputSubject" />   
                                </div>
                            </div>
                            <div class="col-sm-12">    
                                <div class="form-group">
                                    <label for="inputMessage" class="control-label">{$LANG.contactmessage}</label>
                                    <textarea name="message" rows="7" class="form-control" id="inputMessage">{$message}</textarea>
                                </div>
                            </div>
                        </div>      
                        {if $captcha->isEnabled() && $captcha->isEnabledForForm($captchaForm)}    
                            {include file="$template/includes/captcha.tpl"}
                        {/if}
                        {if ($captcha->isEnabled() && in_array($captcha, ['invisible'])) || !$captcha->isEnabledForForm($captchaForm) || !$captcha->isEnabled()}
                            <div class="form-actions flex-center">
                                <button type="submit" class="btn btn-primary {$captcha->getButtonClass($captchaForm)}">{$LANG.contactsend}</button>  
                            </div>
                        {/if}
                    </form>
                </div>     
            {/if}
        </div>    
    </div>
{/if}