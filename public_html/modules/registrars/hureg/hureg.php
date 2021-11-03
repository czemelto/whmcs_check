<?php
/**
 * WHMCS SDK Sample Registrar Module
 *
 * Registrar Modules allow you to create modules that allow for domain
 * registration, management, transfers, and other functionality within
 * WHMCS.
 *
 * This sample file demonstrates how a registrar module for WHMCS should
 * be structured and exercises supported functionality.
 *
 * Registrar Modules are stored in a unique directory within the
 * modules/registrars/ directory that matches the module's unique name.
 * This name should be all lowercase, containing only letters and numbers,
 * and always start with a letter.
 *
 * Within the module itself, all functions must be prefixed with the module
 * filename, followed by an underscore, and then the function name. For
 * example this file, the filename is "hureg.php" and therefore all
 * function begin "hureg_".
 *
 * If your module or third party API does not support a given function, you
 * should not define the function within your module. WHMCS recommends that
 * all registrar modules implement Register, Transfer, Renew, GetNameservers,
 * SaveNameservers, GetContactDetails & SaveContactDetails.
 *
 * For more information, please refer to the online documentation.
 *
 * @see https://developers.whmcs.com/domain-registrars/
 *
 * @copyright Copyright (c) WHMCS Limited 2017
 * @license https://www.whmcs.com/license/ WHMCS Eula
 */

//namespace WHMCS\Module\Registrar\Registrarmodule;


if (!defined("WHMCS")) {
    die("This file cannot be accessed directly");
}


// Require any libraries needed for the module to function.
require_once __DIR__ . '/vendor/autoload.php';

use \WHMCS\Domain\Domain;
use WHMCS\Database\Capsule;


use WHMCS\Domains\DomainLookup\ResultsList;
use WHMCS\Domains\DomainLookup\SearchResult;

use WHMCS\Module\Registrar\HuReg\Config;
use WHMCS\Module\Registrar\HuReg\HuReg;
use WHMCS\Module\Registrar\HuReg\Logger;


// Also, perform any initialization required by the service's library.

/**
 * Define module related metadata
 *
 * Provide some module information including the display name and API Version to
 * determine the method of decoding the input values.
 *
 * @return array
 */
function hureg_MetaData()
{

    return Config::get_module_metadata();

}

/**
 * Define registrar configuration options.
 *
 * The values you return here define what configuration options
 * we store for the module. These values are made available to
 * each module function.
 *
 * You can store an unlimited number of configuration settings.
 * The following field types are supported:
 *  * Text
 *  * Password
 *  * Yes/No Checkboxes
 *  * Dropdown Menus
 *  * Radio Buttons
 *  * Text Areas
 *
 * @return array
 */
function hureg_getConfigArray()
{
    return Config::get_module_admin_settings();
}

function hureg_getApiInstance($p)
{
    $api_endpoint = Config::get_endpoint_by_type($p["api_endpoint"]);
    return new HuReg($p["api_username"], $p["api_password"], $p["public_key_fingerprint"], $api_endpoint, false);

}

/**
 * Register a domain.
 *
 * Attempt to register a domain with the domain registrar.
 *
 */

function hureg_createContactPersonsByDomainName($domain_name, $params)
{
    $contacts = Capsule::table('hureg_domain_form_datas')->where('form_domain_name', $domain_name)->first();


    //OWNER CREATION
    $hureg_owner_contacts = Capsule::table('hureg_contact_joiner')->where(
        [
            'whmcs_client_id' => $contacts->whmcs_client_id,
            'whmcs_user_id' => $contacts->whmcs_user_id,
            'whmcs_contact_id' => $contacts->owner_contact_id,
            'contact_type' => $contacts->owner_contact_type,
            'nic_type' => 1
        ])->first();

    if ($hureg_owner_contacts->nic_object_id == -1) {
        if ($hureg_owner_contacts->contact_type == 2) {

            $res = hureg_getApiInstance($params)->person()->insert_new_owner_by_contact_id_and_type(
                $contacts->owner_contact_id, $hureg_owner_contacts->contact_tax_type
            );

            if ($res["status"] == "error") {
                Logger::log_domain_event("error", "The domain contact owner contact creation was not successful. Hureg request failed.",
                    $res["error"], $domain_name);

                return false;
            }

            $nic_owner_object_id = $res["success"]["data"]["COMMAND"]["ATTRIBUTES"]["MESSAGE"]["text"];

            if (!is_null($nic_owner_object_id)) {
                $hureg_contacts = Capsule::table('hureg_contact_joiner')->where(
                    ['whmcs_contact_id' => $contacts->owner_contact_id,
                        'whmcs_client_id' => $contacts->whmcs_client_id,
                        'whmcs_user_id' => $contacts->whmcs_user_id,
                        'nic_type' => 1,
                        'contact_type' => $contacts->owner_contact_type,
                    ]
                )->update(
                    ['nic_object_id' => $nic_owner_object_id]
                );


            }
        } else if ($hureg_owner_contacts->contact_type == 0) {

            //TODO: ha owner contact type == 0 , akkor hozza létre a számlázási adatok nic objektumát

            $res = hureg_getApiInstance($params)->person()->insert_new_owner_by_client_id_and_type(
                $contacts->whmcs_client_id, $hureg_owner_contacts->contact_tax_type
            );

            if ($res["status"] == "error") {
                Logger::log_domain_event("error", "The domain billing owner contact creation was not successful. Hureg request failed.",
                    $res["error"], $domain_name);
                return false;
            }

            $nic_owner_object_id = $res["success"]["data"]["COMMAND"]["ATTRIBUTES"]["MESSAGE"]["text"];

            if (!is_null($nic_owner_object_id)) {
                $hureg_contacts = Capsule::table('hureg_contact_joiner')->where(
                    ['whmcs_contact_id' => -1,
                        'whmcs_client_id' => $contacts->whmcs_client_id,
                        'whmcs_user_id' => $contacts->whmcs_user_id,
                        'nic_type' => 1,
                        'contact_type' => $contacts->owner_contact_type,
                    ])->update(
                    ['nic_object_id' => $nic_owner_object_id]
                );
            }

        }


    }

    //ADMIN CREATION
    $hureg_admin_contacts = Capsule::table('hureg_contact_joiner')->where(
        [
            'whmcs_client_id' => $contacts->whmcs_client_id,
            'whmcs_user_id' => $contacts->whmcs_user_id,
            'whmcs_contact_id' => $contacts->admin_contact_id,
            'nic_type' => 2,
            'contact_type' => $contacts->admin_contact_type,
        ])->first();

    if ($hureg_admin_contacts->nic_object_id == -1) {
        if ($hureg_admin_contacts->contact_type == 2) {
            $res = hureg_getApiInstance($params)->person()->insert_new_admin_by_contact_id(
                $contacts->admin_contact_id
            );

            if ($res["status"] == "error") {
                Logger::log_domain_event("error", "The domain contact admin contact creation was not successful. Hureg request failed.",
                    $res["error"], $domain_name);
                return false;
            }


            $nic_admin_object_id = $res["success"]["data"]["COMMAND"]["ATTRIBUTES"]["MESSAGE"]["text"];

            if (!is_null($nic_admin_object_id)) {
                $hureg_contacts = Capsule::table('hureg_contact_joiner')->where(
                    ['whmcs_contact_id' => $contacts->admin_contact_id,
                        'nic_type' => 2,
                        'whmcs_client_id' => $contacts->whmcs_client_id,
                        'whmcs_user_id' => $contacts->whmcs_user_id,
                        'contact_type' => $contacts->admin_contact_type,
                    ]
                )->update(
                    ['nic_object_id' => $nic_admin_object_id]
                );
            } else {
                return false;
            }

        } else if ($hureg_admin_contacts->contact_type == 0) {
            $res = hureg_getApiInstance($params)->person()->insert_new_admin_by_client_id(
                $contacts->whmcs_client_id
            );

            if ($res["status"] == "error") {
                Logger::log_domain_event("error", "The domain billing admin contact creation was not successful. Hureg request failed.",
                    $res["error"], $domain_name);
                return false;
            }

            $nic_admin_object_id = $res["success"]["data"]["COMMAND"]["ATTRIBUTES"]["MESSAGE"]["text"];

            if (!is_null($nic_admin_object_id)) {
                $hureg_contacts = Capsule::table('hureg_contact_joiner')->where(
                    ['whmcs_contact_id' => -1,
                        'whmcs_client_id' => $contacts->whmcs_client_id,
                        'whmcs_user_id' => $contacts->whmcs_user_id,
                        'nic_type' => 2,
                        'contact_type' => $contacts->admin_contact_type,
                    ])->update(
                    ['nic_object_id' => $nic_admin_object_id]
                );
            } else {
                return false;
            }

        }


    }
    Logger::log_domain_event("success", "The domain contacts were validated or created successfully.",
        false, $domain_name);

    return true;
}

function hureg_RegisterDomain($params)
{

    $domain_name = implode(".", [$params["sld"], $params["tld"]]);
    $r = hureg_createContactPersonsByDomainName($domain_name, $params);


    if (!$r) {

        Logger::log_domain_event("error", "The domain registration was not successful. The contact data couldn't be saved.", false, $domain_name);
        Logger::log_user_domain_event("error", "A Domain regisztráció során nem sikerült a kapcsolattartói adatok felvitele! (hibás adatok vagy belső hiba)",
            false, $domain_name);

        return ['error' => 'Hiba a domain regisztráció közben! Nem sikerült a contact adatok felvétele!'];
    }

    $contacts = Capsule::table('hureg_domain_form_datas')->where('form_domain_name', $domain_name)->first();
    $hureg_owner_contacts = Capsule::table('hureg_contact_joiner')->where(
        ['whmcs_contact_id' => $contacts->owner_contact_id,
            'whmcs_client_id' => $contacts->whmcs_client_id,
            'whmcs_user_id' => $contacts->whmcs_user_id,
            'nic_type' => 1
        ])->first();
    $hureg_admin_contacts = Capsule::table('hureg_contact_joiner')->where(
        ['whmcs_contact_id' => $contacts->admin_contact_id,
            'whmcs_client_id' => $contacts->whmcs_client_id,
            'whmcs_user_id' => $contacts->whmcs_user_id,
            'nic_type' => 2
        ])->first();

    $hureg_owner_nic_id = $hureg_owner_contacts->nic_object_id;
    $hureg_admin_nic_id = $hureg_admin_contacts->nic_object_id;


    $res = hureg_getApiInstance($params)->domain()->new_domain(
        $domain_name, $params, $hureg_owner_nic_id, $hureg_admin_nic_id
    );

    if ($res["status"] == "error") {
        Logger::log_domain_event("error", "The domain registration was not successful. Cannot create new domain on hureg", $res["error"], $domain_name);
        Logger::log_user_domain_event("error", "Váratlan hiba történt domain regisztráció közben! A regisztráció sikertelen!",
            false, $domain_name);
        return array(
            'error' => "Hiba történt a domain regisztrációja során!",
        );

        //TODO: log error
    }
    Logger::log_domain_event("success", "The domain registration was successful.", false, $domain_name);
    Logger::log_user_domain_event("success", "A domain sikeresen regisztrálva lett!",
        false, $domain_name);
    return array("success" => "Sikeres domain regisztráció!");
}

/**
 * Initiate domain transfer.
 *
 * Attempt to create a domain transfer request for a given domain.
 *
 */
function hureg_TransferDomain($params)
{

    $domain_name = implode(".", [$params["sld"], $params["tld"]]);
    $r = hureg_createContactPersonsByDomainName($domain_name, $params);


    if (!$r) {
        Logger::log_domain_event("error", "The domain transfer was not successful. The contact data couldn't be saved.", false, $domain_name);
        Logger::log_user_domain_event("error", "A Domain transzfer során nem sikerült a kapcsolattartói adatok felvitele (hibás adatok vagy belső hiba)",
            false, $domain_name);
        return ['error' => 'Hiba a domain transzferje közben! Nem sikerült a contact adatok felvétele!'];
    }

    $contacts = Capsule::table('hureg_domain_form_datas')->where('form_domain_name', $domain_name)->first();
    $hureg_owner_contacts = Capsule::table('hureg_contact_joiner')->where(
        ['whmcs_contact_id' => $contacts->owner_contact_id,
            'nic_type' => 1
        ])->first();
    $hureg_admin_contacts = Capsule::table('hureg_contact_joiner')->where(
        ['whmcs_contact_id' => $contacts->admin_contact_id,
            'nic_type' => 2
        ])->first();

    $hureg_owner_nic_id = $hureg_owner_contacts->nic_object_id;
    $hureg_admin_nic_id = $hureg_admin_contacts->nic_object_id;

    $domain_details = hureg_getApiInstance($params)->domain()->get_details_by_domain_name(
        $domain_name
    );

    if ($domain_details["status"] == "error") {
        Logger::log_domain_event("error", "The domain transfer was not successful. Cannot transfer a new domain on hureg", $domain_details["error"], $domain_name);
        Logger::log_user_domain_event("error", "A Domain transzfer során váratlan hinba történt. A transzfer indítása sikertelen!",
            false, $domain_name);
        return array(
            'error' => "Hiba történt a domain átregisztrációja során!",
        );
        //TODO: log error
    }

    $domain_id = $domain_details["success"]["data"]["COMMAND"]["ATTRIBUTES"][0]["DOMAIN"]["domain_hun_id"];
    try {

        $res = hureg_getApiInstance($params)->domain()->transfer_domain(
            $params, $domain_id, $hureg_owner_nic_id, $hureg_admin_nic_id
        );

        if ($res["status"] == "error") {
            Logger::log_domain_event("error", "The domain transfer was not successful. Cannot transfer a new domain on hureg",
                $res["error"], $domain_name, $domain_id);
            Logger::log_user_domain_event("error", "A Domain transzfer során váratlan hinba történt. A transzfer indítása sikertelen!",
                false, $domain_name, $domain_id);

            return array(
                'error' => "Hiba történt a domain átregisztrációja során!",
            );
            //TODO: log error
        }


    } catch (Exception $e) {
        Logger::log_domain_event("exception", "The domain transfer was not successful. Cannot transfer a new domain on hureg",
            $e, $domain_name, $domain_id);
        Logger::log_user_domain_event("error", "A Domain transzfer során váratlan hinba történt. A transzfer indítása sikertelen!",
            false, $domain_name, $domain_id);

        return array(
            'error' => "Hiba történt a domain átregisztrációja során!",
        );
    }

    Logger::log_domain_event("success", "The domain transfer initialization was successful.", false, $domain_name, $domain_id);
    Logger::log_user_domain_event("success", "A domain transzfer folyamat sikeresen elindítva!",
        false, $domain_name);

    return array("success" => "Sikeresen elindult a domain átregisztrációs folyamat!");


}

/**
 * Renew a domain.
 *
 * Attempt to renew/extend a domain for a given number of years.
 *
 */

function hureg_RenewDomain($params)
{
    try {

        $domain_object = Domain::where('domain', $params['domainname'])->first();
        $domain_name = $params['domainname'];
        $select = Capsule::table('hureg_additional_domain_informations')->where(
            [
                'whmcs_domain_id' => $domain_object->id
            ]
        )->first();

        if (!$select) {
            $error = Logger::log_domain_event("error", "Cannot select domain from additional domain informations_table on domain synchronization.", false, $domain_name);
            Logger::log_user_domain_event("success", "A domain megújítás sikertelen volt! (belső hiba)",
                false, $params["domainname"]);

            return array(
                'error' => "Sikertelen megújítás! (belső hiba)",
            );
        }

        $ren_ret = renew_domain($params,$select,$domain_name);

        if ($ren_ret == 0)
        {
            $exp_process = 0;
        }
        else {
            return $ren_ret;
        }

        $ret = update_domain_status_in_database($params,$select,$domain_name,$domain_object,$exp_process);

        if (is_array($ret))
        {
            Logger::log_user_domain_event("success", "A domain megújítás sikertelen volt! (belső hiba)",
                false, $params["domainname"]);

            return array(
                'error' => "Sikertelen megújítás! (belső hiba)",
            );
        }
        $error = Logger::log_domain_event("success", "Successful domain renew.",false, $domain_name);

        Logger::log_user_domain_event("success", "A domain megújítás sikeresen teljesítve!",
            false, $params["domainname"]);

    } catch (Exception $e) {
        $error = Logger::log_domain_event("exception", "unsuccessful domain renew.", $e->getMessage(), $domain_name);

        Logger::log_user_domain_event("error", "A domain megújítás sikertelen volt! (belső hiba)",
            false, $params["domainname"]);

        return array(
            'error' => $e->getMessage(),
        );

    }
}

/**
 * Fetch current nameservers.
 *
 * This function should return an array of nameservers for a given domain.
 */
function hureg_GetNameservers($params)
{

    $res = hureg_getApiInstance($params)->domain()->get_details_by_domain_name($params["domainname"]);

    if ($res["status"] != "success") {
        Logger::log_domain_event("error", "Cannot get domain nameservers from hureg. Hureg error", $res["error"], $params["domainname"]);

        return ["error" => "Váratlan hiba történt!"];
    }

    $nses = $res["success"]["data"]["COMMAND"]["ATTRIBUTES"][0]["DOMAIN"]["domain_sec_ns"];
    $nses = trim($nses, '|');
    $ns2s = explode('|', $nses);


    $arr = array(
        'ns1' => $res["success"]["data"]["COMMAND"]["ATTRIBUTES"][0]["DOMAIN"]["domain_pri_ns"],
    );

    if (count($ns2s) > 0) {

        $counter = 2;
        foreach ($ns2s as $ns) {
            $arr["ns" . $counter] = $ns;
            $counter++;
        }

    }
    return $arr;


}

/**
 * Save nameserver changes.
 *
 * This function should submit a change of nameservers request to the
 * domain registrar.
 */
function hureg_SaveNameservers($params)
{
    $domain_details = hureg_getApiInstance($params)->domain()->get_details_by_domain_name(
        $params["domainname"]
    );

    if ($domain_details["status"] != "success") {
        Logger::log_domain_event("error", "Cannot get domain details from hureg, to modify nameservers. Hureg error", $domain_details["error"], $params["domainname"]);
        Logger::log_user_domain_event("error", "Egy domain névszerver módosítási kérés közben váratlan hiba történt. A domain névszerver Módosítás sikertelen!",
            false, $params["domainname"]);
        return ["error" => "A domain adatok módosítása sikertelen! Kérjük keresse fel az ügyfélszolgálatot!"];
    }

    $domain_id = $domain_details["success"]["data"]["COMMAND"]["ATTRIBUTES"][0]["DOMAIN"]["domain_hun_id"];

    $res_ns1 = hureg_getApiInstance($params)->domain()->modify_nameservers_by_domain_id(
        $domain_id,
        $params["ns1"],
        false
    );

    if ($res_ns1["status"] != "success") {
        Logger::log_domain_event("error", "Cannot modify domain nameservers on hureg.", $res_ns1["error"], $params["domainname"]);
        Logger::log_user_domain_event("error", "Egy domain névszerver módosítási kérés közben váratlan hiba történt. A domain névszerver Módosítás sikertelen!",
            false, $params["domainname"]);

        return ["error" => "A domain adatok módosítása sikertelen! Kérjük keresse fel az ügyfélszolgálatot!"];
    }

    Logger::log_domain_event("success", "Successfully modified domain namservers on hureg.", false, $params["domainname"]);
    Logger::log_user_domain_event("success", "Egy domain névszerver módosítási kérés került rögzítésre! A rögzítés sikeres volt.",
        false, $params["domainname"]);
    return ["success" => "Sikeres domain névszerver módosítás!"];

}


/**
 * Delete Domain.
 *
 * @param array $params common module parameters
 *
 * @return array
 * @see https://developers.whmcs.com/domain-registrars/module-parameters/
 *
 */

function domain_delete_actions($params, $domain_name)
{
    try {
        $domain_object = Domain::where('domain', $domain_name)->first();
        $domain_id = $domain_object->id;


        $hureg_additional_domain_informations = Capsule::table('hureg_additional_domain_informations')->where('whmcs_domain_id', $domain_id)->first();


        $hureg_domain_form_datas_del = Capsule::table('hureg_domain_form_datas')->where('form_domain_name', $domain_name)->delete();
        $select = $table = Capsule::table('hureg_additional_domain_informations')->where(
            [
                'whmcs_domain_id' => $domain_id
            ]
        )->delete();

        $domain_object_delete = Domain::where('domain', $domain_name)->delete();

        if ($domain_object_delete) {
            Logger::log_domain_event("success", "Successfully deleted domain from WHMCS ($domain_id,$domain_name) from database and set status to 31 on hureg.", false, $domain_name);
        } else {
            Logger::log_domain_event("error", "Error while deleting domain ($domain_name) from WHMCS", false, $domain_name);
        }


        Logger::log_domain_event("success", "Successfully deleted domain data for  domain ($domain_id,$domain_name) from database and set status to 31 on hureg.", false, $domain_name);

        return array(
            'success' => "Successfully deleted domain with id and name ($domain_id, $domain_name)",
        );

    } catch (\Exception $e) {
        Logger::log_domain_event("exception", "Unexpected error while handling data deletion with domain name ($domain_name) from database.", $e, $domain_name);
        return array(
            'exception' => $e->getMessage(),
        );
    }
}

function hureg_RequestDelete($params)
{
    $domain_name = $params["domainname"];

    return domain_delete_actions($params, $domain_name);

}


/**
 * Sync Domain Status & Expiration Date.
 *
 * Domain syncing is intended to ensure domain status and expiry date
 * changes made directly at the domain registrar are synced to WHMCS.
 * It is called periodically for a domain.
 *
 * @param array $params common module parameters
 *
 * @return array
 * @see https://developers.whmcs.com/domain-registrars/module-parameters/
 *
 */

function renew_domain($params,$select,$domain_name)
{
    if ($select->is_expiration_process_done == 1) {
        $exp_process = 0;
        $res = hureg_getApiInstance($params)->domain()->change_domain_status(
            $select->domain_nic_id,
            8
        );

        if ($res["status"] == "success") {
            Logger::log_domain_event("info", "Domain expiration was modified in hureg. Domain is delegated now.", false, $domain_name);
            Logger::log_user_domain_event("success", "A domain megújítása sikeres volt!",
                false, $params["domainname"]);
        } else {
            $error_msg = "The domain expiration was fixed, but cannot modify domain status to Delegated.";
            $error = Logger::log_domain_event("error", $error_msg, $res["error"], $domain_name);
            return array(
                'error' => $error,
            );
        }

    }

    return 0;
}
function update_domain_status_in_database($params,$select,$domain_name,$domain_object,$exp_process)
{
    try {
        $domain_details = hureg_getApiInstance($params)->domain()->get_details_by_domain_name(
            $domain_name
        );

        if ($domain_details["status"] != "success") {
            $error = Logger::log_domain_event("error", "Cannot get domain details in final stage of sync in hureg.", $domain_details["error"], $domain_name);
            return array(
                'error' => $error,
            );
        }


        $domain_hureg_current_state_text = $domain_details["success"]["data"]["COMMAND"]["ATTRIBUTES"][0]["DOMAIN"]["domain_state"];


        Capsule::table('hureg_additional_domain_informations')->where(
            [
                'whmcs_domain_id' => $domain_object->id
            ]
        )->update(
            [
                'hureg_status' => $domain_details["success"]["data"]["COMMAND"]["ATTRIBUTES"][0]["DOMAIN"]["domain_state_id"],
                'hureg_status_text' => $domain_hureg_current_state_text,
                'is_expiration_process_done' => $exp_process,
            ]
        );
        if ($domain_hureg_current_state_text != $select->hureg_status_text) {

            Logger::log_user_domain_event("success", "A domain státusza '$select->hureg_status_text' állapotból '$domain_hureg_current_state_text' státuszba került.",
                false, $params["domainname"]);

        }
    } catch (\Exception $e) {
        $error_msg = "Cannot update domain details in database, on domain synchronization process final stage.";
        Logger::log_domain_event("error", $error_msg, $e->getMessage(), $domain_name);
        return array(
            'error' => $error_msg,
        );
    }
}

function hureg_Sync($params)
{

    // domain parameters
    $sld = $params['sld'];
    $tld = $params['tld'];

    $domain_name = $sld . "." . $tld;

    try {


        $domain_details = hureg_getApiInstance($params)->domain()->get_details_by_domain_name(
            $domain_name
        );


        //if the request status is not success or no domain exists
        $no_domain_exists = !array_key_exists("DOMAIN", $domain_details["success"]["data"]["COMMAND"]["ATTRIBUTES"][0]);


        if ($domain_details["status"] != "success") {
            $error_msg = "Cannot get domain details from hureg on domain synchronization process first stage.";
            Logger::log_domain_event("error", $error_msg, $domain_details["error"], $domain_name);
            $errors = $domain_details["error"];

            if (count($errors) > 1) {
                foreach ($errors as $error) {
                    if ($error["code"] == "2000") {

                        //Delete domain
                        Logger::log_domain_event("info", "Domain cannot be found in the Hureg.", $error["data"], $domain_name);
                        $dda = domain_delete_actions($params, $domain_name);
                        return array(
                            'error' => "Domain couldn't be found in HuReg. Deleting custom data.",
                        );
                    }
                }
            }

            return array(
                'error' => $error_msg,
            );

        }

        if ($no_domain_exists) {
            Logger::log_domain_event("info", "Domain cannot be found in the Hureg. Domain will be deleted.", false, $domain_name);
            $dda = domain_delete_actions($params, $domain_name);
            return array(
                'error' => "Domain couldn't be found in HuReg. Deleting custom data.",
            );
        }


        $domain_object = Domain::where('domain', $domain_name)->first();
        $domain_expiration_date = $domain_object->expiryDate;
        $select = Capsule::table('hureg_additional_domain_informations')->where(
            [
                'whmcs_domain_id' => $domain_object->id
            ]
        )->first();

        if (!$select) {
            $error = Logger::log_domain_event("error", "Cannot select domain from additional domain informations_table on domain synchronization.", false, $domain_name);
            return array(
                'error' => "Domain couldn't be found in additional_domain_form_datas.",
            );
        }

        $minus_three_days = new DateTime(); // For today/now, don't pass an arg.
        $minus_three_days->modify("-3 day");

        $minus_three_days = $minus_three_days->format("Y-m-d");


        $is_expired_domain = $domain_expiration_date != "0000-00-00" && $domain_expiration_date <= $minus_three_days;
        //Logger::log_domain_event("debug", "$minus_three_days - $domain_expiration_date - $is_expired_domain", false, $domain_name);

        if ($is_expired_domain) {
            Logger::log_domain_event("info", "Domain is expired, expiration process started. (Checked on Domain sync)", false, $domain_name);


            if ($select->is_expiration_process_done == 0) {
                //Change domain status to 31

                $res = hureg_getApiInstance($params)->domain()->change_domain_status(
                    $select->domain_nic_id,
                    31
                );

                if ($res["status"] != "success") {
                    $error = Logger::log_domain_event("error", "Expired domain status cannot be changed to 31 on hureg.", $res["error"], $domain_name);
                    return array(
                        'error' => $error,
                    );

                }

                $select = $table = Capsule::table('hureg_additional_domain_informations')->where(
                    [
                        'whmcs_domain_id' => $domain_object->id
                    ]
                )->update(
                    [
                        'hureg_status' => 31,
                        'hureg_status_text' => "Felmondás zóna szolgáltatás azonnali törlésével",
                        'is_expiration_process_done' => 1
                    ]
                );

                if ($select) {
                    Logger::log_domain_event("info", "Domain is expired, expiration status modified in database too, as well as on hureg.", false, $domain_name);
                    Logger::log_user_domain_event("info", "A domain lejárt. A domain státusza 'Felmondás zóna szolgáltatás azonnali törlésével' státuszba került.",
                        false, $params["domainname"]);

                } else {
                    $error = Logger::log_domain_event("error", "Domain is expired, database cannot be modified for expiration.", false, $domain_name);
                    return array(
                        'error' => $error,
                    );

                }

            }
        } else {
            $ren_ret = renew_domain($params,$select,$domain_name);

            if ($ren_ret == 0)
            {
                $exp_process = 0;
            }
            else {
                return $ren_ret;
            }

            update_domain_status_in_database($params,$select,$domain_name,$domain_object,$exp_process);

        }
        //Logger::log_domain_event("success", "Domain was synchronized successfully.", false, $domain_name);

        return array(
            'expirydate' => $domain_expiration_date, // Format: YYYY-MM-DD
            'active' => !$is_expired_domain, // Return true if the domain is active
            'expired' => $is_expired_domain, // Return true if the domain has expired
            'transferredAway' => false, // Return true if the domain is transferred out
        );

    } catch (\Exception $e) {

        Logger::log_domain_event("exception", "Exception occured in the domain synchronization process.", $e, $domain_name);
        return array(
            'error' => $e->getMessage(),
        );
    }
}

/**
 * Incoming Domain Transfer Sync.
 *
 * Check status of incoming domain transfers and notify end-user upon
 * completion. This function is called daily for incoming domains.
 *
 * @param array $params common module parameters
 *
 * @return array
 * @see https://developers.whmcs.com/domain-registrars/module-parameters/
 *
 */
function hureg_TransferSync($params)
{

    // domain parameters
    $sld = $params['sld'];
    $tld = $params['tld'];
    $domain_name = $sld . "." . $tld;

    $error_message = false;
    $response_code = false;

    try {

        /*
         * $response_code = 1 --> success
         *                  0 --> nothing changed
                           -1 --> fail
        */


        $domain_details = hureg_getApiInstance($params)->domain()->get_details_by_domain_name(
            $domain_name
        );

        if ($domain_details['status'] != 'success') {

            $m = Logger::log_domain_event("error", "Cannot get domain details on transfer", $domain_details["error"], $domain_name);
            Logger::log_user_domain_event("error", "Hiba történt a domain transzfer folyamat végrehajtása közben. Sikertelen transzfer.",
                false, $params["domainname"]);
            return array(
                'failed' => true,
                'reason' => $m, // Reason for the transfer failure if available
            );

        }


        $domain_object = Domain::where('domain', $domain_name)->first();
        $domain_id = $domain_object->id;
        $hureg_domain_info = Capsule::table('hureg_additional_domain_informations')->where('whmcs_domain_id', $domain_id)->first();


        if (count($domain_details["success"]["data"]["COMMAND"]["ATTRIBUTES"]) == 2) {
            $domain_hun_id = $domain_details["success"]["data"]["COMMAND"]["ATTRIBUTES"][0]["DOMAIN"]["domain_hun_id"];
            $domain_mnt_org_id = $domain_details["success"]["data"]["COMMAND"]["ATTRIBUTES"][0]["DOMAIN"]["domain_mnt_org_id"];
            $domain_status = $domain_details["success"]["data"]["COMMAND"]["ATTRIBUTES"][0]["DOMAIN"]["domain_state_id"];
            $domain_exp_date = $domain_details["success"]["data"]["COMMAND"]["ATTRIBUTES"][0]["DOMAIN"]["domain_reg_date"];

            if (
                $domain_status == 8
                &&
                $domain_mnt_org_id == "1006101551"
            ) {

                $hureg_domain_info = Capsule::table('hureg_additional_domain_informations')->where('whmcs_domain_id', $domain_id)->update(
                    ['domain_nic_id' => $domain_hun_id]
                );

                $response_code = 1;
            } else if ($domain_mnt_org_id != "1006101551") {
                $response_code = -1;
                $error_message = "A domain nem került át hozzánk.";
            } else {
                $response_code = 0;
            }
        } else if (count($domain_details["success"]["data"]["COMMAND"]["ATTRIBUTES"]) == 3) {
            $response_code = 0;
        }


    } catch (\Exception $e) {
        Logger::log_domain_event("error", "Domain transfer error", $e->getMessage(), $domain_name);
        return array(
            'failed' => true,
            'reason' => $e->getMessage(), // Reason for the transfer failure if available
        );
    }


    if ($response_code != 1) {
        if (count($domain_details["success"]["data"]["COMMAND"]["ATTRIBUTES"]) == 1) {
            $domain_mnt_org_id = $domain_details["success"]["data"]["COMMAND"]["ATTRIBUTES"][0]["DOMAIN"]["domain_mnt_org_id"];
            if ($domain_mnt_org_id != "1006101551") {
                $response_code = -1;
                $error_message = "A domain nem került át hozzánk.";
            }
        }

    }


    if ($response_code == 1) {
        Logger::log_domain_event("success", "The domain transfer was successful", false, $domain_name);
        Logger::log_user_domain_event("success", "A domain transzfer sikeresen volt.",
            false, $params["domainname"]);
        return array(
            'completed' => true,
            'expirydate' => date('Y-m-d', strtotime('+1 year')), // Format: YYYY-MM-DD
        );
    } elseif ($response_code == -1) {
        Logger::log_domain_event("error", "Domain transfer error", $error_message, $domain_name);
        Logger::log_user_domain_event("error", "Hiba történt a domain transzfer folyamat végrehajtása közben. Sikertelen transzfer.",
            false, $params["domainname"]);
        return array(
            'failed' => true,
            'reason' => $error_message, // Reason for the transfer failure if available
        );
    } else {
        // No status change, return empty array
        return array();
    }


}

/**
 * Client Area Output.
 *
 * This function renders output to the domain details interface within
 * the client area. The return should be the HTML to be output.
 *
 * @param array $params common module parameters
 *
 * @return string HTML Output
 * @see https://developers.whmcs.com/domain-registrars/module-parameters/
 *
 */


function hureg_ClientArea($params)
{


    $domain_name = $params["domainname"];

    $domain_object = Domain::where('domain', $domain_name)->first();
    $domain_id = $domain_object->id;

    $hureg_domain_info = Capsule::table('hureg_additional_domain_informations')->where('whmcs_domain_id', $domain_id)->first();

    if ($hureg_domain_info->is_transferred == 1) {
        return '';
    }

    $hureg_confirmations = Capsule::table('hureg_confirmations')->where('whmcs_domain_id', $domain_id)->first();


    if ($hureg_confirmations->confirmation_state == 1) {
        return '<h1>Nyilatkozat</h1> <pre>A nyilatkozat el lett fogadva. Nincs további teendő!</pre>';
    }

    $output = '<h1>Nyilatkozat</h1>
        A nyilatkozat még nem lett kitöltve. <a href="/index.php?m=hureg&page=single_domain_confirmation&domain_id=' . $domain_id . '">Kattints ide</a> a kitöltéshez.
        <div style="margin-bottom:100px"></div>
        ';

    return $output;
}


function hureg_CheckAvailability($params)
{
    try {
        $searchTerm = $params['searchTerm'];
        $punyCodeSearchTerm = $params['punyCodeSearchTerm'];


        $domain['sld'] = $params['sld'];
        $domain['tld'] = ".hu";

        $results = new ResultsList();

        // Instantiate a new domain search result object
        $searchResult = new SearchResult($domain['sld'], $domain['tld']);

        //$status = SearchResult::STATUS_REGISTERED;
        $status = SearchResult::STATUS_NOT_REGISTERED;


        $searchResult->setStatus($status);


        // Append to the search results list
        $results->append($searchResult);

        return $results;
    } catch (\Exception $e) {
        return array(
            'error' => $e->getMessage(),
        );
    }

}
