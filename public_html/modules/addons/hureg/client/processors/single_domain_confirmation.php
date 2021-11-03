<?php
use \WHMCS\Domain\Domain;
use \WHMCS\Database\Capsule;
use \WHMCS\Module\Registrar\HuReg\Logger;

//TODO: check owner
$domain_id = intval($_GET['domain_id']);

$domain_object = Domain::where('id', $domain_id)->first();
$domain_id = $domain_object->id;
$domain_name = $domain_object->domain;

$hureg_confirmations = Capsule::table('hureg_confirmations')->where('whmcs_domain_id', $domain_id)->first();


$currentUser = new \WHMCS\Authentication\CurrentUser;
$client = $currentUser->client();


if ($domain_object->clientId != $client->id) {
    echo "Not allowed!";
    exit;
}

$errors = false;
$success = false;

if (isset($_POST['send_confirmation'])) {

    //TODO: clean
    $captcha = $_POST['captcha'];
    $confirmation_txt = $hureg_confirmations->confirmation_text;

    $res = hureg_getApiInstance($vars)->domain()->send_confirmation(
        $hureg_confirmations->confirmation_id, $_SERVER["REMOTE_ADDR"], $captcha, date("Y-m-d H:i:s"), md5($confirmation_txt));

    if ($res["status"] == "error") {
        $errors = ["Hiba! Nem megfelelő captcha!"];

        Capsule::table('hureg_confirmations')->where('whmcs_domain_id', $domain_id)->delete();
        Logger::log_domain_event("error", "Unproper captcha was given for domain confirmation.", $res["error"], $domain_name);
        Logger::log_user_domain_event("error", "A domain nyilatkozat kitöltése közben hiba történt. (hibás captcha vagy belső hiba)",
            false, $domain_name);

    }
    if ($res["status"] == "success") {
        $success = true;

        $hr_conf = Capsule::table('hureg_confirmations')->where('id', $hureg_confirmations->id)->update(
            array('confirmation_State' => 1)
        );
        Logger::log_domain_event("success", "Sucessfully confirmed the domain.", false, $domain_name);
        Logger::log_user_domain_event("success", "A domain nyilatkozat sikeresen kitöltve! Nincs további teendő!",
            false, $domain_name);

    }
}


$conf = hureg_createConfirmationForDomainIfNotExists($vars, $domain_name);

if ($conf[0] === -1) {

    $errors = ["Belső hiba történt!"];
}


$hureg_confirmations = Capsule::table('hureg_confirmations')->where('whmcs_domain_id', $domain_id)->first();


if ($hureg_confirmations->confirmation_state == 1) {
    Header("Location: /" . 'clientarea.php?action=domaindetails&id=' . $domain_id);
    exit;
}
//TODO: csrf token
$hureg_confirmation_text = $hureg_confirmations->confirmation_text;
$hureg_confirmation_text = str_replace('--------------------------------------------------------------',
    '<hr style="border:1px solid #000;">', $hureg_confirmation_text);
$hureg_confirmation_text = str_replace('-',
    '<li>', $hureg_confirmation_text);

$return_page = array(
    'pagetitle' => 'Domain nyilatkozat elfogadása',
    'breadcrumb' =>
        array(
            'clientarea.php?action=domaindetails&id=' . $domain_id => $domain_object->domain,
            'index.php?m=hureg' => 'Nyilatkozat elfogadása'),
    'templatefile' => 'confirmation.tpl',
    'requirelogin' => true, # accepts true/false
    'forcessl' => false, # accepts true/false
    'vars' => array(
        'domain_id' => $domain_id,
        'confirmation_captcha' => $hureg_confirmations->confirmation_captcha,
        'confirmation_text' => $hureg_confirmation_text,
        'errors' => $errors,
        'success' => $success
    ),
);


?>
