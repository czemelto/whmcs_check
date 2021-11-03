{if $success}
    <div style="background-color:green;color:white;margin:0px auto;width:300px;text-align:center;">Sikeres domain
        nyilatkozattétel!
    </div>
{/if}
{if !$success}
    {if $errors}
        <div style="background-color:red;color:white;margin:0px auto;width:300px;text-align:center;">Nem sikerült a
            nyilatkozat beküldése! (Hibás captcha vagy belső hiba)
        </div>
    {/if}
{/if}


<table class="datatable">
    <tr>
        <th>Domain név</th>
        <th>Nyilatkozat szövege</th>
        <th>Kitöltés</th>
        <th></th>
    </tr>

    {foreach from=$domain_confirmations item=confirmation_details}
        <form method="post" action="index.php?m=hureg&page=bulk_domain_confirmation">
            <input type="hidden" name="domain_id" value="{$confirmation_details["domain_id"]}" />
            <input type="hidden" name="confirmation_text" value="{$confirmation_details["confirmation_text"]}" />


            <tr>
                <td >{$confirmation_details["domain_name"]}</td>
                <td><textarea cols="50" rows="5">{$confirmation_details["confirmation_text"]}</textarea></td>
                <td>
                    <img id="captcha_img" src="data:image/png;base64, {$confirmation_details["confirmation_captcha"]}" style="height:37px !important;margin-bottom:5px;"><br>
                    <input type="text" name="captcha" placeholder="CAPTCHA KÓD" style="height:37px !important;" id="captcha">
                </td>
                <td>
                    <input type="submit" name="send_confirmation" value="Kitöltés" style="height:37px !important;">
                </td>

            </tr>
        </form>
    {/foreach}


</table>
<script>
    (function() {
        document.getElementById('captcha').style.width = document.getElementById('captcha_img').offsetWidth;
    })();
</script>
