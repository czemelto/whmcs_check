<?php


$admin_page = $_GET['page'];

$page_php_files = [
    'domain_overview' => 'domain_overview.php',
    'domain_manager' => 'domain_manager.php',
    'domain_logs' => 'domain_logs.php',
    '' => 'domain_overview.php'
];
$legit_pages = array_keys($page_php_files);

if (!in_array($admin_page, $legit_pages)) {

    echo "Access denied!";

} else {

    require_once "processors/" . $page_php_files[$admin_page];

}


?>