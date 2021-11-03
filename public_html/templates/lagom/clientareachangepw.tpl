{if isset($RSThemes.pages.clientareachangepw)}
    {include file=$RSThemes['pages']['clientareachangepw']['fullPath']}
{else} 
    <div class="row">
        <div class="col-sm-7">
            {if $successful}
                {include file="$template/includes/alert.tpl" type="success" msg=$LANG.changessavedsuccessfully textcenter=true}
            {/if}
            {if $errormessage}
                {include file="$template/includes/alert.tpl" type="error" errorshtml=$errormessage}
            {/if}
            <form class="using-password-strength" method="post" action="clientarea.php?action=changepw" role="form">
                <input type="hidden" name="submit" value="true" />
                <div class="panel panel-default panel-form">
                    <div class="panel-body">
                        <div class="form-group">
                            <label for="inputExistingPassword" class="control-label">{$LANG.existingpassword}</label>
                            <input type="password" class="form-control" name="existingpw" id="inputExistingPassword" autocomplete="off" /> 
                        </div>
                        <div id="newPassword1" class="form-group">
                            <label for="inputNewPassword1" class="control-label">{$LANG.newpassword}</label>
                            <div class="input-password-strenght">
                                <input type="password" class="form-control" name="newpw" id="inputNewPassword1" autocomplete="off" />
                                <span class="text-small text-lighter"><span id="passwordStrengthTextLabel">{$rslang->trans('login.at_least_pass')}</span><i data-toggle="tooltip" title="{$LANG.passwordtips}" data-html="true" data-container="body" class="ls ls-info-circle"></i></span>
                            </div>
                            {include file="$template/includes/pwstrength.tpl"}
                        </div>
                        <div id="newPassword2" class="form-group">
                            <label for="inputNewPassword2" class="control-label">{$LANG.confirmnewpassword}</label>
                            <input type="password" class="form-control" name="confirmpw" id="inputNewPassword2" autocomplete="off" />
                            <div id="inputNewPassword2Msg"><p class="help-block"></p></div>
                        </div>                
                    </div>
                    <div class="panel-footer">
                        <input class="btn btn-primary" type="submit" value="{$LANG.clientareasavechanges}" />
                        <input class="btn btn-default" type="reset" value="{$LANG.clientareacancel}" />
                    </div>
                </div>
            </form>
        </div>
    </div>
{/if}