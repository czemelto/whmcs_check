<div class="main-content col-sm-12">
    {if $RSThemes['pages'][$templatefile]['config']['showLogo'] == '1'}
       {if $RCLogo}
            <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" tabindex="7"><img src="{$WEB_ROOT}/{$RCLogo}" alt="{$companyname}" ></a>
        {elseif $MBLogo}
            <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" tabindex="7"  class="logo"><img src="{$MBLogo}" alt="{$companyname}" ></a>
        {elseif $RSThemes.styles.vars.fullPageOnDarkBg}
            {if $RSThemes.logo_inverse}
                <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" tabindex="7" class="logo"><img src="{$WEB_ROOT}{$RSThemes.logo_inverse}" alt="{$companyname}"/></a>
            {elseif $RSThemes.logo}
                <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" tabindex="7" class="logo"><img src="{$WEB_ROOT}{$RSThemes.logo}" alt="{$companyname}"/></a>
            {elseif $assetLogoPath}
                <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" tabindex="7" class="logo"><img src="{$assetLogoPath}" alt="{$companyname}"/></a>
            {else}
                <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" tabindex="7" class="logo logo-text">{$companyname}</a>
            {/if}
        {else}
            {if $RSThemes.logo}
                <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" tabindex="7" class="logo"><img src="{$WEB_ROOT}{$RSThemes.logo}" alt="{$companyname}"/></a>
            {elseif $assetLogoPath}
                <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" tabindex="7" class="logo"><img src="{$assetLogoPath}" alt="{$companyname}"/></a>
            {else}
                <a href="{if $lagom_logo_url}{$lagom_logo_url}{else}{$WEB_ROOT}/index.php{/if}" tabindex="7" class="logo logo-text">{$companyname}</a>
            {/if}
        {/if}
    {/if}
    <script type="text/javascript" src="{$BASE_PATH_JS}/PasswordStrength.js"></script>
    <script>
        window.langPasswordStrength = "{lang key="pwstrength"}";
        window.langPasswordWeak = "{lang key="pwstrengthweak"}";
        window.langPasswordModerate = "{lang key="pwstrengthmoderate"}";
        window.langPasswordStrong = "{lang key="pwstrengthstrong"}";
        jQuery(document).ready(function()
        {
            jQuery("#inputPassword").keyup(registerFormPasswordStrengthFeedback);
        });
    </script>
   
    <div class="logincontainer">
        <div class="logincontainer-body">
            {if $invite}
                {include file="$template/includes/flashmessage.tpl"}
                <div class="text-center m-b-16">
                    {include file="$template/assets/svg-icon/outgoing-email-filtering.tpl"}        
                </div>
                <h1 class="h2 text-center">{lang key="accountInvite.youHaveBeenInvited" clientName=$invite->getClientName()}</h1>
                <p class="text-center">
                    {lang key="accountInvite.givenAccess" senderName=$invite->getSenderName() clientName=$invite->getClientName() ot="<strong>" ct="</strong>"}
                    {if $loggedin}
                        {lang key="accountInvite.inviteAcceptLoggedIn"}
                    {else}
                        {lang key="accountInvite.inviteAcceptLoggedOut"}
                    {/if}
                </p>  
                {if $loggedin}
                    <form method="post" action="{routePath('invite-validate', $invite->token)}">
                        <button type="submit" class="btn btn-primary btn-lg btn-block m-t-24">
                            {lang key="accountInvite.accept"}
                        </button>
                    </form>
                {else}
                    <div class="invite-actions" data-actions>
                        <button type="button" class="btn btn-primary btn-lg btn-block m-t-24" data-show="login">{lang key="login"}</button>
                        <button type="button" class="btn btn-default btn-lg btn-block m-t-16" data-show="register">{lang key="register"}</button>
                    </div>
                    <form class="invite-form hidden" data-invite="login" method="post" action="{routePath('login-validate')}" >
                        <div class="form-group">
                            <label for="inputLoginEmail">{lang key="loginemail"}</label>
                            <input type="email" name="username" class="form-control" id="inputLoginEmail" placeholder="{lang key="loginemail"}" value="{$formdata.email}">
                        </div>
                        <div class="form-group">
                            <div class="d-flex space-between">
                                <label for="inputLoginPassword">{lang key="loginpassword"}</label>
                                <a href="{routePath('password-reset-begin')}" tabindex="5">{$rslang->trans('login.forgot')}</a>
                            </div>
                            <input type="password" name="password" class="form-control" id="inputLoginPassword" placeholder="{lang key="loginpassword"}">
                        </div>
                        <div class="text-center margin-bottom">
                            {include file="$template/includes/captcha.tpl" captchaForm=$captchaForm nocache}
                        </div>
                        <button type="submit" class="btn btn-primary btn-block btn-lg {$captcha->getButtonClass($captchaForm)}">
                            {lang key="login"}
                        </button>
                    </form>
                    <form class="invite-form hidden" data-invite="register" method="post" action="{routePath('invite-validate', $invite->token)}">
                        <div class="form-group">
                            <label for="inputFirstName">{lang key="clientareafirstname"}</label>
                            <input type="text" class="form-control" name="firstname" id="inputFirstName" placeholder="{lang key="clientareafirstname"}" value="{$formdata.firstname}">
                        </div>
                        <div class="form-group">
                            <label for="inputLastName">{lang key="clientarealastname"}</label>
                            <input type="text" class="form-control" name="lastname" id="inputLastName" placeholder="{lang key="clientarealastname"}" value="{$formdata.lastname}">
                        </div>
                        <div class="form-group">
                            <label for="inputEmail">{lang key="loginemail"}</label>
                            <input type="email" name="email" class="form-control" id="inputEmail" placeholder="{lang key="loginemail"}" value="{$formdata.email}">
                        </div>
                        <div class="form-group has-feedback">
                            <label for="inputPassword">{lang key="loginpassword"}</label>
                            <div class="input-password-strenght">
                                <input type="password" class="form-control" name="password" id="inputNewPassword1" data-error-threshold="{$pwStrengthErrorThreshold}" data-warning-threshold="{$pwStrengthWarningThreshold}" placeholder="{lang key="loginpassword"}" autocomplete="off" />
                                <span class="text-small text-lighter"><span id="passwordStrengthTextLabel">{$rslang->trans('login.at_least_pass')}</span><i data-toggle="tooltip" title="{$LANG.passwordtips}" data-html="true" data-container="body" class="ls ls-info-circle"></i></span>
                            </div>    
                            {include file="$template/includes/pwstrength.tpl"}
                        </div>
                        {if $accept_tos}
                            <label class="checkbox m-b-16">
                                <input type="checkbox" name="accept" id="accept" />
                                &nbsp;
                                {lang key='ordertosagreement'}
                                <a href="{$tos_url}" target="_blank">{lang key='ordertos'}</a>
                            </label>
                        {/if}
                        <div class="text-center margin-bottom">
                            {include file="$template/includes/captcha.tpl" captchaForm=$captchaFormRegister containerClass="form-group row" nocache}
                        </div>
                        <button type="submit" class="btn btn-primary btn-block btn-lg {$captcha->getButtonClass($captchaFormRegister)}">
                            {lang key="register"}
                        </button>
                    </form>
                {/if}
            {else}
                <div class="text-center m-b-16">
                    {include file="$template/assets/svg-icon/icon-website-time-maschine.tpl"}        
                </div>
                <h1 class="h2 text-center">{lang key="accountInvite.notFound"}</h1>
                <p class="text-center">{lang key="accountInvite.contactAdministrator"}</p>
                <a class="btn btn-primary btn-lg btn-block m-t-16" href="{$WEB_ROOT}/contact.php">{$LANG.contactus}</a>
            {/if}     
        </div>
        <div class="logincontainer-footer hidden" data-footer>
            <div class="text-light hidden" data-invite="login">{$rslang->trans('social.not_member')} <a href="#" data-show="register" tabindex="6">{$LANG.orderForm.createAccount}</a></div>
            <div class="text-light hidden" data-invite="register">{$rslang->trans('login.already_registered')} <a href="#" data-show="login"> {$rslang->trans('login.sign_in')}</a></div>
        </div>
    </div>  
    {if $languagechangeenabled && count($locales) > 1}
        {include file="$template/includes/language-chooser.tpl" type="login"}   
    {/if}    
</div>      
{literal}
    <script>
        $(document).ready(function(){
            let showBtn = $('[data-show]'),
                actions = $('[data-actions]'),
                footer = $('[data-footer]'),
                invite = $('[data-invite]');

            showBtn.on('click', function(e){
                e.preventDefault();
                let value = $(this).data('show');
                actions.addClass('hidden');
                footer.removeClass('hidden');
                invite.each(function(){
                    if ($(this).data('invite') == value){
                        $(this).removeClass('hidden');
                    }
                    else{
                        $(this).addClass('hidden');
                    }
                });
            })
        });
    </script>
{/literal}   
