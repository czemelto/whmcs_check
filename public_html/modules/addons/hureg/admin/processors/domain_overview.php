<?php

use WHMCS\Database\Capsule;
use WHMCS\Domain\Domain;
use \WHMCS\User\Client\Contact;
use \WHMCS\User\Client;
use WHMCS\Module\Registrar\HuReg\Config;

if (isset($_GET['pageno'])) {
    $pageno = $_GET['pageno'];
} else {
    $pageno = 1;
}
$no_of_records_per_page = 10;
$offset = ($pageno - 1) * $no_of_records_per_page;


$hureg_domain_infos = Capsule::table('hureg_domain_form_datas')->get();


$total_rows = count($hureg_domain_infos);
$total_pages = ceil($total_rows / $no_of_records_per_page);

$hureg_domain_infos = Capsule::table('hureg_domain_form_datas')
    ->limit($no_of_records_per_page)
    ->offset($offset)
    ->orderBy('id', 'desc')
    ->get();
?>
<style>
    a {
        color: #151565;
        text-decoration: underline;
    }
</style>

<hr>

<h3>Domain létrehozása transzferhez</h3>
<?php
$hureg_login_data = Config::get_credentials_in_plaintext();

if (isset($_POST['send1'])) {

    $transferrable_domain = hureg_getApiInstance($hureg_login_data)->domain()->test_create_transferrable_domain(
        $_POST["domain_to_transfer"]
    );
    if ($transferrable_domain["status"] == "success") {
        echo "<b><span style='color:darkgreen'>Sikeres felvétel!</span></b>";
    }
    else {
        echo "<b><span style='color:darkred'>Sikertelen felvétel!</span></b>";
    }
}


?>
<form method="POST">
    <input type="text" name="domain_to_transfer" value="" placeholder="tesztdomain.hu">
    <input class="btn btn-primary" style="color:white" type="submit" name="send1" value="felvétel">
</form>
<hr>

<h3>Transzferelt domain státuszmódosítás (Módosításkérés &rarr; Delegált)</h3>
<?php
if (isset($_POST['send2'])) {

    $state_mod = hureg_getApiInstance($hureg_login_data)->domain()->test_set_domain_status_to_bejegyezheto(
        $_POST["domain_to_delegated"]
    );
    if ($state_mod["status"] == "success") {
        echo "<b><span style='color:darkgreen'>Sikeres státusz módosítás!</span></b>";
    }
    else {
        echo "<b><span style='color:darkred'>Sikertelen státusz módosítás!</span></b>";
    }
}
?>
<form method="POST">
    <input type="text" name="domain_to_delegated" value="" placeholder="NIC azonosító">
    <input class="btn btn-primary" style="color:white" type="submit" name="send2" value="módosítás">
</form>

<hr>

<h3>Sima domain státuszmódosítás (Elbírálás &rarr; Bejegyezhető (&rarr; Delegált))</h3>
<?php
if (isset($_POST['send3'])) {

    $state_mod = hureg_getApiInstance($hureg_login_data)->domain()->test_set_domain_status_to_delegalt(
        $_POST["domain_to_delegated2"]
    );
    if ($state_mod["status"] == "success") {
        echo "<b><span style='color:darkgreen'>Sikeres státusz módosítás!</span></b>";
    }
    else {
        echo "<b><span style='color:darkred'>Sikertelen státusz módosítás!</span></b>";
    }
}
?>
<form method="POST">
    <input type="text" name="domain_to_delegated2" value="" placeholder="NIC azonosító">
    <input class="btn btn-primary" style="color:white" type="submit" name="send3" value="módosítás">
</form>

<hr>


<table class="datatable">
    <tr>
        <th>Domain neve</th>
        <th>Fő ügyfél fiók</th>
        <th>Tulajdonos</th>
        <th>Admin kapcsolattartó</th>
        <th>Domain állapota</th>
        <th>Domain lejárat</th>
        <th>NIC azonosító</th>
        <th>Domain kezelése</th>
    </tr>
    <?php
    foreach ($hureg_domain_infos as $s) {
        $domain_object = Domain::where('domain', $s->form_domain_name)->first();

        $hureg_additional_domain_info = Capsule::table('hureg_additional_domain_informations')->where('whmcs_domain_id', $domain_object->id)->first();


        $main_client_object = Client::where('id', $s->whmcs_client_id)->first();
        $hureg_domain_form_datas = Capsule::table('hureg_domain_form_datas')->where('form_domain_name', $domain_object->domain)->first();

        if ($hureg_domain_form_datas->owner_contact_type == 0) {
            $contact_object = Client::where('id', $s->whmcs_client_id)->first();
            $owner_contact_name = $contact_object->lastName . " " . $contact_object->firstName;
            $owner_contact_type = "(számlázási)";
        } elseif ($hureg_domain_form_datas->owner_contact_type == 2) {
            $contact_object = Contact::where('id', $hureg_domain_form_datas->owner_contact_id)->first();
            $owner_contact_name = $contact_object->lastName . " " . $contact_object->firstName;
            $owner_contact_type = " (kapcsolat)";
        }

        if ($hureg_domain_form_datas->admin_contact_type == 0) {
            $contact_object = Client::where('id', $s->whmcs_client_id)->first();
            $admin_contact_name = $contact_object->lastName . " " . $contact_object->firstName;
            $admin_contact_type = " (számlázási)";
        } elseif ($hureg_domain_form_datas->admin_contact_type == 2) {
            $contact_object = Contact::where('id', $hureg_domain_form_datas->admin_contact_id)->first();
            $admin_contact_name = $contact_object->lastName . " " . $contact_object->firstName;
            $admin_contact_type = " (kapcsolat)";
        }

        ?>
        <tr>
            <td>
                <a href="clientsdomains.php?userid=<?php echo($s->whmcs_client_id); ?>&id=<?php echo($domain_object->id); ?>"><?php echo $s->form_domain_name; ?></a>
            </td>
            <td>
                <a href="clientssummary.php?userid=<?php echo($s->whmcs_client_id); ?>"><?php echo $main_client_object->lastName . " " . $main_client_object->firstName; ?></a>
            </td>


            <?php

            if ($hureg_domain_form_datas->owner_contact_type == 2) {
                ?>
                <td>
                    <a href="clientscontacts.php?userid=<?php echo($s->whmcs_client_id); ?>&contactid=<?php echo($hureg_domain_form_datas->owner_contact_id); ?>">
                        <?php echo $owner_contact_name . $owner_contact_type; ?></a></td>
                <?php
            } else {
                ?>
                <td><?php echo $owner_contact_name . $owner_contact_type; ?></td>
                <?php
            }
            if ($hureg_domain_form_datas->admin_contact_type == 2) {
                ?>
                <td>
                    <a href="clientscontacts.php?userid=<?php echo($s->whmcs_client_id); ?>&contactid=<?php echo($hureg_domain_form_datas->admin_contact_id); ?>">
                        <?php echo $admin_contact_name . $admin_contact_type; ?></a></td>
                <?php
            } else {
                ?>
                <td><?php echo $admin_contact_name . $admin_contact_type; ?></td>
                <?php
            }
            ?>


            <td><?php echo $hureg_additional_domain_info->hureg_status_text; ?><?php echo $hureg_additional_domain_info->hureg_status == "" ? "N/A" : " (" . $hureg_additional_domain_info->hureg_status . ")"; ?></td>
            <td><?php echo date("Y.m.d", strtotime($domain_object->expiryDate)); ?></td>
            <td><?php echo $hureg_additional_domain_info->domain_nic_id; ?></td>
            <td style="text-align:center;"><a
                        href="addonmodules.php?module=hureg&page=domain_manager&domain_id=<?php echo($domain_object->id); ?>">
                    <button>Adatok</button>
                </a>
                <a href="addonmodules.php?module=hureg&page=domain_logs&domain_id=<?php echo($domain_object->id); ?>">
                    <button>Logok</button>
                </a></td>


        </tr>
        <?php
    }
    $module_url = "addonmodules.php?module=hureg&page=domain_overview";
    ?>

</table>
<ul class="pagination">
    <li><a href="<?php echo $module_url; ?>&pageno=1">First</a></li>
    <li class="<?php if ($pageno <= 1) {
        echo 'disabled';
    } ?>">
        <a href="<?php echo $module_url; ?><?php if ($pageno <= 1) {
            echo '#';
        } else {
            echo "&pageno=" . ($pageno - 1);
        } ?>">Prev</a>
    </li>
    <li>

        <a style="color:black;"> <b>
                <?php
                echo $pageno;
                ?></b>
        </a>

    </li>
    <li class="<?php if ($pageno >= $total_pages) {
        echo 'disabled';
    } ?>">
        <a href="<?php echo $module_url; ?><?php if ($pageno >= $total_pages) {
            echo '#';
        } else {
            echo "&pageno=" . ($pageno + 1);
        } ?>">Next</a>
    </li>
    <li><a href="<?php echo $module_url; ?>&pageno=<?php echo $total_pages; ?>">Last</a></li>
</ul>