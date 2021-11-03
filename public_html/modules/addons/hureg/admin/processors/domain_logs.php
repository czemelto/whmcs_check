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
        $hureg_domain_logs = Capsule::table('hureg_domain_logs')->where('whmcs_domain_id', $domain_object->id)->orWhere("form_domain_name",$domain_object->domain)->get();


        $domain_expiration_date = $domain_object->expiryDate;
        $minus_three_days = date("Y-m-d", strtotime("-3 Days", date("Y-m-d")));
        $is_expired_domain = $domain_expiration_date != "0000-00-00" && $domain_expiration_date <= $minus_three_days;

        ?>
        <h2><u><?=$s->domain?></u> - domain logok</h2>

        <table class="datatable" style="">

            <tr>
                <th>Dátum</th>
                <th>Típus</th>
                <th>Tartalom</th>
                <th>adat</th>
            </tr>


            <?php
            foreach ($hureg_domain_logs as $log) {

                echo "<tr>";
                echo "<td>".$log->event_time."</td>";
                echo "<td>".$log->event_type."</td>";
                echo "<td>".$log->event_text."</td>";
                echo "<td><pre style='white-space: pre-wrap;'>";
                print_r(json_decode($log->event_data,true));
                echo "</pre></td>";

                echo "</tr>";

            }

            ?>
        </table>
        <?php
    }

}
?>
