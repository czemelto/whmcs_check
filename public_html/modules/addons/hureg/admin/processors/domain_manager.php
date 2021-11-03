<?php

use WHMCS\Database\Capsule;
use WHMCS\Domain\Domain;
use \WHMCS\User\Client\Contact;
use \WHMCS\User\Client;

if (!isset($_GET['domain_id'])) {
    echo "No domain data available.";
} else {

    $domain_id = intval($_GET['domain_id']);
    $domain_object = Domain::where('id', $domain_id)->first();
    if (count($domain_object) == 0) {
        echo "No domain data available by id.";
    } else {
        $s = $domain_object;

        $main_client_object = Client::where('id', $domain_object->clientId)->first();
        $hureg_domain_form_datas = Capsule::table('hureg_domain_form_datas')->where('form_domain_name', $domain_object->domain)->first();
        $hureg_domain_add_info = Capsule::table('hureg_additional_domain_informations')->where('whmcs_domain_id', $domain_object->id)->first();


        if ($hureg_domain_form_datas->owner_contact_type == 0) {
            $owner_contact_object = Client::where('id', $s->clientId)->first();
            $owner_contact_name = $owner_contact_object->lastName . " " . $owner_contact_object->firstName;
            $owner_contact_type = "(számlázási)";

            $command = 'GetClientsDetails';
            $postData = array(
                'clientid' => $s->clientId,
                'stats' => false,
            );

            $client_results = localAPI($command, $postData);

            $whmcs_owner_data = [
                'org_name_eng' => $client_results["companyname"] != "" ? $client_results["companyname"] : "-----",
                'org_name_hun' => $client_results["companyname"] == "" ? $client_results["lastname"] . " " . $client_results["firstname"] : $client_results["companyname"],
                'org_fca_ident' => $client_results["customfields1"] == "" ? $client_results["customfields2"] : $client_results["customfields1"],
                'org_country' => $client_results["country"],
                'org_zipcode' => $client_results["postcode"],
                'org_city' => $client_results["city"],
                'org_street' => $client_results["address1"],
                'org_street_number' => $client_results["address2"],
                'org_e_mail' => $client_results["email"],
                'org_tel' => $client_results["phonecc"] . "" . $client_results["phonenumber"],
            ];

            $hureg_contact_joiner = Capsule::table('hureg_contact_joiner')->where(
                [
                    'whmcs_client_id' => $s->clientId,
                    'whmcs_contact_id' => $hureg_domain_form_datas->owner_contact_id,
                    'nic_type' => 1,
                    'contact_type' => 0]
            )->first();
//TODO: error handling
            $hureg_owner_data = hureg_getApiInstance($vars)->person()->get_owner_details_by_owner_nic_id(
                $hureg_contact_joiner->nic_object_id
            )["success"]["data"]["COMMAND"]["ATTRIBUTES"][0]["ORG"];



                    $domain_details = hureg_getApiInstance($vars)->domain()->get_details_by_domain_name(
                       $domain_object->domain
                   );

                   $domain_hun_id = $domain_details["success"]["data"]["COMMAND"]["ATTRIBUTES"][0]["DOMAIN"]["domain_hun_id"];

                   $set_status = hureg_getApiInstance($vars)->domain()->test_set_domain_status_to_bejegyezheto(
                       $domain_hun_id
                   );





        } elseif ($hureg_domain_form_datas->owner_contact_type == 2) {
            $owner_contact_object = Contact::where('id', $hureg_domain_form_datas->owner_contact_id)->first();
            $owner_contact_name = $owner_contact_object->lastName . " " . $owner_contact_object->firstName;
            $owner_contact_type = " (kapcsolat)";

            $whmcs_owner_data = [
                'org_name_eng' => $owner_contact_object->companyname != "" ? $owner_contact_object->companyname : "-----",
                'org_name_hun' => $owner_contact_object->companyname == "" ? $owner_contact_object->lastName . " " . $owner_contact_object->firstName : $owner_contact_object->companyname,
                'org_fca_ident' => $owner_contact_object->taxId,
                'org_country' => $owner_contact_object->country,
                'org_zipcode' => $owner_contact_object->postcode,
                'org_city' => $owner_contact_object->city,
                'org_street' => $owner_contact_object->address1,
                'org_street_number' => $owner_contact_object->address2,
                'org_e_mail' => $owner_contact_object->email,
                'org_tel' => $owner_contact_object->phoneNumber,
            ];
            $hureg_contact_joiner = Capsule::table('hureg_contact_joiner')->where(
                [
                    'whmcs_client_id' => $s->clientId,
                    'whmcs_contact_id' => $hureg_domain_form_datas->owner_contact_id,
                    'nic_type' => 1,
                    'contact_type' => 2]
            )->first();
//TODO: error handling
            $hureg_owner_data = hureg_getApiInstance($vars)->person()->get_owner_details_by_owner_nic_id(
                $hureg_contact_joiner->nic_object_id
            )["success"]["data"]["COMMAND"]["ATTRIBUTES"][0]["ORG"];

        }

        if ($hureg_domain_form_datas->admin_contact_type == 0) {
            $admin_contact_object = Client::where('id', $s->clientId)->first();
            $admin_contact_name = $admin_contact_object->lastName . " " . $admin_contact_object->firstName;
            $admin_contact_type = " (számlázási)";

            $whmcs_admin_data = [
                'person_first_name' => $admin_contact_object->firstName,
                'person_last_name' => $admin_contact_object->lastName,
                'person_country' => $admin_contact_object->country,
                'person_zipcode' => $admin_contact_object->postcode,
                'person_city' => $admin_contact_object->city,
                'person_street' => $admin_contact_object->address1,
                'person_street_number' => $admin_contact_object->address2,
                'person_e_mail' => $admin_contact_object->email,
                'person_tel' => $admin_contact_object->phoneNumber,
            ];
            $hureg_contact_joiner = Capsule::table('hureg_contact_joiner')->where(
                [
                    'whmcs_client_id' => $s->clientId,
                    'whmcs_contact_id' => $hureg_domain_form_datas->admin_contact_id,
                    'nic_type' => 2,
                    'contact_type' => 0]
            )->first();
//TODO: error handling
            $hureg_admin_data = hureg_getApiInstance($vars)->person()->get_admin_details_by_person_nic_id(
                $hureg_contact_joiner->nic_object_id
            )["success"]["data"]["COMMAND"]["ATTRIBUTES"][0]["PERSON"];


        } elseif ($hureg_domain_form_datas->admin_contact_type == 2) {
            $admin_contact_object = Contact::where('id', $hureg_domain_form_datas->admin_contact_id)->first();
            $admin_contact_name = $admin_contact_object->lastName . " " . $admin_contact_object->firstName;
            $admin_contact_type = " (kapcsolat)";

            $whmcs_admin_data = [
                'person_first_name' => $admin_contact_object->firstName,
                'person_last_name' => $admin_contact_object->lastName,
                'person_country' => $admin_contact_object->country,
                'person_zipcode' => $admin_contact_object->postcode,
                'person_city' => $admin_contact_object->city,
                'person_street' => $admin_contact_object->address1,
                'person_street_number' => $admin_contact_object->address2,
                'person_e_mail' => $admin_contact_object->email,
                'person_tel' => $admin_contact_object->phoneNumber,
            ];
            $hureg_contact_joiner = Capsule::table('hureg_contact_joiner')->where(
                [
                    'whmcs_client_id' => $s->clientId,
                    'whmcs_contact_id' => $hureg_domain_form_datas->admin_contact_id,
                    'nic_type' => 2,
                    'contact_type' => 2]
            )->first();

            //TODO: error handling
            $hureg_admin_data = hureg_getApiInstance($vars)->person()->get_admin_details_by_person_nic_id(
                $hureg_contact_joiner->nic_object_id
            )["success"]["data"]["COMMAND"]["ATTRIBUTES"][0]["PERSON"];

        }

        //@based_on hureg/lib/Person.php upload functions

        //GET hureg details

        $check_data = [];
        $value_mappings_owner = [
            'org_fca_ident' => 'Személyi/Adószám',
            'org_name_eng' => "Cégnév",
            'org_name_hun' => "Teljes név",
            'org_country' => "Ország kódja",
            'org_zipcode' => "Irányítószám",
            'org_city' => "Város",
            'org_street' => "Utca",
            'org_street_number' => "Házszám",
            'org_e_mail' => "E-mail cím",
            'org_tel' => "Telefonszám",

        ];
        $value_mappings_admin = [
            'person_reg_ident' => 'Személyi/Adószám',
            'person_first_name' => "Vezetéknév",
            'person_last_name' => "Keresztnév",
            'person_country' => "Ország kódja",
            'person_zipcode' => "Irányítószám",
            'person_city' => "Város",
            'person_street' => "Utca",
            'person_street_number' => "Házszám",
            'person_e_mail' => "E-mail cím",
            'person_tel' => "Telefonszám",

        ];

        foreach ($whmcs_owner_data as $whmcs_key => $whmcs_val) {
            $check_data["owner_data"][$whmcs_key] = [
                'name' => $value_mappings_owner[$whmcs_key],
                'hureg_value' => $hureg_owner_data[$whmcs_key],
                'whmcs_value' => $whmcs_val,
                'status' => trim($hureg_owner_data[$whmcs_key]) == trim($whmcs_val) ? "OK" : "NOK"
            ];


        }
        foreach ($whmcs_admin_data as $whmcs_key => $whmcs_val) {
            $check_data["admin_data"][$whmcs_key] = [
                'name' => $value_mappings_admin[$whmcs_key],
                'hureg_value' => $hureg_admin_data[$whmcs_key],
                'whmcs_value' => $whmcs_val,
                'status' => trim($hureg_admin_data[$whmcs_key]) == trim($whmcs_val) ? "OK" : "NOK"
            ];
        }
        ?>
        <h2>Domain általános adatok</h2>

        <table class="datatable">
            <tr>
                <th>Domain neve</th>
                <th>Fő ügyfél fiók</th>
                <th>Tulajdonos</th>
                <th>Admin kapcsolattartó</th>
                <th>Domain állapota</th>
                <th>Domain lejárat</th>
                <th>Utolsó számla státusza</th>
            </tr>
            <tr>
                <td>
                    <a href="clientsdomains.php?userid=<?php echo($s->clientId); ?>&id=<?php echo($s->whmcs_domain_id); ?>"><?php echo $domain_object->domain; ?></a>
                </td>

                <td>
                    <a href="clientssummary.php?userid=<?php echo($s->clientId); ?>"><?php echo $main_client_object->lastName . " " . $main_client_object->firstName; ?></a>
                </td>


                <?php
                if ($hureg_domain_form_datas->owner_contact_type == 2) {
                    ?>
                    <td>
                        <a href="clientscontacts.php?userid=<?php echo($s->clientId); ?>&contactid=<?php echo($hureg_domain_form_datas->owner_contact_id); ?>">
                            <?php echo $owner_contact_name . $owner_contact_type; ?></a></td>
                    <?php
                } else {
                    ?>
                    <td><?php echo $owner_contact_name . $owner_contact_type; ?></td>
                    <?php
                }
                ?>

                <?php
                if ($hureg_domain_form_datas->admin_contact_type == 2) {
                    ?>
                    <td>
                        <a href="clientscontacts.php?userid=<?php echo($s->clientId); ?>&contactid=<?php echo($hureg_domain_form_datas->admin_contact_id); ?>">
                            <?php echo $admin_contact_name . $admin_contact_type; ?></a></td>
                    <?php
                } else {
                    ?>
                    <td><?php echo $admin_contact_name . $admin_contact_type; ?></td>
                    <?php
                }
                ?>

                <td><?php echo $hureg_domain_add_info->hureg_status_text; ?>
                    (<?php echo $hureg_domain_add_info->hureg_status; ?> )
                </td>

                <td><?php echo date("Y.m.d", strtotime($domain_object->expiryDate)); ?></td>


                <td>TODO</td>
            </tr>
        </table>

        <h2>WHMCS - HUREG adatok egyeztetése</h2>

        <table class="datatable">

            <tr>
                <th colspan="3">Tulajdonosi adatok</th>
                <th></th>
            </tr>
            <tr>
                <th></th>
                <th>WHMCS</th>
                <th>HUREG</th>
                <th>Ellenőrzés</th>
            </tr>
            <?php
            foreach ($value_mappings_owner as $key => $val) {

                ?>
                <tr>
                    <th><?= $val ?></th>
                    <?php
                    if (array_key_exists($key, $check_data["owner_data"])) {
                        ?>
                        <td><?= $whmcs_owner_data[$key] ?></td>
                        <td><?= $hureg_owner_data[$key] ?></td>
                        <?php
                        if ($check_data["owner_data"][$key]['status'] == "OK") { ?>
                            <td style="background:lightgreen">OK</td>
                            <?php
                        } else {
                            ?>
                            <td style="background:red">NOK</td>

                            <?php
                        }
                    }
                    ?>
                </tr>
                <?php
            }
            ?>
        </table>
        <table class="datatable" style="float:left;">
            <tr>
                <th colspan="3">Admin/Zóna/Tech kapcsolattartó adatok</th>
                <th></th>
            </tr>
            <tr>
                <th></th>
                <th>WHMCS</th>
                <th>HUREG</th>
                <th>Ellenőrzés</th>
            </tr>
            <?php
            foreach ($value_mappings_admin as $key => $val) {

                ?>
                <tr>
                    <th><?= $val ?></th>
                    <?php
                    if (array_key_exists($key, $check_data["admin_data"])) {
                        ?>
                        <td><?= $whmcs_admin_data[$key] ?></td>
                        <td><?= $hureg_admin_data[$key] ?></td>
                        <?php
                        if ($check_data["admin_data"][$key]['status'] == "OK") { ?>
                            <td style="background:lightgreen">OK</td>
                            <?php
                        } else {
                            ?>
                            <td style="background:red">NOK</td>

                            <?php
                        }
                    }
                    ?>
                </tr>
                <?php
            }
            ?>

        </table>

        <?php
    }

}
?>
