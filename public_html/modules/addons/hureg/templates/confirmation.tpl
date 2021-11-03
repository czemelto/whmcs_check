{if $success} <div style="background-color:green;color:white;margin:0px auto;width:300px;text-align:center;">Sikeres domain nyilatkozattétel!</div> {/if}
{if !$success}
    {if $errors}
        <div style="background-color:red;color:white;margin:0px auto;width:300px;text-align:center;">Nem sikerült a nyilatkozat beküldése! (Hibás captcha vagy belső hiba)</div>
    {/if}
<form method="post" action="index.php?m=hureg&page=single_domain_confirmation&domain_id={$domain_id}">
    <input type="hidden" name="id" value="{$domain_id}" />
    <input type="hidden" name="modop" value="custom" />
    <input type="hidden" name="a" value="hureg_confirmation" />
    <div>{$confirmation_text|unescape:'html'}</div><br>
    <img src="data:image/png;base64, {$confirmation_captcha}">
    <input type="text" name="captcha" placeholder="CAPTCHA KÓD" style="height:37px !important;">
    <input type="submit" name="send_confirmation" value="Nyilatkozat elküldése" style="margin-left:50px;">
    <div style="clear:both;margin-bottom:20px;"></div>
</form>
{/if}