<?php

namespace WHMCS\Module\Registrar\HuReg;

class Config
{
    static function get_module_metadata()
    {
        return array(
            'DisplayName' => "HuReg - domain.hu",
            'Description' => "HuReg (domain.hu) registrar module for automating .hu domain registrations",
            'APIVersion' => "1.0",
        );
    }

    static function get_module_admin_settings($called_from_addon=false)
    {
        $arr = array(
            // Friendly display name for the module
            // a text field type allows for single line text input
            'api_username' => array(
                "FriendlyName" => "API Username",
                'Type' => 'text',
                'Size' => '25',
                'Default' => '',
                'Description' => 'Username for accessing the HuReg API',
            ),
            // a password field type allows for masked text input
            'api_password' => array(
                "FriendlyName" => "API Password",
                'Type' => 'password',
                'Default' => '',
                'Description' => 'Password for accessing the HuReg API',
            ),
            // the dropdown field type renders a select menu of options
            'api_endpoint' => array(
                "FriendlyName" => "API Endpoint",
                'Type' => 'dropdown',
                'Options' => array(
                    'test' => 'Test endpoint',
                    'prod' => 'Production endpoint',
                ),
                'Description' => 'Choose one',
            ),
            'public_key_fingerprint' => array(
                "FriendlyName" => "Public Key Fingerprint",
                'Type' => 'text',
                'Size' => '25',
                'Default' => '',
                'Description' => 'Fingerprint for the stored public key',
            ),
            'test_transfer' => array(
                "FriendlyName" => "Testing mode for Domain Transfer",
                'Type' => 'dropdown',
                'Options' => array(
                    'test' => 'Test',
                    'prod' => 'No test',
                ),
                'Description' => 'Check if you want to test domain transfer',
            ),
            //TODO: add legacy PGP option
            //TODO: add PGP armored keys

        );

        if (!$called_from_addon) {
            $arr = array_merge($arr, ['ModuleName' => array(
                'Type' => 'System',
                'Value' => 'HuReg for WHMCS'
            )]);
        }
        return $arr;
    }

    static function get_endpoint_by_type(string $type): string
    {
        return [

            'test' => "https://huregx.nic.hu:444/servlet/api",
            'prod' => "https://huregxml.nic.hu/servlet/api",

        ][$type];
    }

    static function get_credentials_in_plaintext() {
        return [
            "api_username" => "mosonyi",
            "api_password" => "bVjL6hK9dE2Q4dZ8U6A",
            "public_key_fingerprint" => "FFFEE51355E0D43E",
            "api_endpoint" => "test"
        ];
    }

}

?>