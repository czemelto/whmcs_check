<?php

/*
 * ******************************************
  RS Studio Template Hook
  1. Namespaces
  2. Navbars
  3. Sidebars
  4. Active Pages / Groups
  5. Layout Helpers
  6. Template Classes
  7. Main Grid Classes
  8. Order Redirection
  9. Page Header Type
  10. Market Connect Banners
  11. Client Area Home Panels
  12. Module Classes Helper
  13. Site Layout Helper
 * ******************************************
 */


/*
 * ******************************************
  1. Namespaces
 * ******************************************
 */

use WHMCS\Database\Capsule;
use RSThemes\Service\WhmcsHelper;
use WHMCS\View\Menu\Item as MenuItem;
use WHMCS\MarketConnect\Service;


/*
 * ******************************************
  2. Navbars
 * ******************************************
 */

add_hook('ClientAreaNavbars', -1, function () {
    $primaryNavbar = Menu::primaryNavbar();
    $secondaryNavbar = Menu::secondaryNavbar();
    
    if ($primaryNavbar && !is_null($primaryNavbar->getChild('Home'))) {
        $primaryNavbar->getChild('Home')->setIcon('fa-ticket lm lm-home')->setClass('home-item');
    }
    if ($primaryNavbar && !is_null($primaryNavbar->getChild('Store'))) {
        $primaryNavbar->getChild('Store')->setIcon('fa-ticket lm lm-basket');
    }
    if ($primaryNavbar && !is_null($primaryNavbar->getChild('Announcements'))) {
        $primaryNavbar->getChild('Announcements')->setIcon('fa-ticket lm lm-document');
    }
    if ($primaryNavbar && !is_null($primaryNavbar->getChild('Knowledgebase'))) {
        $primaryNavbar->getChild('Knowledgebase')->setIcon('fa-ticket ls ls-document-info');
    }
    
    
    
    
	if (is_null(Menu::context('client'))) {
		

        if ($primaryNavbar && !is_null($primaryNavbar->getChild('Network Status'))) {
            $primaryNavbar->removeChild('Network Status');
        }
    };
    
    /* Services */
    if ($primaryNavbar && !is_null($primaryNavbar->getChild('Services'))) {
        $servicesNavbar =  $primaryNavbar->getChild('Services');
        $servicesNavbar->setIcon('fa-ticket lm lm-hosting');
        if ($servicesNavbar && !is_null($servicesNavbar->getChild('My Services'))) {
            $servicesNavbar->getChild('My Services')->setIcon('fa-ticket ls ls-hosting');
        }
        if ($servicesNavbar && !is_null($servicesNavbar->getChild('My Licenses'))) {
            $servicesNavbar->getChild('My Licenses')->setIcon('fa-ticket ls ls-chain');
        }
        if ($servicesNavbar && !is_null($servicesNavbar->getChild('Order New Services'))) {
            $servicesNavbar->getChild('Order New Services')->setIcon('fa-ticket ls ls-box');
        }
        if ($servicesNavbar && !is_null($servicesNavbar->getChild('View Available Addons'))) {
            $servicesNavbar->getChild('View Available Addons')->setIcon('fa-ticket ls ls-addon');
        }
    }
    
    /* Domains */
    if ($primaryNavbar && !is_null($primaryNavbar->getChild('Domains'))) {
        $domainNavbar =  $primaryNavbar->getChild('Domains');
        $domainNavbar->setIcon('fa-ticket lm lm-globe');
        if ($domainNavbar && !is_null($domainNavbar->getChild('Domains Divider 2'))) {
            $domainNavbar->removeChild('Domains Divider 2');
        }
        if ($domainNavbar && !is_null($domainNavbar->getChild('Domain Search'))) {
            $domainNavbar->removeChild('Domain Search');
        }
        if ($domainNavbar && !is_null($domainNavbar->getChild('My Domains'))) {
            $domainNavbar->getChild('My Domains')->setIcon('fa-ticket lm lm-globe');
        }
        if ($domainNavbar && !is_null($domainNavbar->getChild('Manage DNS'))) {
            $domainNavbar->getChild('Manage DNS')->setIcon('fa-ticket ls ls-input-code');
        }
       
        if ($domainNavbar && !is_null($domainNavbar->getChild('Renew Domains'))) {
            $domainNavbar->getChild('Renew Domains')->setIcon('fa-ticket ls ls-refresh');
        }
        if ($domainNavbar && !is_null($domainNavbar->getChild('Register a New Domain'))) {
            $domainNavbar->getChild('Register a New Domain')->setIcon('fa-ticket ls ls-dns');
        }
        if ($domainNavbar && !is_null($domainNavbar->getChild('Transfer a Domain to Us'))) {
            $domainNavbar->getChild('Transfer a Domain to Us')->setIcon('fa-ticket ls ls-transfer');
        }
    }
    
    
    /* Billing */
    if ($primaryNavbar && !is_null($primaryNavbar->getChild('Billing'))) {
        $billingNavbar =  $primaryNavbar->getChild('Billing');
        $billingNavbar->setIcon('fa-ticket lm lm-document');
        if ($billingNavbar && !is_null($billingNavbar->getChild('My Invoices'))) {
            $billingNavbar->getChild('My Invoices')->setIcon('fa-ticket ls ls-document');
        }
        if ($billingNavbar && !is_null($billingNavbar->getChild('My Quotes'))) {
            $billingNavbar->getChild('My Quotes')->setIcon('fa-ticket ls ls-text-cloud');
        }
        if ($billingNavbar && !is_null($billingNavbar->getChild('Mass Payment'))) {
            $billingNavbar->getChild('Mass Payment')->setIcon('fa-ticket ls ls-document');
        }
        if ($billingNavbar && !is_null($billingNavbar->getChild('Mass Payment'))) {
            $billingNavbar->getChild('Mass Payment')->setIcon('fa-ticket ls ls-bank-note');
        }
        if ($billingNavbar && !is_null($billingNavbar->getChild('Manage Credit Card'))) {
            $billingNavbar->getChild('Manage Credit Card')->setIcon('fa-ticket ls ls-credit-card');
        }
        if ($billingNavbar && !is_null($billingNavbar->getChild('Payment Methods'))) {
            $billingNavbar->getChild('Payment Methods')->setIcon('fa-ticket ls ls-credit-card');
        }
        if ($billingNavbar && !is_null($billingNavbar->getChild('Add Funds'))) {
            $billingNavbar->getChild('Add Funds')->setIcon('fa-ticket ls ls-credit');
        }
       
    }
    
    /* Support */
    if ($primaryNavbar && !is_null($primaryNavbar->getChild('Support'))) {
        $supportNavbar =  $primaryNavbar->getChild('Support');
        if ($supportNavbar && !is_null($supportNavbar->getChild('Open Ticket'))) {
            $supportNavbar->removeChild('Open Ticket');
        }
        $supportNavbar->setIcon('fa-ticket lm lm-envelope');
        $supportNavbar->addChild('open-ticket', array(
            'label' => Lang::trans('navopenticket'),
            'uri' => 'submitticket.php',
            'order' => '99',
        ));
        if ($supportNavbar && !is_null($supportNavbar->getChild('open-ticket'))) {
            $supportNavbar->getChild('open-ticket')->setClass('open-ticket-item');
        }     
        if ($supportNavbar && !is_null($supportNavbar->getChild('Tickets'))) {
            $supportNavbar->getChild('Tickets')->setIcon('fa-ticket ls ls-envelope');
        }
        if ($supportNavbar && !is_null($supportNavbar->getChild('Announcements'))) {
            $supportNavbar->getChild('Announcements')->setIcon('fa-ticket ls ls-text-cloud');
        }
        if ($supportNavbar && !is_null($supportNavbar->getChild('Knowledgebase'))) {
            $supportNavbar->getChild('Knowledgebase')->setIcon('fa-ticket ls ls-document-info');
        }
        if ($supportNavbar && !is_null($supportNavbar->getChild('Downloads'))) {
            $supportNavbar->getChild('Downloads')->setIcon('fa-ticket ls ls-download-square');
        }
        if ($supportNavbar && !is_null($supportNavbar->getChild('Network Status'))) {
            $supportNavbar->getChild('Network Status')->setIcon('fa-ticket ls ls-range');
        }
        if ($supportNavbar && !is_null($supportNavbar->getChild('open-ticket'))) {
            $supportNavbar->getChild('open-ticket')->setIcon('fa-ticket ls ls-new-window');
        }
    }
    if ($primaryNavbar && !is_null($primaryNavbar->getChild('Announcements'))) {
        $primaryNavbar->getChild('Announcements')->setLabel(Lang::trans('news'));
    }
    
    if ($primaryNavbar && !is_null($primaryNavbar->getChild('Affiliates'))) {
        $primaryNavbar->getChild('Affiliates')->setIcon('fa-ticket lm lm-bar-graph');
    }
    if ($primaryNavbar && !is_null($primaryNavbar->getChild('Open Ticket'))) {
        $primaryNavbar->removeChild('Open Ticket');
    }
    if ($primaryNavbar && !is_null($primaryNavbar->getChild('Contact Us'))) {
        $primaryNavbar->getChild('Contact Us')->setIcon('fa-ticket lm lm-envelope');
    }
    if ($primaryNavbar && !is_null($primaryNavbar->getChild('Website Security'))) {
        $websiteNavbar =  $primaryNavbar->getChild('Website Security');
        $websiteNavbar->setIcon('fa-ticket lm lm-php-admin');
        if ($websiteNavbar && !is_null($websiteNavbar->getChild('symantec'))) {
             $websiteNavbar->getChild('symantec')->setIcon('fa-ticket ls ls-shield');
        }
        if ($websiteNavbar && !is_null($websiteNavbar->getChild('weebly'))) {
            $websiteNavbar->getChild('weebly')->setIcon('fa-ticket ls ls-dashboard');
        }
        if ($websiteNavbar && !is_null($websiteNavbar->getChild('spamexperts'))) {
            $websiteNavbar->getChild('spamexperts')->setIcon('fa-ticket ls ls-envelope');
        }
        if ($websiteNavbar && !is_null($websiteNavbar->getChild('sitelock'))) {
            $websiteNavbar->getChild('sitelock')->setIcon('fa-ticket ls ls-padlock');
        }
        if ($websiteNavbar && !is_null($websiteNavbar->getChild('Manage SSL Certificates'))) {
            $websiteNavbar->getChild('Manage SSL Certificates')->setIcon('fa-ticket ls ls-security-code');
        }
        if ($websiteNavbar && !is_null($websiteNavbar->getChild('codeguard'))) {
            $websiteNavbar->getChild('codeguard')->setIcon('fa-ticket ls ls-copy');
        }
        if ($websiteNavbar && !is_null($websiteNavbar->getChild('sitelockvpn'))) {
            $websiteNavbar->getChild('sitelockvpn')->setIcon('fa-ticket ls ls-shield');
        }
        if ($websiteNavbar && !is_null($websiteNavbar->getChild('marketgoo'))) {
            $websiteNavbar->getChild('marketgoo')->setIcon('fa-ticket ls ls-range');
        }   
        if ($websiteNavbar && !is_null($websiteNavbar->getChild('ox'))) {
            $websiteNavbar->getChild('ox')->setIcon('fa-ticket ls ls-envelope');
        }   
    }
    if ($primaryNavbar && !is_null($primaryNavbar->getChild('pm-addon-overview'))) {
        $primaryNavbar->getChild('pm-addon-overview')->setIcon('fa-folder lm lm-folder');
    }

    if ($secondaryNavbar && !is_null($secondaryNavbar->getChild('Account'))) {
        $accountNavbar = $secondaryNavbar->getChild('Account');
        $accountNavbar->setIcon('fa-ticket lm lm-user');
        if ($accountNavbar && !is_null($accountNavbar->getChild('Manage Credit Card'))) {
            $accountNavbar->removeChild('Manage Credit Card');
        }
    }

    
    
});

/*
 * ******************************************
  3. Sidebars
 * ******************************************
 */

add_hook('ClientAreaSidebars', 1, function($vars) {  
    $primarySidebar = Menu::primarySidebar();
    $secondarySidebar = Menu::secondarySidebar();

    //dashboard
    if ($primarySidebar && !is_null($primarySidebar->getChild('Client Details'))) {
        $primarySidebar->getChild('Client Details')->setClass('panel-client-details');
    }
    if ($secondarySidebar && !is_null($secondarySidebar->getChild('Client Contacts'))) {
        $secondarySidebar->getChild('Client Contacts')->setClass('panel-client-contacts');
        $secondarySidebar->getChild('Client Contacts')->addChild('more')
        ->setUri('clientarea.php?action=contacts')
        ->setLabel(Lang::trans('more'))
        ->setClass('contact-more')
        ->setIcon('fa-ticket ls ls-more')
        ->setOrder(1000);
    }
    if ($secondarySidebar && !is_null($secondarySidebar->getChild('Client Shortcuts'))) {
        $shortcutsSidebar = $secondarySidebar->getChild('Client Shortcuts');
        if (!is_null($shortcutsSidebar->getChild('Order New Services'))){
            $shortcutsSidebar->getChild('Order New Services')->setIcon('fa-ticket ls ls-basket');
        }
        if (!is_null($shortcutsSidebar->getChild('Register New Domain'))){
            $shortcutsSidebar->getChild('Register New Domain')->setIcon('fa-ticket ls ls-dns');
        }
        if (!is_null($shortcutsSidebar->getChild('Logout'))){
            $shortcutsSidebar->getChild('Logout')->setIcon('fa-ticket ls ls-reply');
        }
    }
    //my account
    if ($primarySidebar && !is_null($primarySidebar->getChild('My Account'))) {
        $accountSidebar = $primarySidebar->getChild('My Account');
        if (!is_null($accountSidebar->getChild('My Details'))){
            $accountSidebar->getChild('My Details')->setIcon('fa-ticket ls ls-user');
        }
        if (!is_null($accountSidebar->getChild('Billing Information'))){
            $accountSidebar->removeChild('Billing Information');
        }
        if (!is_null($accountSidebar->getChild('Payment Methods'))){
            $accountSidebar->getChild('Payment Methods')->setIcon('fa-ticket ls ls-credit-card');
        }
        if (!is_null($accountSidebar->getChild('Contacts/Sub-Accounts'))){
            $accountSidebar->getChild('Contacts/Sub-Accounts')->setIcon('fa-ticket ls ls-user');
        }
        if (!is_null($accountSidebar->getChild('Change Password'))){
            $accountSidebar->getChild('Change Password')->setIcon('fa-ticket ls ls-padlock');
        }
        if (!is_null($accountSidebar->getChild('Security Settings'))){
            $accountSidebar->getChild('Security Settings')->setIcon('fa-ticket ls ls-shield');
        }
        if (!is_null($accountSidebar->getChild('Email History'))){
            $accountSidebar->getChild('Email History')->setIcon('fa-ticket ls ls-envelope');
        }
    }  
    if ($primarySidebar && !is_null($primarySidebar->getChild('My Account')) && $secondarySidebar && !is_null($secondarySidebar->getChild('Billing'))) {
        $primarySidebar->removeChild('My Account');
    }

    //account
    if ($primarySidebar && !is_null($primarySidebar->getChild('Account'))) {
        $accountSidebar = $primarySidebar->getChild('Account');
        if (!is_null($accountSidebar->getChild('My Details'))){
            $accountSidebar->getChild('My Details')->setIcon('fa-ticket ls ls-user');
        }
        if (!is_null($accountSidebar->getChild('Billing Information'))){
            $accountSidebar->removeChild('Billing Information');
        }
        if (!is_null($accountSidebar->getChild('Payment Methods'))){
            $accountSidebar->getChild('Payment Methods')->setIcon('fa-ticket ls ls-credit-card');
        }
        if (!is_null($accountSidebar->getChild('Contacts/Sub-Accounts'))){
            $accountSidebar->getChild('Contacts/Sub-Accounts')->setIcon('fa-ticket ls ls-user');
        }
        if (!is_null($accountSidebar->getChild('Change Password'))){
            $accountSidebar->getChild('Change Password')->setIcon('fa-ticket ls ls-padlock');
        }
        if (!is_null($accountSidebar->getChild('Security Settings'))){
            $accountSidebar->getChild('Security Settings')->setIcon('fa-ticket ls ls-shield');
        }
        if (!is_null($accountSidebar->getChild('Account Security'))){
            $accountSidebar->getChild('Account Security')->setIcon('fa-ticket ls ls-shield');
        }
        if (!is_null($accountSidebar->getChild('Email History'))){
            $accountSidebar->getChild('Email History')->setIcon('fa-ticket ls ls-envelope');
        }
        if (!is_null($accountSidebar->getChild('User Management'))){
            $accountSidebar->getChild('User Management')->setIcon('fa-ticket ls ls-configure');
        }
    }  
    if ($primarySidebar && !is_null($primarySidebar->getChild('Account')) && $secondarySidebar && !is_null($secondarySidebar->getChild('Billing'))) {
        $primarySidebar->removeChild('Account');
    }

    // your profile
    if ($primarySidebar && !is_null($primarySidebar->getChild('Profile'))) {
        $profileSidebar = $primarySidebar->getChild('Profile');
        if (!is_null($profileSidebar->getChild('Your Profile'))){
            $profileSidebar->getChild('Your Profile')->setIcon('fa-ticket ls ls-user');
        }
        if (!is_null($profileSidebar->getChild('Change Password'))){
            $profileSidebar->getChild('Change Password')->setIcon('fa-ticket ls ls-padlock');
        }
        if (!is_null($profileSidebar->getChild('User Security'))){
            $profileSidebar->getChild('User Security')->setIcon('fa-ticket ls ls-shield');
        }
        if (!is_null($profileSidebar->getChild('Logout'))){
            $profileSidebar->getChild('Logout')->setIcon('fa-ticket ls ls-sign-out');
        }
        if (!is_null($profileSidebar->getChild('Switch Account'))){
            $profileSidebar->getChild('Switch Account')->setIcon('fa-ticket ls ls-refresh');
        }
        
    }  
    
    //support
    if ($primarySidebar && !is_null($primarySidebar->getChild('Support Knowledgebase Categories'))) {
        $primarySidebar->removeChild('Support Knowledgebase Categories');
    }
    if ($secondarySidebar && !is_null($secondarySidebar->getChild('Support Knowledgebase Tag Cloud'))) {
        $secondarySidebar->getChild('Support Knowledgebase Tag Cloud')->setClass('panel-support-tags');
    }
    if ($primarySidebar && !is_null($primarySidebar->getChild('Ticket Information'))) {
        $primarySidebar->getChild('Ticket Information')->setClass('panel-ticket-information');
    }
    if ($secondarySidebar && !is_null($secondarySidebar->getChild('Support'))) {
        $supportSidebar = $secondarySidebar->getChild('Support');
        if (!is_null($supportSidebar->getChild('Support Tickets'))){
            $supportSidebar->getChild('Support Tickets')->setIcon('fa-ticket ls ls-ticket-tag');
        }
        if (!is_null($supportSidebar->getChild('Announcements'))){
            $supportSidebar->getChild('Announcements')->setIcon('fa-ticket ls ls-text-cloud');
        }
        if (!is_null($supportSidebar->getChild('Knowledgebase'))){
            $supportSidebar->getChild('Knowledgebase')->setIcon('fa-ticket ls ls-document-info');
        }
        if (!is_null($supportSidebar->getChild('Downloads'))){
            $supportSidebar->getChild('Downloads')->setIcon('fa-ticket ls ls-download-square');
        }
        if (!is_null($supportSidebar->getChild('Network Status'))){
            $supportSidebar->getChild('Network Status')->setIcon('fa-ticket ls ls-range');
        }
        if (!is_null($supportSidebar->getChild('Open Ticket'))){
            $supportSidebar->getChild('Open Ticket')->setIcon('fa-ticket ls ls-new-window');
        }   
    }
    if ($secondarySidebar && !is_null($secondarySidebar->getChild('Popular Downloads'))) {
        $secondarySidebar->removeChild('Popular Downloads');
    }
    if ($primarySidebar && !is_null($primarySidebar->getChild('Ticket List Status Filter'))) {
        $primarySidebar->removeChild('Ticket List Status Filter');
    }
    
    if ($primarySidebar && !is_null($primarySidebar->getChild('Announcements Months'))) {
        $annoucementSidebar = $primarySidebar->getChild('Announcements Months');
        if (!is_null($annoucementSidebar->getChild('Older'))){
            $annoucementSidebar->getChild('Older')->setIcon('fa-ticket ls ls-hourglass');
        }
        if (!is_null($annoucementSidebar->getChild('RSS Feed'))){
            $annoucementSidebar->getChild('RSS Feed')->setIcon('fa-ticket ls ls-rss');
        }
    }
    if ($secondarySidebar && !is_null($secondarySidebar->getChild('Recent Tickets'))) {
        $secondarySidebar->getChild('Recent Tickets')->setClass('panel-recent-tickets');
    }
    if ($primarySidebar && !is_null($primarySidebar->getChild('Network Status'))) {
        $primarySidebar->removeChild('Network Status');
    }

    // Billing
    if ($secondarySidebar && !is_null($secondarySidebar->getChild('Billing'))) {
        $billingSidebar = $secondarySidebar->getChild('Billing');
        if (!is_null($billingSidebar->getChild('Invoices'))){
            $billingSidebar->getChild('Invoices')->setIcon('fa-ticket ls ls-document');
        }
        if (!is_null($billingSidebar->getChild('Quotes'))){
            $billingSidebar->getChild('Quotes')->setIcon('fa-ticket ls ls-text-cloud');
        }
        if (!is_null($billingSidebar->getChild('Mass Payment'))){
            $billingSidebar->getChild('Mass Payment')->setIcon('fa-ticket ls ls-bank-note');
        }
        if (!is_null($billingSidebar->getChild('Manage Credit Card'))){
            $billingSidebar->getChild('Manage Credit Card')->setIcon('fa-ticket ls ls-credit-card');
        }
        if (!is_null($billingSidebar->getChild('Add Funds'))){
            $billingSidebar->getChild('Add Funds')->setIcon('fa-ticket ls ls-credit');
        }
    }
    if ($primarySidebar && !is_null($primarySidebar->getChild('My Invoices Summary'))) {
        $primarySidebar->removeChild('My Invoices Summary');
    }
    if ($primarySidebar && !is_null($primarySidebar->getChild('My Invoices Status Filter'))) {
        $primarySidebar->removeChild('My Invoices Status Filter');
    }
    if ($primarySidebar && !is_null($primarySidebar->getChild('My Quotes Status Filter'))) {
        $primarySidebar->removeChild('My Quotes Status Filter');
    }
    
    //add funds
    if ($primarySidebar && !is_null($primarySidebar->getChild('Add Funds'))) {
        $primarySidebar->removeChild('Add Funds');
    }

    //my services
    if ($primarySidebar && !is_null($primarySidebar->getChild('My Services Status Filter'))) {
        $primarySidebar->removeChild('My Services Status Filter');
    }
    if ($primarySidebar && !is_null($primarySidebar->getChild('Service Details Overview'))) {
        $servicesSidebar = $primarySidebar->getChild('Service Details Overview');
        if (!is_null($servicesSidebar->getChild('Information'))){
            $servicesSidebar->getChild('Information')->setIcon('fa-ticket ls ls-dashboard');
        }
        if (!is_null($servicesSidebar->getChild('Change Password'))){
            $servicesSidebar->getChild('Change Password')->setIcon('fa-ticket ls ls-padlock');
        }
        if (!is_null($servicesSidebar->getChild('Downloads'))){
            $servicesSidebar->getChild('Downloads')->setIcon('fa-ticket ls ls-download-square');
        }
        if (!is_null($servicesSidebar->getChild('Addons'))){
            $servicesSidebar->getChild('Addons')->setIcon('fa-ticket ls ls-addon');
        }
    }
    if ($primarySidebar && !is_null($primarySidebar->getChild('Service Details Actions'))) {
        $servicesSidebar = $primarySidebar->getChild('Service Details Actions');
        if (!is_null($servicesSidebar->getChild('Login to cPanel'))){
            $servicesSidebar->getChild('Login to cPanel')->setIcon('fa-ticket ls ls-user');
        }
        if (!is_null($servicesSidebar->getChild('Login to WHM'))){
            $servicesSidebar->getChild('Login to WHM')->setIcon('fa-ticket ls ls-user');
        }
        if (!is_null($servicesSidebar->getChild('Login to Webmail'))){
            $servicesSidebar->getChild('Login to Webmail')->setIcon('fa-ticket ls ls-user');
        }
        if (!is_null($servicesSidebar->getChild('Change Password'))){
            $servicesSidebar->getChild('Change Password')->setIcon('fa-ticket ls ls-padlock');
        }
        if (!is_null($servicesSidebar->getChild('Cancel'))){
            $servicesSidebar->getChild('Cancel')->setIcon('fa-ticket ls ls-denial');
        }
        if (!is_null($servicesSidebar->getChild('Upgrade/Downgrade'))){
            $servicesSidebar->getChild('Upgrade/Downgrade')->setIcon('fa-ticket ls ls-new-window');
        }
        if (!is_null($servicesSidebar->getChild('Upgrade/Downgrade Options'))){
            $servicesSidebar->getChild('Upgrade/Downgrade Options')->setIcon('fa-ticket ls ls-configure');
        }
        if (!is_null($servicesSidebar->getChild('Configure SSL'))){
            $servicesSidebar->getChild('Configure SSL')->setIcon('fa-ticket ls ls-configure');
        }
        if (!is_null($servicesSidebar->getChild('client_change_approver_email'))){
            $servicesSidebar->getChild('client_change_approver_email')->setIcon('fa-ticket ls ls-transfer');
        }
        if (!is_null($servicesSidebar->getChild('client_retrieve_certificate'))){
            $servicesSidebar->getChild('client_retrieve_certificate')->setIcon('fa-ticket ls ls-download');
        }
        if (!is_null($servicesSidebar->getChild('client_reissue_certificate'))){
            $servicesSidebar->getChild('client_reissue_certificate')->setIcon('fa-ticket ls ls-refresh');
        }
        if (!is_null($servicesSidebar->getChild('mg-unbanCenter'))){
            $servicesSidebar->getChild('mg-unbanCenter')->setIcon('fa-ticket ls ls-denial');
        }
    }
    
    if ($secondarySidebar && !is_null($secondarySidebar->getChild('My Services Actions'))) {
        $servicesSidebar = $secondarySidebar->getChild('My Services Actions');
        if (!is_null($servicesSidebar->getChild('Place a New Order'))){
            $servicesSidebar->getChild('Place a New Order')->setIcon('fa-ticket ls ls-box');
        }
        if (!is_null($servicesSidebar->getChild('View Available Addons'))){
            $servicesSidebar->getChild('View Available Addons')->setIcon('fa-ticket ls ls-addon');
        }
    }   
    if ($secondarySidebar && !is_null($secondarySidebar->getChild('Sitelock Sidebar Promo'))) {
        $secondarySidebar->removeChild('Sitelock Sidebar Promo');
    }
    if ($secondarySidebar && !is_null($secondarySidebar->getChild('Spamexperts Sidebar Promo'))) {
        $secondarySidebar->removeChild('Spamexperts Sidebar Promo');
    }
    if ($secondarySidebar && !is_null($secondarySidebar->getChild('Ssl Sidebar Promo'))) {
        $secondarySidebar->removeChild('Ssl Sidebar Promo');
    }
    if ($secondarySidebar && !is_null($secondarySidebar->getChild('Weebly Sidebar Promo'))) {
        $secondarySidebar->removeChild('Weebly Sidebar Promo');
    }
    if ($secondarySidebar && !is_null($secondarySidebar->getChild('Codeguard Sidebar Promo'))) {
        $secondarySidebar->removeChild('Codeguard Sidebar Promo');
    }
    if ($secondarySidebar && !is_null($secondarySidebar->getChild('Sitelockvpn Sidebar Promo'))) {
        $secondarySidebar->removeChild('Sitelockvpn Sidebar Promo');
    }
    if ($secondarySidebar && !is_null($secondarySidebar->getChild('Marketgoo Sidebar Promo'))) {
        $secondarySidebar->removeChild('Marketgoo Sidebar Promo');
    }
    if ($secondarySidebar && !is_null($secondarySidebar->getChild('Ox Sidebar Promo'))) {
        $secondarySidebar->removeChild('Ox Sidebar Promo');
    }
    if ($secondarySidebar && !is_null($secondarySidebar->getChild('Symantec Sidebar Promo'))) {
        $secondarySidebar->removeChild('Symantec Sidebar Promo');
    }
   
    //Upgrade Downgrade
    if ($primarySidebar && !is_null($primarySidebar->getChild('Upgrade Downgrade'))) {
        $primarySidebar->getChild('Upgrade Downgrade')->setClass('panel-primary');
    }

    //my domains
    if ($primarySidebar && !is_null($primarySidebar->getChild('My Domains Status Filter'))) {
        $primarySidebar->removeChild('My Domains Status Filter');
    }
    if ($secondarySidebar && !is_null($secondarySidebar->getChild('My Domains Actions'))) {
        $domainsSidebar = $secondarySidebar->getChild('My Domains Actions');
        if (!is_null($domainsSidebar->getChild('Renew Domain'))){
            $domainsSidebar->getChild('Renew Domain')->setIcon('fa-ticket ls ls-refresh');
        }
        if (!is_null($domainsSidebar->getChild('Register a New Domain'))){
            $domainsSidebar->getChild('Register a New Domain')->setIcon('fa-ticket ls ls-dns');
        }
        if (!is_null($domainsSidebar->getChild('Transfer in a Domain'))){
            $domainsSidebar->getChild('Transfer in a Domain')->setIcon('fa-ticket ls ls-transfer');
        }
    }   
    //domains management
    if ($primarySidebar && !is_null($primarySidebar->getChild('Domain Details Management'))) {
        $domainsDetailsSidebar = $primarySidebar->getChild('Domain Details Management');
        if (!is_null($domainsDetailsSidebar->getChild('Overview'))){
            $domainsDetailsSidebar->getChild('Overview')->setIcon('fa-ticket ls ls-dashboard');
        }
        if (!is_null($domainsDetailsSidebar->getChild('Auto Renew Settings'))){
            $domainsDetailsSidebar->getChild('Auto Renew Settings')->setIcon('fa-ticket ls ls-refresh');
        }
        if (!is_null($domainsDetailsSidebar->getChild('Modify Nameservers'))){
            $domainsDetailsSidebar->getChild('Modify Nameservers')->setIcon('fa-ticket ls ls ls-share');
        }
        if (!is_null($domainsDetailsSidebar->getChild('Registrar Lock Status'))){
            $domainsDetailsSidebar->getChild('Registrar Lock Status')->setIcon('fa-ticket ls ls-shield');
        }
        if (!is_null($domainsDetailsSidebar->getChild('Domain Addons'))){
            $domainsDetailsSidebar->getChild('Domain Addons')->setIcon('fa-ticket ls ls-addon');
        }
        if (!is_null($domainsDetailsSidebar->getChild('Domain Contacts'))){
            $domainsDetailsSidebar->getChild('Domain Contacts')->setIcon('fa-ticket ls ls-user');
        }
        if (!is_null($domainsDetailsSidebar->getChild('Manage Private Nameservers'))){
            $domainsDetailsSidebar->getChild('Manage Private Nameservers')->setIcon('fa-ticket ls ls-share');
        }
        if (!is_null($domainsDetailsSidebar->getChild('Manage DNS Host Records'))){
            $domainsDetailsSidebar->getChild('Manage DNS Host Records')->setIcon('fa-ticket ls ls-dns');
        }
        if (!is_null($domainsDetailsSidebar->getChild('Manage Email Forwarding'))){
            $domainsDetailsSidebar->getChild('Manage Email Forwarding')->setIcon('fa-ticket ls ls-envelope');
        }
        if (!is_null($domainsDetailsSidebar->getChild('Get EPP Code'))){
            $domainsDetailsSidebar->getChild('Get EPP Code')->setIcon('fa-ticket ls ls-input-code');
        }
    }
    if ($secondarySidebar && !is_null($secondarySidebar->getChild('Domain Details Actions'))) {
        $domainsDetailsActionsSidebar = $secondarySidebar->getChild('Domain Details Actions');
        if (!is_null($domainsDetailsActionsSidebar->getChild('Renew Domain'))){
            $domainsDetailsActionsSidebar->getChild('Renew Domain')->setIcon('fa-ticket ls ls-refresh');
        }
        if (!is_null($domainsDetailsActionsSidebar->getChild('Register a New Domain'))){
            $domainsDetailsActionsSidebar->getChild('Register a New Domain')->setIcon('fa-ticket ls ls-dns');
        }
        if (!is_null($domainsDetailsActionsSidebar->getChild('Transfer in a Domain'))){
            $domainsDetailsActionsSidebar->getChild('Transfer in a Domain')->setIcon('fa-ticket ls ls-transfer');
        }
    }
    //orderform
    if ($secondarySidebar && !is_null($secondarySidebar->getChild('Actions'))) {
        $cartActionsSidebar = $secondarySidebar->getChild('Actions');
        if (!is_null($cartActionsSidebar->getChild('Domain Renewals'))){
            $cartActionsSidebar->getChild('Domain Renewals')->setIcon('fa-ticket ls ls-refresh');
        }
        if (!is_null($cartActionsSidebar->getChild('Domain Registration'))){
            $cartActionsSidebar->getChild('Domain Registration')->setIcon('fa-ticket ls ls-dns');
        }
        if (!is_null($cartActionsSidebar->getChild('Domain Transfer'))){
            $cartActionsSidebar->getChild('Domain Transfer')->setIcon('fa-ticket ls ls-transfer');
        }
        if (!is_null($cartActionsSidebar->getChild('View Cart'))){
            $cartActionsSidebar->getChild('View Cart')->setIcon('fa-ticket ls ls-basket');
        }
    }
});

/*
 * ******************************************
  4. Active Pages / Groups
 * ******************************************
*/

add_hook('ClientAreaPage', 2, function($vars) {

    $actionFile = $vars['templatefile'];

    $primarySidebar = Menu::primarySidebar();
    $secondarySidebar = Menu::secondarySidebar();
    if ($actionFile == "bulkdomainmanagement"){
        if ($primarySidebar && !is_null($primarySidebar->getChild('Client Details'))) {
            $primarySidebar->removeChild('Client Details');
        }
    }


    $configFilePath = realpath(dirname(__FILE__)) . DS .'..'.DS. 'config' . DS . 'activepages.php';
   
  
    if (file_exists($configFilePath)) {
        $config = require_once $configFilePath;
        if (isset($config[$actionFile])) {
            if (count($config[$actionFile]) == 1) {
                return [
                    'rsactivepage' => $config[$actionFile][0],
                    'rsactivegroup' => $actionFile,
                ];
            } else if (count($config[$actionFile]) == 2) {
                return [
                    'rsactivepage' => $config[$actionFile][1],
                    'rsactivegroup' => $config[$actionFile][0],
                ];
            } else if (count($config[$actionFile]) == 3) {
                if ($_SESSION['uid']) {
                    return [
                        'rsactivepage' => $config[$actionFile][1],
                        'rsactivegroup' => $config[$actionFile][0],
                    ];
                } else {
                    return [
                        'rsactivepage' => $config[$actionFile][1],
                        'rsactivegroup' => $config[$actionFile][2],
                    ];
                }
            } else if (count($config[$actionFile]) == 4) {
                if ($_SESSION['uid']) {
                    return [
                        'rsactivepage' => $config[$actionFile][1],
                        'rsactivegroup' => $config[$actionFile][0],
                    ];
                } else {
                    return [
                        'rsactivepage' => $config[$actionFile][3],
                        'rsactivegroup' => $config[$actionFile][2],
                    ];
                }
            } else {
                return [
                    'rsactivepage' => $actionFile,
                    'rsactivegroup' => $config[$actionFile][0],
                ];
            }
        } else {
            return [
                'rsactivepage' => $actionFile,
                'rsactivegroup' => $actionFile,
            ];
        }
    }
});

/*
 * ******************************************
  5. Layout Helpers
 * ******************************************
*/

add_hook('ClientAreaPage', 2, function($vars) {
    $actionFile = $vars['templatefile'];
    $configFilePath = realpath(dirname(__FILE__)) . DS .'..'.DS. 'config' . DS . 'layouthelpers.php';
    if (file_exists($configFilePath)) { 
        $config = require_once $configFilePath;
        if (isset($config[$actionFile])) {
            if (count($config[$actionFile]) == 1) {
                return [
                    'ignoreSidebars' => $config[$actionFile][0],
                    'ignoreHeader' => false,
                    'forceSidebar' => false,
                ];
            } else if (count($config[$actionFile]) == 2) {
                return [
                    'ignoreSidebars' => $config[$actionFile][0],
                    'ignoreHeader' => $config[$actionFile][1],
                    'forceSidebar' => false,
                ];
            }
            else if (count($config[$actionFile]) == 3) {
                return [
                    'ignoreSidebars' => $config[$actionFile][0],
                    'ignoreHeader' => $config[$actionFile][1],
                    'forceSidebar' => $config[$actionFile][2],
                ];
            }
            else{
                return [
                    'ignoreSidebars' => false,
                    'ignoreHeader' => false,
                    'forceSidebar' => false,
                ];
            }
        } else {
            return [
                'ignoreSidebars' => false,
                'ignoreHeader' => false,
                'forceSidebar' => false,
            ];
        }
    }
});


/*
 * ******************************************
  6. Template Classes
 * ******************************************
 */

add_hook('ClientAreaPage', 2, function($vars) {
    $actionFile = $vars['templatefile'];
    $configFilePath = realpath(dirname(__FILE__)) . DS .'..'.DS. 'config' . DS . 'templateclasses.php';
    if (file_exists($configFilePath)) { 
        $config = require_once $configFilePath;
        if (isset($config[$actionFile])) {
            if (count($config[$actionFile]) == 1) {
                return [
                    'appMainBodyClasses' => $config[$actionFile][0],
                    'bodyClasses' => false,
                ];
            } else if (count($config[$actionFile]) == 2) {
                return [
                    'appMainBodyClasses' => $config[$actionFile][0],
                    'bodyClasses' => $config[$actionFile][1],
                ];
            }
            else{
                return [
                    'appMainBodyClasses' => false,
                    'bodyClasses' => false,
                ];
            }
        } else {
            return [
                'appMainBodyClasses' => false,
                'bodyClasses' => false,
            ];
        }
    }
});

/*
 * ******************************************
  7. Main Grid Classes
 * ******************************************
*/

add_hook('ClientAreaPage', 2, function($vars) {    
    $actionFile = $vars['templatefile'];
    $configFilePath = realpath(dirname(__FILE__)) . DS .'..'.DS. 'config' . DS . 'maingridclasses.php';
    if (file_exists($configFilePath)) { 
        $config = require_once $configFilePath;
        if (isset($config[$actionFile])) {
            if (count($config[$actionFile]) == 1) {
                return [
                    'mainGridNoSidebarClass' => $config[$actionFile][0],
                    'mainGridOrderClass' => false,
                ];
            } else if (count($config[$actionFile]) == 2) {
                return [
                    'mainGridNoSidebarClass' => $config[$actionFile][0],
                    'mainGridOrderClass' => $config[$actionFile][1],
                ];
            }
            else{
                return [
                    'mainGridNoSidebarClass' => false,
                    'mainGridOrderClass' => false,
                ];
            }
        } else {
            return [
                'mainGridNoSidebarClass' => false,
                'mainGridOrderClass' => false,
            ];
        }
    }
});



/*
* ****************************************************************
8. Order Redirection - Don't show view cart page as separate
* ****************************************************************
*/

add_hook('ClientAreaPage', -100000000, function($vars) {
    if (isset($vars['inShoppingCart'])) {
        if (isset($_GET['a']) && $_GET['a'] == 'view') {
            $url = 'cart.php?a=checkout';
            header("Location: $url");
            die();
        }
    }
});

/*
 * ******************************************
9. Page Header Type
* ******************************************
*/

add_hook('ClientAreaPage', 2, function($vars) {
    $actionFile = $vars['templatefile'];
    $configFilePath = realpath(dirname(__FILE__)) . DS .'..'.DS. 'config' . DS . 'pageheader.php';
    if (file_exists($configFilePath)) { 
        $config = require_once $configFilePath;
        if (isset($config[$actionFile])) {
            if (count($config[$actionFile]) == 1) {
                return [
                    'RSheadersearch' => $config[$actionFile][0],
                    'RSheadercenter' => false,
                ];
            } else if (count($config[$actionFile]) == 2) {
                return [
                    'RSheadersearch' => $config[$actionFile][0],
                    'RSheadercenter' => $config[$actionFile][1],
                ];
            }
            else{
                return [
                    'RSheadersearch' => false,
                    'RSheadercenter' => false,
                ];
            }
        } else {
            return [
                'RSheadersearch' => false,
                'RSheadercenter' => false,
            ];
        }
    }
  
});

/*
 * ******************************************
10. Market Connect Banners
* ******************************************
*/


if(isset($_SESSION['uid']) && basename($_SERVER['SCRIPT_NAME']) !== 'logout.php' && basename($_SERVER['SCRIPT_NAME']) !== 'viewinvoice.php' && strpos($_SERVER['QUERY_STRING'], 'verificationId') === false){
    $rsServicesHooks = [
        'ClientAreaPage',
        'ClientAreaPageProductsServices',
        'ClientAreaHomepage',
        'ClientAreaPageProductDetails'
    ];
}
else{
    $rsServicesHooks = [
        'ClientAreaPageProductsServices',
        'ClientAreaHomepage',
        'ClientAreaPageProductDetails'
    ];
}

foreach ($rsServicesHooks as $rsServicesHook) {
    add_hook($rsServicesHook, -2, function($var = NULL) {
        $response = array();
       
        foreach (Service::active()->get() as $service) {
            $response[] = $service->factoryPromoter()->clientAreaHomeOutput(func_get_args());
        }
        return [
            'RSMarketConnectSidebars' => implode($response),
            'RSMarketConnectServices' => Service::active()->get()->toArray()
        ];
    });
}

/*
 * ******************************************
11. Client Area Home Panels
* ******************************************
*/
use WHMCS\View\Menu\Item;
add_hook('ClientAreaHomepagePanels', 1, function (Item $homePagePanels) {
    
    $recentTicketsPanel = $homePagePanels->getChild('Recent Support Tickets');
    $activeServicesPanel = $homePagePanels->getChild('Active Products/Services');
    $affiliatePanel = $homePagePanels->getChild('Affiliate Program');
    $recentNewsPanel = $homePagePanels->getChild('Recent News');
    
    if (!is_null($recentTicketsPanel)) {
        $recentTicketsPanel->setExtras(
            []
        );
    }
    if (!is_null($activeServicesPanel)) {
        $activeServicesPanel->setExtras(
            []
        );
    }
    if (!is_null($affiliatePanel)) {
        $affiliatePanel->setExtras(
            []
        );
    }
    if (!is_null($recentNewsPanel)) {
        $recentNewsPanel->setExtras(
            []
        );
    }
});

/*
 * ******************************************
12. Module Classes Helper
* ******************************************
*/


add_hook('ClientAreaPage', 2, function($vars) {
    if (isset($_GET['m'])){
        if ($_GET['m'] == "DomainOrdersExtended"){
            return [
                'pageModuleName' => 'searchdomains'
            ];
        }
        else if ($_GET['m'] == "DNSManager2"){
            return [
                'pageModuleName' => 'dnsmanager'
            ];
        }
        else{
            $moduleName = strtolower($_GET['m']);
            $moduleName = str_replace(' ', '', $moduleName);
            return [
                'pageModuleName' => $moduleName
            ];
        }
    }
});


/*
 * ******************************************
13. Site Layout Helper
* ******************************************
*/

add_hook('ClientAreaPage', 2, function($vars) {
    $actionFile = $vars['templatefile'];
    $configFilePath = realpath(dirname(__FILE__)) . DS .'..'.DS. 'config' . DS . 'layoutsite.php';
    if (file_exists($configFilePath)) { 
        $config = require_once $configFilePath;
        if (isset($config[$actionFile])) {
            if (count($config[$actionFile]) == 1) {
                return [
                    'isSiteLayout' => $config[$actionFile][0]
                ];
            }
            else{
                return [
                    'isSiteLayout' => false
                ];
            }
        } else {
            return [
                'isSiteLayout' => false
            ];
        }
    }
});