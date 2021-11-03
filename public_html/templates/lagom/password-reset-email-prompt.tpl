<p class="text-lighter text-center text-small">{$LANG.pwresetemailneeded}</p>
<form method="post" action="{routePath('password-reset-validate-email')}" role="form">
    <input type="hidden" name="action" value="reset" />
    <div class="form-group">
        <label for="inputEmail">{$LANG.loginemail}</label>
        <input type="email" name="email" class="form-control input-lg" id="inputEmail" placeholder="{$LANG.enteremail}" autofocus>
    </div>
    {if $captcha->isEnabled()}
        <div class="text-center margin-bottom">
            {include file="$template/includes/captcha.tpl"}
        </div>
    {/if}    
    <button type="submit" class="btn btn-lg btn-primary btn-block{$captcha->getButtonClass($captchaForm)}">
        {$LANG.pwresetsubmit}
    </button>
</form>
