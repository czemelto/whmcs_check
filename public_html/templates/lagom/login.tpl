{if isset($RSThemes.pages.login)}
    {include file=$RSThemes['pages']['login']['fullPath']}
{else}
    <div class="main-content col-sm-12">
        {include file="$template/includes/pageheader.tpl" title=$LANG.clientareahomeloginbtn desc="{$LANG.restrictedpage}" textcenter=true}
        <div class="logincontainer">
            <div class="logincontainer-body">
                {include file="$template/includes/flashmessage.tpl"}
                <form method="post" action="{routePath('login-validate')}" class="login-form" role="form">
                    <div class="form-group">
                        <label for="inputEmail">{$LANG.clientareaemail}</label>
                        <input type="email" name="username" class="form-control input-lg" id="inputEmail" placeholder="{$LANG.enteremail}" autofocus tabindex="1">
                    </div>
                    <div class="form-group">
                        <div class="d-flex space-between">
                            <label for="inputPassword">{$LANG.clientareapassword}</label>
                            <a href="{routePath('password-reset-begin')}" tabindex="5">{$rslang->trans('login.forgot')}</a>
                        </div>
                        <input type="password" name="password" class="form-control input-lg" id="inputPassword" placeholder="{$LANG.clientareapassword}" autocomplete="off" tabindex="2">
                    </div>
                    <div class="form-group">
                        <label class="checkbox m-b-16" tabindex="3">
                            <input class="icheck-control" type="checkbox" name="rememberme" /> {$LANG.loginrememberme}
                        </label>
                    </div>
                    {if $captcha->isEnabled()}
                        <div class="text-center margin-bottom">
                            {include file="$template/includes/captcha.tpl"}
                        </div>
                    {/if}
                    <input id="login" type="submit" class="btn btn-lg btn-primary btn-block {$captcha->getButtonClass($captchaForm)}" value="{$LANG.loginbutton}" tabindex="4" />
                </form>
            </div>
            {if $linkableProviders}
                <div class="text-lighter text-center text-small text-divider text-social">
                    <span>or</span>
                </div>
                <div class="providerLinkingFeedback"></div>
                {include file="$template/includes/linkedaccounts.tpl" linkContext="login" customFeedback=true}
            {/if}
    
        </div>
        {if $condlinks.allowClientRegistration}
            <div class="logincontainer-footer m-t-24">
                <div class="text-light">{$rslang->trans('social.not_member')} <a href="{$WEB_ROOT}/register.php" tabindex="6">{$LANG.orderForm.createAccount}</a></div>
            </div>
        {/if}
    </div>
{/if}