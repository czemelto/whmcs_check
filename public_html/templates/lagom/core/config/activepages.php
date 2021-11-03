<?php

// page
// group, page

return [
    //homepage
    'clientareahome'                    => ['Home','Home', 'Home'],
    'homepage'                          => ['Home','Home', 'Home'],

    //services
    'clientareaproducts'                => ['Services','My Services'],
    'clientareaproductdetails'          => ['Services'],
    'addons'                            => ['Services', 'View Available Addons'],
    
    
   
    //domains
    'clientareadomains'                 => ['Domains','My Domains'],
    'clientareadomaindetails'           => ['Domains'],
    '/modules/addons/DNSManager2/templates/clientarea/default/main.tpl' => ['Domains', 'Manage DNS'],

    //billing
    'clientareainvoices'                => ['Billing', 'My Invoices'],
    'clientareaquotes'                  => ['Billing', 'My Quotes'],
    'masspay'                           => ['Billing', 'Mass Payment'],
    'clientareacreditcard'              => ['Billing', 'Manage Credit Card'],
    'clientareaaddfunds'                => ['Billing', 'Add Funds'],
    'viewinvoice'                       => ['Billing', 'My Invoices'],
    'viewquote'                         => ['Billing', 'My Quotes'],
    'creditcard'                        => ['Billing', 'My Invoices'],
    'account-paymentmethods'            => ['Billing', 'Payment Methods'],
    'account-paymentmethods-manage'     => ['Billing', 'Payment Methods'],

    //support
    'supportticketslist'                => ['Support', 'Tickets'],
    'supportticketsubmit-confirm'       => ['Support', 'Open Ticket'],    
    'supportticketsubmit-stepone'       => ['Support', 'Open Ticket'],
    'supportticketsubmit-steptwo'       => ['Support', 'Open Ticket'],

    'knowledgebase'                     => ['Support', 'Knowledgebase', 'Knowledgebase'],
    'knowledgebasearticle'              => ['Support', 'Knowledgebase', 'Knowledgebase'],
    'knowledgebasecat'                  => ['Support', 'Knowledgebase', 'Knowledgebase'],

    'announcements'                     => ['Support', 'Announcements', 'Announcements'],
    'viewannouncement'                  => ['Support', 'Announcements', 'Announcements'],

    'downloaddenied'                    => ['Support', 'Downloads'],
    'downloads'                         => ['Support', 'Downloads'],
    'downloadscat'                      => ['Support', 'Downloads'],

    'serverstatus'                      => ['Support', 'Network Status'],

    'contact'                           => ['Support', 'Contact Us', 'Contact Us'],

    //order
    'products'                          => ['Services', 'Order New Services' ,'Store'],
    'addons'                            => ['Services', 'Addons',  'Store'],
    'domainregister'                    => ['Domains', 'Register a New Domain', 'Store'],
    'domaintransfer'                    => ['Domains', 'Transfer a Domain to Us', 'Store'], 
    'domainrenewals'                    => ['Domains', 'Renew Domain', 'Store'], 
    'domain-renewals'                   => ['Domains', 'Renew Domains'],
    'store/weebly/index'                => ['Website Security', 'weebly', 'Store'],
    'store/spamexperts/index'           => ['Website Security', 'spamexperts', 'Store'],
    'store/ssl/index'                   => ['Website Security', 'symantec', 'Store'],
    'store/sitelock/index'              => ['Website Security', 'sitelock', 'Store'],
    'store/codeguard/index'             => ['Website Security', 'codeguard', 'Store'],
    'store/sitelockvpn/index'           => ['Website Security', 'sitelockvpn', 'Store'],
    'store/marketgoo/index'             => ['Website Security', 'marketgoo', 'Store'],
    'managessl'                         => ['Website Security', 'Manage SSL Certificates', 'Store'],


    //affiliates
    'affiliates'                        => ['Affiliates', 'Affiliates'],
    'affiliatessignup'                  => ['Affiliates', 'Affiliates'],

    //account
    'clientareaemails'                  => ['Account', 'Email History'],
    'clientareadetails'                 => ['Account', 'Edit Account Details'],
    'clientareachangepw'                => ['Account', 'Change Password'],
    'clientareacontacts'                => ['Account', 'Contacts/Sub-Accounts'],
    'clientareaaddcontact'              => ['Account', 'Contacts/Sub-Accounts'],
    'clientareasecurity'                => ['Account', 'clientareasecurity'],
    'viewemail'                         => ['Account', 'Email History'],
    

    //other
    '3dsecure'                          => ['3dsecure', '3dsecure'],
    'banned'                            => ['banned', 'banned'],
    'bulkdomainmanagement'              => ['bulkdomainmanagement', 'bulkdomainmanagement'],
    'bulksearch'                        => ['bulksearch', 'bulksearch'],
    'clientareacancelrequest'           => ['clientareacancelrequest', 'clientareacancelrequest'],
    'clientareadomainaddons'            => ['clientareadomainaddons', 'clientareadomainaddons'],
    'clientareadomaincontactinfo'       => ['clientareadomaincontactinfo', 'clientareadomaincontactinfo'],
    
    'clientareadomaindns'               => ['clientareadomaindns', 'clientareadomaindns'],
    'clientareadomainemailforwarding'   => ['clientareadomainemailforwarding', 'clientareadomainemailforwarding'],
    'clientareadomaingetepp'            => ['clientareadomaingetepp', 'clientareadomaingetepp'],
    'clientareadomainregisterns'        => ['clientareadomainregisterns', 'clientareadomainregisterns'],
    
    'configuressl-complete'             => ['configuressl-complete', 'configuressl-complete'],
    'configuressl-stepone'              => ['configuressl-stepone', 'configuressl-stepone'],
    'configuressl-steptwo'              => ['configuressl-steptwo', 'configuressl-steptwo'],
    'contactaccessdenied'               => ['contactaccessdenied', 'contactaccessdenied'],
    
    'domaincategorysearch'              => ['domaincategorysearch', 'domaincategorysearch'],
    'domainorder'                       => ['domainorder', 'domainorder'],
    'domaintabs'                        => ['domaintabs', 'domaintabs'],
    'forwardpage'                       => ['forwardpage', 'forwardpage'],
    'gettemplatesfromcat'               => ['gettemplatesfromcat', 'gettemplatesfromcat'],
    'invoicepdf'                        => ['invoicepdf', 'invoicepdf'],
    'listalldomains'                    => ['listalldomains', 'listalldomains'],
    'listavailabledomain'               => ['listavailabledomain', 'listavailabledomain'],
    'listavailabledomains'              => ['listavailabledomains', 'listavailabledomains'],
    'listspinner'                       => ['listspinner', 'listspinner'],
    'markdown-guide'                    => ['markdown-guide', 'markdown-guide'],
    'quotepdf'                          => ['quotepdf', 'quotepdf'],
    'ticketfeedback'                    => ['ticketfeedback', 'ticketfeedback'],
    'twitterfeed'                       => ['twitterfeed', 'twitterfeed'],
    'unsubscribe'                       => ['unsubscribe', 'unsubscribe'],
    'upgrade'                           => ['upgrade', 'upgrade'],
    'upgradesummary'                    => ['upgradesummary', 'upgradesummary'],
    
    //not used now
    'login'                             => ['login', 'login'],
    'logintwofa'                        => ['logintwofa', 'logintwofa'],
    'logout'                            => ['logout', 'logout'],
    'pwreset'                           => ['pwreset', 'pwreset'],
    'pwresetvalidation'                 => ['pwresetvalidation', 'pwresetvalidation'],
    'clientregister'                    => ['clientregister', 'clientregister'],
    
    
    // not used files for active page/group
    'header'                            => ['header', 'header'],
    'footer'                            => ['footer', 'footer'],

    'supportticketsubmit-customfields'  => ['supportticketsubmit-customfields', 'Support'],
    'supportticketsubmit-kbsuggestions' => ['supportticketsubmit-kbsuggestions', 'Support'],
    
];

