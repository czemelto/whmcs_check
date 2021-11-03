<?php
/**
 * WHMCS SDK Sample Registrar Module Hooks File
 *
 * Hooks allow you to tie into events that occur within the WHMCS application.
 *
 * This allows you to execute your own code in addition to, or sometimes even
 * instead of that which WHMCS executes by default.
 *
 * WHMCS recommends as good practice that all named hook functions are prefixed
 * with the keyword "hook", followed by your module name, followed by the action
 * of the hook function. This helps prevent naming conflicts with other addons
 * and modules.
 *
 * For every hook function you create, you must also register it with WHMCS.
 * There are two ways of registering hooks, both are demonstrated below.
 *
 * @see https://developers.whmcs.com/hooks/
 *
 * @copyright Copyright (c) WHMCS Limited 2016
 * @license https://www.whmcs.com/license/ WHMCS Eula
 */

// Require any libraries needed for the module to function.
// require_once __DIR__ . '/path/to/library/loader.php';
//
// Also, perform any initialization required by the service's library.
use \WHMCS\Domain\Domain;
use WHMCS\Database\Capsule;
use \WHMCS\Billing\Invoice;
use \WHMCS\Billing\Invoice\Item;
use \WHMCS\User\Client\Contact;
use \WHMCS\User\Client;

require_once __DIR__ . '/vendor/autoload.php';

use WHMCS\Module\Registrar\HuReg\Config;
use WHMCS\Module\Registrar\HuReg\HuReg;
use WHMCS\Module\Registrar\HuReg\Logger;

require_once __DIR__ . '/vendor/autoload.php';

use Respect\Validation\Validator as v;


function hureg_get_user_id()
{
    $currentUser = new \WHMCS\Authentication\CurrentUser;
    $user_id = -1;
    if ($currentUser->isAuthenticatedUser()) {
        $user = $currentUser->user();
        $user_id = $user->id;
    }


    return $user_id;
}

function hureg_get_client_id()
{
    $currentUser = new \WHMCS\Authentication\CurrentUser;
    $user_id = -1;
    if ($currentUser->isAuthenticatedUser()) {
        $user = $currentUser->client();
        $user_id = $user->id;
    }


    return $user_id;
}


function add_new_contact($client_id, $data)
{
    $command = 'AddContact';
    $postData = array(
        'clientid' => $client_id,
        'firstname' => $data['firstname'],
        'lastname' => $data['lastname'],
        'email' => $data['email'],
        'phonenumber' => $data['phonenumber'],
        'address1' => $data['address1'],
        'address2' => $data['address2'],
        'city' => $data['city'],
        'state' => $data['state'],
        'postcode' => $data['postcode'],
        'country' => $data['country'],
        'tax_id' => $data['taxid'],
        'companyname' => $data['companyname']

    );

    $results = localAPI($command, $postData);
    return $results;

}

function add_new_contact_to_custom_table($user_id, $client_id, $contact_id, $contact_tax_type, $nic_type, $contact_type = 2)
{
    $select = $table = Capsule::table('hureg_contact_joiner')->where(
        [
            'whmcs_client_id' => $client_id,
            'whmcs_user_id' => $user_id,
            'whmcs_contact_id' => $contact_id,
            'contact_type' => $contact_type,
            'nic_type' => $nic_type
        ]
    )->first();

    if (count($select) == 0) {

        $table = Capsule::table('hureg_contact_joiner')->insert(
            [
                'whmcs_client_id' => $client_id,
                'whmcs_user_id' => $user_id,
                'whmcs_contact_id' => $contact_id,
                'contact_type' => $contact_type,
                'contact_tax_type' => $contact_tax_type,
                'nic_object_id' => -1,
                'nic_type' => $nic_type

            ]
        );
    }
}


function handle_after_shopping_cart($post, $vars, $cart, $uid = false, $cid = false)
{
    $domain_owner = $post['domainowner'];
    $domain_admin_contact = $post['contact'];


    $user_id = !$uid ? hureg_get_user_id() : $uid;
    $client_id = !$cid ? hureg_get_client_id() : $cid;

    if ($domain_owner == "addingnew") {

        $is_personal_registration = $post["domainowner_account_type"] == "personal";
        $alnum_regex = '/^[\p{L}\p{N} .-]+$/i';
        if ($post['domainownerfirstname'] == "" || !v::regex($alnum_regex)->validate($post['domainownerfirstname'])) {
            return ['error' => 'A domain tulajdonosi keresztnév mező üres vagy hibás formátumú!'];
        }
        if ($post['domainownerlastname'] == "" || !v::regex($alnum_regex)->validate($post['domainownerlastname'])) {
            return ['error' => 'A domain tulajdonosi vezetéknév mező üres vagy hibás formátumú!'];
        }
        if ($post['domainowneremail'] == "" || !v::email()->validate($post['domainowneremail'])) {
            return ['error' => 'A domain tulajdonosi email mező üres vagy hibás formátumú!'];
        }
        if ($post['domainownerphonenumber'] == "" || !v::phone()->validate($post['domainownerphonenumber'])) {
            return ['error' => 'A domain tulajdonosi telefonszám mező üres vagy hibás formátumú!'];
        }
        if ($post['domainowneraddress1'] == "" || !v::regex($alnum_regex)->validate($post['domainowneraddress1'])) {
            return ['error' => 'A címsor mező üres vagy hibás formátumú!'];
        }
        if ($post['domainowneraddress2'] == "" || !v::regex($alnum_regex)->validate($post['domainowneraddress2'])) {
            return ['error' => 'A házszám mező üres vagy hibás formátumú!'];
        }
        if ($post['city'] == "" || !v::regex($alnum_regex)->validate($post['city'])) {
            return ['error' => 'A város mező üres vagy hibás formátumú!'];
        }
        if ($post['state'] == "" || !v::regex($alnum_regex)->validate($post['state'])) {
            return ['error' => 'A megye mező üres vagy hibás formátumú!'];
        }
        if ($post['postcode'] == "" || !v::regex($alnum_regex)->validate($post['postcode'])) {
            return ['error' => 'Az irányítószám mező üres vagy hibás formátumú!'];
        }
        if ($post['country'] == "" || !v::regex($alnum_regex)->validate($post['country'])) {
            return ['error' => 'Az ország mező üres vagy hibás formátumú!'];
        }

        if ($is_personal_registration) {
            if ($post['domainowner_vat'] == "") {
                return ['error' => 'A személyi igazolvány szám mező nem lehet üres!'];
            }

            if (!v::regex('/^([A-Za-z0-9]+-)*[A-Za-z0-9]+$/i')->validate($post['domainowner_vat'])) {
                return ['error' => 'A személyi igazolvány szám mező hibás formátumú!'];
            }
        } else {
            if ($post['domainowner_vat'] == "") {
                return ['error' => 'Az adószám szám mező nem lehet üres!'];
            }

            if (!v::regex('/^([a-z0-9]+-)*[a-z0-9]+$/i')->validate($post['domainowner_vat'])) {
                return ['error' => 'Az adószám mező hibás formátumú!'];
            }
            if ($post['companyname'] == "" || !v::alnum('.', '-', ',', " ")->validate($post['companyname'])) {
                return ['error' => 'A cégnév mező üres vagy hibás formátumú!'];
            }
        }

    }

    if ($domain_admin_contact == "addingnew") {

        $is_personal_registration = $post["domaincontact_account_type"] == "personal";

        if ($is_personal_registration) {
            if ($post['domaincontacttax_id'] == "") {
                return ['error' => 'A személyi igazolvány szám mező nem lehet üres!'];
            }

            if (!v::regex('/^([a-z0-9]+-)*[a-z0-9]+$/i')->validate($post['domaincontacttax_id'])) {
                return ['error' => 'A személyi igazolvány szám mező hibás formátumú!'];
            }
        } else {
            if ($post['domaincontacttax_id'] == "") {
                return ['error' => 'Az adószám szám mező nem lehet üres!'];
            }

            if (!v::regex('/^([a-z0-9]+-)*[a-z0-9]+$/i')->validate($post['domainowner_vat'])) {
                return ['error' => 'Az adószám mező hibás formátumú!'];
            }
            if ($post['domaincontactcompanyname'] == "" || !v::alnum('.', '-', ',', " ")->validate($post['domaincontactcompanyname'])) {
                return ['error' => 'A cégnév mező üres vagy hibás formátumú!'];
            }
        }


    }


    //Adding new domain owner contact, if requested
    if ($domain_owner == "addingnew") {
        $data = [
            'firstname' => $post['domainownerfirstname'],
            'lastname' => $post['domainownerlastname'],
            'email' => $post['domainowneremail'],
            'phonenumber' => $post['domainownerphonenumber'],
            'address1' => $post['domainowneraddress1'],
            'address2' => $post['domainowneraddress2'],
            'city' => $post['domainownercity'],
            'state' => $post['domainownerstate'],
            'postcode' => $post['domainownerpostcode'],
            'country' => $post['domainownercountry'],
            'taxid' => $post['domainowner_vat'],
            'companyname' => $post["domainowner_account_type"] != "personal" ? $vars['domainownercompanyname'] : ""
        ];

        $res = add_new_contact($client_id, $data);

        if (!$res)
            return ['error' => 'Váratlan hiba történt az adatok feldolgozása közben!'];

        $domain_owner_contact_id = $res["contactid"];

        add_new_contact_to_custom_table(
            $user_id,
            $client_id,
            $domain_owner_contact_id,
            $post["domainowner_account_type"] == "personal" ? 1 : 2,
            1
        );
        add_new_contact_to_custom_table(
            $user_id,
            $client_id,
            $domain_owner_contact_id,
            $post["domainowner_account_type"] == "personal" ? 1 : 2,
            2
        );

    } else if ($domain_owner == "") {

        $account_type = $vars['companyname'] == "" ? 1 : 2;
        add_new_contact_to_custom_table(
            $user_id,
            $client_id,
            -1,
            $account_type,
            1,
            0
        );
        add_new_contact_to_custom_table(
            $user_id,
            $client_id,
            -1,
            $account_type,
            2,
            0
        );

    }


    //Adding new admin contact, if requested
    if ($domain_admin_contact == "addingnew") {
        // see ContactAdd hook...
    } else if ($domain_admin_contact == "") {
        $account_type = $vars['companyname'] == "" ? 1 : 2;
        add_new_contact_to_custom_table(
            $user_id,
            $client_id,
            -1,
            $account_type,
            2,
            0
        );
        add_new_contact_to_custom_table(
            $user_id,
            $client_id,
            -1,
            $account_type,
            1,
            0
        );


    } else if ($domain_admin_contact == "sameasdomainowner") {

        if ($domain_owner == "") {
            $account_type = $vars['companyname'] == "" ? 1 : 2;
            $contact_type = 0;
            $contact_id = -1;
        } else if ($domain_owner == "addingnew") {
            $account_type = $post["domainowner_account_type"] == "personal" ? 1 : 2;
            $contact_type = 2;
            $contact_id = $domain_owner_contact_id;
        } else if (is_numeric($domain_owner)) {
            $contact_object = Contact::where(['id' => $domain_owner, 'userid' => $client_id])->first();
            $account_type = $contact_object->companyName == "" ? 1 : 2;
            $contact_type = 2;
            $contact_id = $domain_owner;
        }
        add_new_contact_to_custom_table(
            $user_id,
            $client_id,
            $contact_id,
            $account_type,
            2,
            $contact_type
        );
    }


    foreach ($cart["domains"] as $domain) {
        $domain_name = $domain["domain"];
        $hureg_domain_form_datas = [
            'form_domain_name' => $domain_name,
            'whmcs_user_id' => $user_id,
            'whmcs_client_id' => $client_id,
            'admin_contact_type' => 0,
            'owner_contact_type' => 0,
            'admin_contact_id' => -1,
            'owner_contact_id' => -1
        ];

        //Domain owner form data filling

        if (is_numeric($domain_owner)) {
            //Meglévő contact használata

            $contact_object = Contact::where(['id' => $domain_owner, 'userid' => $client_id])->first();

            if (count($contact_object) != 1) {
                return ['error' => 'Hiba a kérés feldolgozása közben!'];
            }

            $hureg_domain_form_datas['owner_contact_type'] = 2;
            $hureg_domain_form_datas['owner_contact_id'] = $domain_owner; // if we not adding new contact, the incoming post data is int

        } else if ($domain_owner == "addingnew") {

            $hureg_domain_form_datas['owner_contact_type'] = 2;
            $hureg_domain_form_datas['owner_contact_id'] = $domain_owner_contact_id; // we previously selected the contact_id from the newly
            //  created record

        }

        //Domain admin form data filling
        //TODO: consistence $domain_admin_contact and $domain_owner
        if (is_numeric($domain_admin_contact)) {
            //Meglévő contact használata

            $contact_object = Contact::where(['id' => $domain_admin_contact, 'userid' => $client_id])->first();

            if (count($contact_object) != 1) {
                return ['error' => 'Hiba a kérés feldolgozása közben!'];
            }

            $hureg_domain_form_datas['admin_contact_type'] = 2;
            $hureg_domain_form_datas['admin_contact_id'] = $domain_admin_contact;

        } else if ($domain_admin_contact == "addingnew") {

            $hureg_domain_form_datas['admin_contact_type'] = 2;
            $hureg_domain_form_datas['admin_contact_id'] = -2;

            // If -2 is set, we are waiting for the contact add new hook to finalize the request

        } else if ($domain_admin_contact == "sameasdomainowner") {
            $hureg_domain_form_datas['admin_contact_type'] = $hureg_domain_form_datas['owner_contact_type'];
            $hureg_domain_form_datas['admin_contact_id'] = $hureg_domain_form_datas['owner_contact_id'];
        } else if ($domain_admin_contact == "") {
            $hureg_domain_form_datas['admin_contact_type'] = 0;
            $hureg_domain_form_datas['admin_contact_id'] = -1;
        }


        $table = Capsule::table('hureg_domain_form_datas')->insert(
            $hureg_domain_form_datas
        );


    }

}

add_hook('ShoppingCartValidateCheckout', 1, function ($vars) {

    try {

        $cart = $_SESSION['cart'];

        if (!array_key_exists("domains", $cart)) {
            return;
        }
        $user_id = hureg_get_user_id();
        $client_id = hureg_get_client_id();

        //TODO: validate form data

        if ($user_id != 0 && !is_null($user_id) && $user_id != -1) {
            return handle_after_shopping_cart($_POST, $vars, $cart, $user_id, $client_id);
        }

        //return ['error' => json_encode($vars)."--------".json_encode($_POST)];
        //TODO: only authenticated user works

        //TODO: not consistent variable naming

        //return ['error' => 'HIBA!'];
    } catch (Exception $e) {
        return ['error' => 'Váratlan hiba lépett fel! '];
    }
});

add_hook('AfterRegistrarRegistration', 1, function ($vars) {

    $vars = $vars["params"];
    $domain_name = $vars["domainname"];

    $domain_object = Domain::where('domain', $domain_name)->first();
    $domain_id = $domain_object->id;
    $form_domain_info = Capsule::table('hureg_domain_form_datas')->where('form_domain_name', $domain_name)->first();


    $domain_details = hureg_getApiInstance($vars)->domain()->get_details_by_domain_name(
        $domain_name
    );

    $domain_nic_id = $domain_details["success"]["data"]["COMMAND"]["ATTRIBUTES"][0]["DOMAIN"]["domain_hun_id"];

    $table = Capsule::table('hureg_additional_domain_informations')->insert(
        [
            'whmcs_domain_id' => $domain_id,
            'whmcs_client_id' => $domain_object->clientId,
            'whmcs_user_id' => $form_domain_info->whmcs_user_id,
            'is_transferred' => 0,
            'domain_nic_id' => $domain_nic_id,
            'hureg_status' => $domain_details["success"]["data"]["COMMAND"]["ATTRIBUTES"][0]["DOMAIN"]["domain_state_id"],
            'hureg_status_text' => $domain_details["success"]["data"]["COMMAND"]["ATTRIBUTES"][0]["DOMAIN"]["domain_state"]
        ]
    );

    $hureg_confirmations = Capsule::table('hureg_confirmations')->where('whmcs_domain_id', $domain_id)->get();

    if (count($hureg_confirmations) == 0) {

        $domain_details = hureg_getApiInstance($vars)->domain()->get_details_by_domain_name(
            $domain_name
        );

        $request_confirmation = hureg_getApiInstance($vars)->domain()->request_confirmation(
            $domain_details["success"]["data"]["COMMAND"]["ATTRIBUTES"][0]["DOMAIN"]["domain_owner_org_id"],
            $domain_details["success"]["data"]["COMMAND"]["ATTRIBUTES"][0]["DOMAIN"]["domain_hun_id"]
        );


        if ($request_confirmation["status"] != "success") {
            return ['error' => 'confirmation creation error after registration'];
        }

        $table = Capsule::table('hureg_confirmations')->insert(
            [
                'whmcs_domain_id' => $domain_id,
                'confirmation_id' => $request_confirmation["success"]["data"]["COMMAND"]["ATTRIBUTES"][0]["DECL"]["DECL_ID"],
                'confirmation_text' => mb_convert_encoding($request_confirmation["success"]["data"]["COMMAND"]["ATTRIBUTES"][0]["DECL"]["DECL_TEXT"], 'UTF-8'),
                'confirmation_captcha' => mb_convert_encoding($request_confirmation["success"]["data"]["COMMAND"]["ATTRIBUTES"][0]["DECL"]["DECL_CAPTCHA"], 'UTF-8'),
                'confirmation_state' => 2,
                'whmcs_client_id' => $domain_object->clientId,
                'whmcs_user_id' => $form_domain_info->whmcs_user_id,
            ]
        );

    }


    $hr_conf = Domain::where('domain', $domain_name)->update(
        [
            'registrationPeriod' => 1
        ]
    );

    Logger::log_user_domain_event("info", "Kitöltésre váró nyilatkozat lett generálva a domainhez.",
        false, $domain_name);


});

add_hook('AfterRegistrarTransfer', 1, function ($vars) {

    $vars = $vars["params"];
    $domain_name = $vars["domainname"];

    $domain_object = Domain::where('domain', $domain_name)->first();
    $domain_id = $domain_object->id;
    $form_domain_info = Capsule::table('hureg_domain_form_datas')->where('form_domain_name', $domain_name)->first();


    $domain_details = hureg_getApiInstance($vars)->domain()->get_details_by_domain_name(
        $domain_name
    );

    //ITT azért van 1-es a tömbnél, mert 2 elemű tömböt ad vissza, az első elem a másik regisztrátornál lévő domain
    // a második elem az itt lévő domain

    $domain_nic_id = $domain_details["success"]["data"]["COMMAND"]["ATTRIBUTES"][1]["DOMAIN"]["domain_hun_id"];

    $table = Capsule::table('hureg_additional_domain_informations')->insert(
        [
            'whmcs_domain_id' => $domain_id,
            'whmcs_client_id' => $domain_object->clientId,
            'whmcs_user_id' => $form_domain_info->whmcs_user_id,
            'is_transferred' => 1,
            'domain_nic_id' => $domain_nic_id,
            'hureg_status' => $domain_details["success"]["data"]["COMMAND"]["ATTRIBUTES"][1]["DOMAIN"]["domain_state_id"],
            'hureg_status_text' => $domain_details["success"]["data"]["COMMAND"]["ATTRIBUTES"][1]["DOMAIN"]["domain_state"]
        ]
    );


});

function handle_contact_or_client_edit($vars, $type = false)
{
    $hureg_login_data = Config::get_credentials_in_plaintext();
    function hureg_getApiInstance($p)
    {
        $api_endpoint = Config::get_endpoint_by_type($p["api_endpoint"]);
        return new HuReg($p["api_username"], $p["api_password"], $p["public_key_fingerprint"], $api_endpoint, false);

    }

    if (!isset($_POST['contact_manage_from_form']) && $type != "billingedit") {
        return;
    }

    $user_id = hureg_get_user_id();
    $client_id = hureg_get_client_id();

    if (array_key_exists("contactid", $vars))
        $contact_id = $vars['contactid'];
    else
        $contact_id = -1;


    $contact_tax_type = $vars['companyname'] == "" ? 1 : 2;


    $select = $table = Capsule::table('hureg_contact_joiner')->where(
        [
            'whmcs_client_id' => $client_id,
            'whmcs_user_id' => $user_id,
            'whmcs_contact_id' => $contact_id,
            'contact_tax_type' => $contact_tax_type,
        ]
    )->get();

    foreach ($select as $contact_item) {
        if ($contact_item->nic_object_id != -1) {

            if ($contact_item->nic_type == 1) {

                $data = [
                    'owner_nic_id' => $contact_item->nic_object_id,
                    'phone_number' => $vars['phonenumber'],
                    'address1' => $vars['address1'],
                    'address2' => $vars['address2'],
                    'city' => $vars['city'],
                    'postcode' => $vars['postcode'],
                    'country' => $vars['country'],
                ];
                $res = hureg_getApiInstance($hureg_login_data)->person()->modify_owner_by_data(
                    $data
                );

            } else if ($contact_item->nic_type == 2) {
                $data = [
                    'admin_nic_id' => $contact_item->nic_object_id,
                    'phone_number' => $vars['phonenumber'],
                    'address1' => $vars['address1'],
                    'address2' => $vars['address2'],
                    'city' => $vars['city'],
                    'postcode' => $vars['postcode'],
                    'country' => $vars['country'],
                ];
                $res = hureg_getApiInstance($hureg_login_data)->person()->modify_admin_by_data(
                    $data
                );

            }

        }

    }

}

add_hook('ContactAdd', 1, function ($vars) {

    $cart = [];
    if (isset($_SESSION['cart'])) {
        $cart = $_SESSION['cart'];
    }

    $general_contact_id = $vars["contactid"];

    if (array_key_exists("domains", $cart) && !isset($_POST['contact_manage_from_form'])) {

        $currentUser = new \WHMCS\Authentication\CurrentUser;

        $user_id = hureg_get_user_id();
        $client_id = hureg_get_client_id();

        $domain_admin_contact = $_POST['contact'];
        $domain_owner = $_POST['domainowner'];


        // adding new admin contact to database and filling data for domain registration/transfer
        if ($domain_admin_contact == "addingnew") {

            $domain_admin_contact_id = $vars["contactid"];

            add_new_contact_to_custom_table(
                $user_id,
                $client_id,
                $domain_admin_contact_id,
                $_POST["domaincontact_account_type"] == "personal" ? 1 : 2,
                2
            );
            add_new_contact_to_custom_table(
                $user_id,
                $client_id,
                $domain_admin_contact_id,
                $_POST["domaincontact_account_type"] == "personal" ? 1 : 2,
                1
            );

            foreach ($cart["domains"] as $domain) {
                $domain_name = $domain["domain"];

                $hureg_domain_form_datas_db = Capsule::table('hureg_domain_form_datas')->where(["form_domain_name" => $domain_name])->first();

                $hureg_domain_form_datas = [
                    'form_domain_name' => $hureg_domain_form_datas_db->form_domain_name,
                    'whmcs_client_id' => $client_id,
                    'whmcs_user_id' => $user_id,
                    'admin_contact_type' => $hureg_domain_form_datas_db->admin_contact_type,
                    'owner_contact_type' => $hureg_domain_form_datas_db->owner_contact_type,
                    'admin_contact_id' => $hureg_domain_form_datas_db->admin_contact_id,
                    'owner_contact_id' => $hureg_domain_form_datas_db->owner_contact_id
                ];

                //Domain admin form data filling
                //TODO: consistence $domain_admin_contact and $domain_owner
                if ($domain_admin_contact == "addingnew") {

                    $hureg_domain_form_datas['admin_contact_type'] = 2;
                    $hureg_domain_form_datas['admin_contact_id'] = $domain_admin_contact_id;


                    // We are setting the -2- value here to the domain admin contact id

                }
                $table = Capsule::table('hureg_domain_form_datas')->where(["form_domain_name" => $domain_name])->update($hureg_domain_form_datas);

            }
        }

    } else {
        $contact_id = $vars["contactid"];
        $user_id = hureg_get_user_id();
        $client_id = hureg_get_client_id();

        add_new_contact_to_custom_table(
            $user_id,
            $client_id,
            $contact_id,
            $_POST["domaincontact_account_type"] == "personal" ? 1 : 2,
            1
        );
        add_new_contact_to_custom_table(
            $user_id,
            $client_id,
            $contact_id,
            $_POST["domaincontact_account_type"] == "personal" ? 1 : 2,
            2
        );
    }


});

add_hook('ContactEdit', 1, function ($vars) {
    handle_contact_or_client_edit($vars);
});

add_hook('ClientEdit', 1, function ($vars) {
    handle_contact_or_client_edit($vars, "billingedit");
});


/*
 *  0 | Törölt
    1 | Előjegyzett
    2 | Ellenőrzés
    3 | Előzetes hiányos
    4 | Előzetes elutasítva
    5 | TT elé utólag
    8 | Delegált
    9 | Módosítás kérés (ellenőrzés előtt)
    10 | Módosítás kérés hiányos
    23 | Előzetes
    24 | Hiány pótolva
    25 | Módostás kérés
    26 | Elbírálás
    27 | Bejegyezhető
    28 | TT elé
    29 | TT előtt
    30 | Felmondás
    31 | Felmondás, név zónából törölve
    32 | Törlés előtti parkolás
    33 | Felfüggesztve
    34 | Műszaki hiba
    35 | Bejegyzett feltételes használat
    36 | Panaszra vár
    37 | Panasz beküldve
    38 | Panasz TT előtt
    39 | Törlésre előjegyezve
    40 | Panasz TT előtt, név zónából törölve
    41 | TT miatti törlés
 */

add_hook('ClientAreaPageDomainDetails', 1, function ($vars) {
    $extra = array();

    $domain_id = $vars["domainid"];
    $domain_name = $vars['domain'];
    $s = $table = Capsule::table('hureg_additional_domain_informations')->where(
        [
            'whmcs_domain_id' => $domain_id
        ]
    )->first();

    if (in_array($s->hureg_status, [30, 31, 32, 39,])) {
        $text = "Felmondás alatt";
        $color = "label-danger"; //label-danger(red), label-success (green), label-inprogress (orange),label-info (blue)
    } else if (in_array($s->hureg_status, [0, 4, 33, 34, 40, 41])) //red
    {
        $text = $s->hureg_status_text;
        $color = "label-danger";
    } else if (in_array($s->hureg_status, [1, 2, 3, 5, 9, 10, 23, 24, 25, 26, 28, 29, 36, 37, 38])) { //orange
        $text = $s->hureg_status_text;
        $color = "label-inprogress";
    } else if (in_array($s->hureg_status, [8, 27, 35])) //green
    {
        $text = $s->hureg_status_text;
        $color = "label-success";
    }

    $extra['domain_hureg_status'] = $text;
    $extra['domain_hureg_status_color'] = $color;

    // Domain owner id && domain contact id
    $d = $table = Capsule::table('hureg_domain_form_datas')->where(
        [
            'form_domain_name' => $domain_name
        ]
    )->first();

    $dlogs = $table = Capsule::table('hureg_domain_logs')->where(
        [
            'event_side' => 'user',
            'form_domain_name' => $domain_name
        ])->get();
    $extra['domainlogs'] = $dlogs;

    if ($d) {
        $extra['owner_contact_id'] = $d->owner_contact_id;
        $extra['admin_contact_id'] = $d->admin_contact_id;
        $extra['owner_contact_type'] = $d->owner_contact_type;
        $extra['admin_contact_type'] = $d->admin_contact_type;
    }

    return $extra;
});

add_hook('ClientAreaPageDomains', 1, function ($vars) {
    $hureg_login_data = Config::get_credentials_in_plaintext();


    $extra = array();


    $client_id = $vars["client"]->id;

    $select = Capsule::table('hureg_additional_domain_informations')->where(
        [
            'whmcs_client_id' => $client_id
        ]
    )->get();


    foreach ($select as $s) {

        $hureg_confirmations = Capsule::table('hureg_confirmations')->where('whmcs_domain_id', $s->whmcs_domain_id)->first();

        if (in_array($s->hureg_status, [30, 31, 32, 39,])) {
            $text = "Felmondás alatt";
            $color = "unpaid"; //expired (gray), active(green), unpaid (red), inprogress (orange)
        } else if (in_array($s->hureg_status, [0, 4, 33, 34, 40, 41])) //red
        {
            $text = $s->hureg_status_text;
            $color = "unpaid";
        } else if (in_array($s->hureg_status, [1, 2, 3, 5, 9, 10, 23, 24, 25, 26, 28, 29, 36, 37, 38])) { //orange
            $text = $s->hureg_status_text;
            $color = "inprogress";
        } else if (in_array($s->hureg_status, [8, 27, 35])) //green
        {
            $text = $s->hureg_status_text;
            $color = "active";
        }

        $confirmation_is_required = true;

        if (count($hureg_confirmations) === 0 || $s->is_transferred === 1) {
            $confirmation_color = "expired";
            $confirmation_text = "Nem szükséges";
            $confirmation_is_required = false;

        } else if ($hureg_confirmations->confirmation_state === 0 || $hureg_confirmations->confirmation_state === 2) {
            $confirmation_color = "unpaid";
            $confirmation_text = "Nyilatkozat nincs kitöltve";
        } else if ($hureg_confirmations->confirmation_state === 1) {
            $confirmation_color = "active";
            $confirmation_text = "Kitöltve";
        }

        $extra['hureg_details'][$s->whmcs_domain_id]['status_text'] = $text;
        $extra['hureg_details'][$s->whmcs_domain_id]['status_color'] = $color;

        $extra['hureg_details'][$s->whmcs_domain_id]['confirmation_status_color'] = $confirmation_color;
        $extra['hureg_details'][$s->whmcs_domain_id]['confirmation_status_text'] = $confirmation_text;
        $extra['hureg_details'][$s->whmcs_domain_id]['confirmation_is_required'] = $confirmation_is_required;


        $extra['hureg_details']['domain_ids'][] = $s->whmcs_domain_id;


    }

    return $extra;

});


add_hook('ClientAdd', 1, function ($vars) {

    $cart = [];
    if (isset($_SESSION['cart'])) {
        $cart = $_SESSION['cart'];
    } else {
        return;
    }

    //TODO: only run if, "domains" key in cart

    return handle_after_shopping_cart($_POST, $vars, $cart, $vars["user_id"], $vars['client_id']);


});


add_hook('InvoicePaid', 1, function ($vars) {

    $invoice_item_objects = Item::where('invoiceId', $vars["invoiceid"])->get();
    $send_email = false;

    foreach ($invoice_item_objects as $ivo) {
        if ($ivo["type"] == "DomainRegister") {
            $send_email = true;
            $relid = $ivo["relid"];
        }
    }

    if ($send_email) {
        $command = 'SendEmail';
        $postData = array(
            'messagename' => '.hu Domain nyilatkozat email',
            'id' => $relid,
            'customtype' => 'domain',
            'customsubject' => 'Kitöltésre váró .hu domain nyilatkozatok',
            'custommessage' => 'Kedves ügyfelünk! <br> Kitöltésre váró domain nyilatkozataid vannak,amelyeket az alábbi linkre kattintva tudsz megtekinteni: <a href="https://dev-whmcs.mediaplatz.com/clientarea.php?action=domains">Megtekintés</a> ',
            'customvars' => "",
        );

        $results = localAPI($command, $postData);
    }
});
