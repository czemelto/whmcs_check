<?php


$client_page = $_GET['page'];

$page_php_files = [
    'single_domain_confirmation' => 'single_domain_confirmation.php',
    'bulk_domain_confirmation' => 'bulk_domain_confirmation.php',
    '' => 'bulk_domain_confirmation.php'
];
$legit_pages = array_keys($page_php_files);

if (!in_array($client_page, $legit_pages)) {

    echo "Access denied!";

} else {

    require_once "processors/" . $page_php_files[$client_page];

}


?>