<?php
use \WHMCS\Domain\Domain;
use \WHMCS\Database\Capsule;
use \WHMCS\Module\Registrar\HuReg\Logger;


$currentUser = new \WHMCS\Authentication\CurrentUser;
$client = $currentUser->client();

$errors = false;
$success = false;

if (isset($_POST['send_confirmation'])) {

    //TODO: clean
    //TODO: check owner

    $captcha = $_POST['captcha'];
    $domain_id = $_POST['domain_id'];
    $hureg_confirmations = Capsule::table('hureg_confirmations')->where('whmcs_domain_id', $domain_id)->first();

    $domain_object = Domain::where('id', $domain_id)->first();
    $domain_name = $domain_object->domain;


    $res = hureg_getApiInstance($vars)->domain()->send_confirmation(
        $hureg_confirmations->confirmation_id, $_SERVER["REMOTE_ADDR"], $captcha, date("Y-m-d H:i:s"), md5($hureg_confirmations->confirmation_text));

    if ($res["status"] == "error") {
        $errors = ["Hiba! Nem megfelelő captcha!"];

        Capsule::table('hureg_confirmations')->where('whmcs_domain_id', $domain_id)->delete();
        Logger::log_domain_event("error", "Unproper captcha was given for domain confirmation.", $res["error"], $domain_name);
        Logger::log_user_domain_event("error", "A domain nyilatkozat kitöltése közben hiba történt. (hibás captcha vagy belső hiba)",
            false, $domain_name);
        $conf = hureg_createConfirmationForDomainIfNotExists($vars, $domain_name);

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

$hureg_confirmations = Capsule::table('hureg_confirmations')->where('whmcs_client_id', $client->id)->get();


if ($conf[0] === -1) {

    $errors = ["Belső hiba történt!"];
}


$conf_details = [];

foreach ($hureg_confirmations as $hurc)
{
    //var_dump($hurc->confirmation_state);
    if ($hurc->confirmation_state == 1)
        continue;


    $domain_object = Domain::where('id', $hurc->whmcs_domain_id)->first();
    $domain_id = $domain_object->id;
    $domain_name = $domain_object->domain;

    $conf_details[] = [
            "domain_name" => $domain_name,
            "domain_id" => $domain_id,
            "confirmation_text" => $hurc->confirmation_text,
            "confirmation_captcha" => $hurc->confirmation_captcha
    ];

}
/*
if ($hureg_confirmations->confirmation_state == 1) {
    Header("Location: /" . 'clientarea.php?action=domaindetails&id=' . $domain_id);
    exit;
}

//TODO: csrf token
*/
$return_page = array(
    'pagetitle' => 'Domain nyilatkozat tömeges elfogadás',
    'breadcrumb' =>
        array(
            'index.php?m=hureg&page=bulk_domain_confirmation' => 'Domain nyilatkozat tömeges elfogadása'),
    'templatefile' => 'bulk_confirmation.tpl',
    'requirelogin' => true, # accepts true/false
    'forcessl' => false, # accepts true/false
    'vars' => array(
            "domain_confirmations" => $conf_details,
        "errors" => $errors,
        "success" => $success
    ),
);


?>
