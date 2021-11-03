<p class="text-lighter text-center text-small">{$LANG.pwresetsecurityquestionrequired}</p>

<form method="post" action="{routePath('password-reset-security-verify')}">
    <div class="form-group">
        <label for="inputAnswer">{$securityQuestion}</label>
        <input type="text" name="answer" class="form-control" id="inputAnswer" autofocus>
    </div>

    <button type="submit" class="btn btn-primary btn-block">{$LANG.pwresetsubmit}</button>
</form>
