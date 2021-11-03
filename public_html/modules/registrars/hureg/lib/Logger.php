<?php

namespace WHMCS\Module\Registrar\Hureg;

use WHMCS\Database\Capsule;

class Logger
{
    public static function log_domain_event($event_type, $event_text, $event_data = "", $domain_name = "", $domain_whmcs_id = -1, $is_user_event = false)
    {

        try {
            $table = Capsule::table('hureg_domain_logs')->insert(
                [

                    'form_domain_name' => $domain_name,
                    'whmcs_domain_id' => $domain_whmcs_id,
                    'event_type' => $event_type,
                    'event_text' => $event_text,
                    'event_side' => $is_user_event ? "user" : "admin",
                    'event_data' => json_encode($event_data),
                    'event_time' => date("Y-m-d H:i:s")
                ]
            );
            logActivity("|Hureg| [$event_type] $event_text ($domain_name - $domain_whmcs_id)");
        } catch (Exception $e) {
            logActivity("|Hureg| Cannot write to domain database log. Reason: " . $e);
        }

        return $event_text;
    }

    public static function log_user_domain_event($event_type, $event_text, $event_data = "", $domain_name = "", $domain_whmcs_id = -1)
    {
        return self::log_domain_event($event_type, $event_text, $event_data, $domain_name, $domain_whmcs_id, true);
    }
}