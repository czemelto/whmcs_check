<?php
/**
 * WHMCS SDK Sample Addon Module
 *
 * An addon module allows you to add additional functionality to WHMCS. It
 * can provide both client and admin facing user interfaces, as well as
 * utilise hook functionality within WHMCS.
 *
 * This sample file demonstrates how an addon module for WHMCS should be
 * structured and exercises all supported functionality.
 *
 * Addon Modules are stored in the /modules/addons/ directory. The module
 * name you choose must be unique, and should be all lowercase, containing
 * only letters & numbers, always starting with a letter.
 *
 * Within the module itself, all functions must be prefixed with the module
 * filename, followed by an underscore, and then the function name. For this
 * example file, the filename is "addonmodule" and therefore all functions
 * begin "hureg_".
 *
 * For more information, please refer to the online documentation.
 *
 * @see https://developers.whmcs.com/addon-modules/
 *
 * @copyright Copyright (c) WHMCS Limited 2017
 * @license http://www.whmcs.com/license/ WHMCS Eula
 */

/**
 * Require any libraries needed for the module to function.
 * require_once __DIR__ . '/path/to/library/loader.php';
 *
 * Also, perform any initialization required by the service's library.
 */

use WHMCS\Database\Capsule;
use WHMCS\Module\Addon\AddonModule\Admin\AdminDispatcher;
use WHMCS\Module\Addon\AddonModule\Client\ClientDispatcher;

use WHMCS\Module\Registrar\HuReg\Config;
use WHMCS\Module\Registrar\HuReg\HuReg;
use WHMCS\Module\Registrar\HuReg\Logger;

require_once __DIR__ . '../../../registrars/hureg/vendor/autoload.php';


if (!defined("WHMCS")) {
    die("This file cannot be accessed directly");
}

/**
 * Define addon module configuration parameters.
 *
 * Includes a number of required system fields including name, description,
 * author, language and version.
 *
 * Also allows you to define any configuration parameters that should be
 * presented to the user when activating and configuring the module. These
 * values are then made available in all module function calls.
 *
 * Examples of each and their possible configuration parameters are provided in
 * the fields parameter below.
 *
 * @return array
 */
function hureg_config()
{
    return [
        // Display name for your module
        'name' => 'HuReg complementer WHMCS addon module',
        // Description displayed within the admin interface
        'description' => 'Should be used in conjunction with the HuReg registrar module',
        // Module author name
        'author' => 'MediaPlatz Ltd.',
        // Default language
        'language' => 'english',
        // Version number
        'version' => '1.0',
        'fields' => Config::get_module_admin_settings(true)
    ];
}

/**
 * Activate.
 *
 * Called upon activation of the module for the first time.
 * Use this function to perform any database and schema modifications
 * required by your module.
 *
 * This function is optional.
 *
 * @see https://developers.whmcs.com/advanced/db-interaction/
 *
 * @return array Optional success/failure message
 */
function hureg_activate()
{
    // Create custom tables and schema required by your module
    try {
        /*     Capsule::schema()
                 ->create(
                     'hureg_confirmations',
                     function ($table) {
                         $table->increments('id');
                         $table->integer('whmcs_domain_id');
                         $table->integer('whmcs_client_id');
                         $table->integer('whmcs_user_id');
                         $table->text('confirmation_text');
                         $table->text('confirmation_captcha');
                         $table->integer('confirmation_id');
                         $table->integer('confirmation_state');
                     }
                 );
             Capsule::schema()
                 ->create(
                     'hureg_additional_domain_informations',
                     function ($table) {
                         $table->increments('id');
                         $table->integer('whmcs_domain_id');
                         $table->integer('whmcs_client_id');
                         $table->integer('whmcs_user_id');
                         $table->integer('is_transferred');
                         $table->integer('is_expiration_process_done');
                         $table->integer('hureg_status');
                         $table->string('domain_nic_id');
                         $table->string('hureg_status_text');
                     }
                 );
             Capsule::schema()
                 ->create(
                     'hureg_contact_joiner',
                     function ($table) {
                         $table->increments('id');
                         $table->integer('whmcs_client_id');
                         $table->integer('whmcs_user_id');
                         $table->integer('whmcs_contact_id'); // szám vagy -1
                         $table->integer('contact_type'); // 0=> Billing, 2 => Contact
                         $table->integer('contact_tax_type'); // 1 => magánszemély, 2 => cég
                         $table->integer('nic_type'); // 1 => owner, 2 => admim/zone/tech contact
                         $table->string('nic_object_id'); // X..........
                     }
                 );
             Capsule::schema()
                 ->create(
                     'contact_domain_joiner',
                     function ($table) {
                         $table->increments('id');
                         $table->integer('whmcs_contact_joiner_id');
                         $table->integer('whmcs_domain_id');
                     }
                 );

             Capsule::schema()
                 ->create(
                     'hureg_domain_form_datas',
                     function ($table) {
                         $table->increments('id');
                         $table->string('form_domain_name');
                         $table->integer('whmcs_client_id');
                         $table->integer('whmcs_user_id');
                         $table->integer('owner_contact_type'); // 0 => Billing, 2 => contact
                         $table->integer('admin_contact_type'); // 0 => billing, 2 => contact
                         $table->integer('admin_contact_id'); // szám vagy -1
                         $table->integer('owner_contact_id'); // szám vagy -1
                     }
                 );
             */
        Capsule::schema()
            ->create(
                'hureg_domain_logs',
                function ($table) {
                    /** @var \Illuminate\Database\Schema\Blueprint $table */
                    $table->increments('id');
                    $table->string('form_domain_name');
                    $table->integer('whmcs_domain_id');
                    $table->text('event_type');
                    $table->text('event_side');
                    $table->text('event_text');
                    $table->text('event_data');
                    $table->datetime('event_time');
                }
            );

        return [
            // Supported values here include: success, error or info
            'status' => 'success',
            'description' => 'Successfully activated the module!'
        ];
    } catch (\Exception $e) {
        return [
            // Supported values here include: success, error or info
            'status' => "error",
            'description' => 'Unable to activate module: ' . $e->getMessage(),
        ];
    }
}

/**
 * Deactivate.
 *
 * Called upon deactivation of the module.
 * Use this function to undo any database and schema modifications
 * performed by your module.
 *
 * This function is optional.
 *
 * @see https://developers.whmcs.com/advanced/db-interaction/
 *
 * @return array Optional success/failure message
 */
function hureg_deactivate()
{
    // Undo any database and schema modifications made by your module here
    try {
        /* Capsule::schema()
             ->dropIfExists('hureg_confirmations');
         Capsule::schema()
             ->dropIfExists('hureg_additional_domain_informations');
         Capsule::schema()
             ->dropIfExists('hureg_contact_joiner');
         Capsule::schema()
             ->dropIfExists('hureg_domain_form_datas');
         Capsule::schema()
             ->dropIfExists('contact_domain_joiner');
         */


        return [
            // Supported values here include: success, error or info
            'status' => 'success',
            'description' => 'This is a demo module only. '
                . 'In a real module you might report a success here.',
        ];
    } catch (\Exception $e) {
        return [
            // Supported values here include: success, error or info
            "status" => "error",
            "description" => "Unable to drop mod_addonexample: {$e->getMessage()}",
        ];
    }
}

use \WHMCS\Domain\Domain;

function hureg_getApiInstance($p)
{
    $api_endpoint = Config::get_endpoint_by_type($p["api_endpoint"]);
    return new HuReg($p["api_username"], $p["api_password"], $p["public_key_fingerprint"], $api_endpoint, false);
}

function hureg_createConfirmationForDomainIfNotExists($vars, $domain_name)
{

    try {


        $currentUser = new \WHMCS\Authentication\CurrentUser;
        $user = $currentUser->user();
        $client = $currentUser->client();


        $domain_object = Domain::where('domain', $domain_name)->first();
        $domain_id = $domain_object->id;
        $hureg_domain_info = Capsule::table('hureg_additional_domain_informations')->where('whmcs_domain_id', $domain_id)->first();

        if ($hureg_domain_info->is_transferred === 1) {
            Header("Location: clientarea.php?action=domaindetails&id=" . $domain_id);
            return [0, 0];
        }

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
                Logger::log_domain_event("error", "Cannot create confirmation for domain.", $request_confirmation["error"], $domain_name, $domain_id);

                return [-1, $request_confirmation];
            }

            $table = Capsule::table('hureg_confirmations')->insert(
                [
                    'whmcs_domain_id' => $domain_id,
                    'confirmation_id' => $request_confirmation["success"]["data"]["COMMAND"]["ATTRIBUTES"][0]["DECL"]["DECL_ID"],
                    'confirmation_text' => mb_convert_encoding($request_confirmation["success"]["data"]["COMMAND"]["ATTRIBUTES"][0]["DECL"]["DECL_TEXT"], 'UTF-8'),
                    'confirmation_captcha' => mb_convert_encoding($request_confirmation["success"]["data"]["COMMAND"]["ATTRIBUTES"][0]["DECL"]["DECL_CAPTCHA"], 'UTF-8'),
                    'confirmation_state' => 2,
                    'whmcs_client_id' => $client->id,
                    'whmcs_user_id' => $user->id,
                ]
            );

            if ($table) {
                Logger::log_domain_event("success", "A hureg confirmation entry was created successfully.", false, $domain_name, $domain_id);
                Logger::log_user_domain_event("info", "Új domain nyilatkozat került generálásra.",
                    false, $domain_name);
            }

        }
        return [0, 0];
    } catch (Exception $e) {
        Logger::log_domain_event("exception", "A hureg confirmation entry was not created successfully.", $e, $domain_name);
    }
}

function hureg_clientarea($vars)
{
    require_once "client/request_dispatcher.php";
    return $return_page;
}


function hureg_output($vars)
{

    require_once "admin/request_dispatcher.php";

}
