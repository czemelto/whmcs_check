<?php

// custom app main body class // additional <body> classes depended on pages
return [
    'login'                             => ['login-page'],
    'logintwofa'                        => ['login-page'],
    'logout'                            => ['login-page'],
    'pwreset'                           => ['login-page'],
    'pwresetvalidation'                 => ['login-page'],
    'password-reset-container'          => ['login-page'],
    'contact'                           => ['login-page register-page'],
    'clientregister'                    => ['login-page register-page'],
    'configuredomains'                  => [false, 'is-actions'],
    'configureproduct'                  => [false, 'mob-is-actions-lg'],
    'creditcard'                        => [false, 'mob-is-actions-lg'],
    'viewcart'                          => [false, 'mob-is-actions-lg'],
    'error/page-not-found'              => ['error-page pattern-bg-error'],
    'error/unknown-routepath'              => ['error-page pattern-bg-error'],
    '/modules/addons/DomainOrdersExtended/templates/client/lagom/main.tpl' => [false, 'doe'],

    'homepage'                          => [false, 'page-with-banner'],
    'store/ssl/index'                   => [false, 'page-with-banner'],
    'store/ssl/dv'                      => [false, 'page-with-banner'],
    'store/ssl/ov'                      => [false, 'page-with-banner'],
    'store/ssl/ev'                      => [false, 'page-with-banner'],
    'store/ssl/wildcard'                => [false, 'page-with-banner'],
    'store/ssl/competitive-upgrade'     => [false, 'page-with-banner'],
    'store/weebly/index'                => [false, 'page-with-banner'],
    'store/spamexperts/index'           => [false, 'page-with-banner'],
    'store/sitelock/index'              => [false, 'page-with-banner'],
    'affiliatessignup'                  => [false, 'page-with-banner'],
    'store/codeguard/index'             => [false, 'page-with-banner'],
    'store/order'                       => [false, 'page-with-banner'],
    'store/sitelockvpn/index'           => [false, 'page-with-banner'],
    'store/ox/index'                    => [false, 'page-with-banner'],
    'store/marketgoo/index'             => [false, 'page-with-banner'],
    'oauth/layout'                      => ['login-page'],

    'two-factor-challenge'              => ['login-page'],
    'two-factor-new-backup-code'        => ['login-page'],
    'user-invite-accept'                => ['login-page'],
    
];