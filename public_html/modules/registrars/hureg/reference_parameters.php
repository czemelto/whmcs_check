<?php
$params = array();

// user defined configuration values
$userIdentifier = $params['API Username'];
$apiKey = $params['API Key'];
$testMode = $params['Test Mode'];
$accountMode = $params['Account Mode'];
$emailPreference = $params['Email Preference'];
$additionalInfo = $params['Additional Information'];

// registration parameters
$sld = $params['sld'];
$tld = $params['tld'];
$registrationPeriod = $params['regperiod'];

/**
 * Nameservers.
 *
 * If purchased with web hosting, values will be taken from the
 * assigned web hosting server. Otherwise uses the values specified
 * during the order process.
 */
$nameserver1 = $params['ns1'];
$nameserver2 = $params['ns2'];
$nameserver3 = $params['ns3'];
$nameserver4 = $params['ns4'];
$nameserver5 = $params['ns5'];

// registrant information
$firstName = $params["firstname"];
$lastName = $params["lastname"];
$fullName = $params["fullname"]; // First name and last name combined
$companyName = $params["companyname"];
$email = $params["email"];
$address1 = $params["address1"];
$address2 = $params["address2"];
$city = $params["city"];
$state = $params["state"]; // eg. TX
$stateFullName = $params["fullstate"]; // eg. Texas
$postcode = $params["postcode"]; // Postcode/Zip code
$countryCode = $params["countrycode"]; // eg. GB
$countryName = $params["countryname"]; // eg. United Kingdom
$phoneNumber = $params["phonenumber"]; // Phone number as the user provided it
$phoneCountryCode = $params["phonecc"]; // Country code determined based on country
$phoneNumberFormatted = $params["fullphonenumber"]; // Format: +CC.xxxxxxxxxxxx

/**
 * Admin contact information.
 *
 * Defaults to the same as the client information. Can be configured
 * to use the web hosts details if the `Use Clients Details` option
 * is disabled in Setup > General Settings > Domains.
 */
$adminFirstName = $params["adminfirstname"];
$adminLastName = $params["adminlastname"];
$adminCompanyName = $params["admincompanyname"];
$adminEmail = $params["adminemail"];
$adminAddress1 = $params["adminaddress1"];
$adminAddress2 = $params["adminaddress2"];
$adminCity = $params["admincity"];
$adminState = $params["adminstate"]; // eg. TX
$adminStateFull = $params["adminfullstate"]; // eg. Texas
$adminPostcode = $params["adminpostcode"]; // Postcode/Zip code
$adminCountry = $params["admincountry"]; // eg. GB
$adminPhoneNumber = $params["adminphonenumber"]; // Phone number as the user provided it
$adminPhoneNumberFormatted = $params["adminfullphonenumber"]; // Format: +CC.xxxxxxxxxxxx

// domain addon purchase status
$enableDnsManagement = (bool) $params['dnsmanagement'];
$enableEmailForwarding = (bool) $params['emailforwarding'];
$enableIdProtection = (bool) $params['idprotection'];

/**
 * Premium domain parameters.
 *
 * Premium domains enabled informs you if the admin user has enabled
 * the selling of premium domain names. If this domain is a premium name,
 * `premiumCost` will contain the cost price retrieved at the time of
 * the order being placed. The premium order should only be processed
 * if the cost price now matches the previously fetched amount.
 */
$premiumDomainsEnabled = (bool) $params['premiumEnabled'];
$premiumDomainsCost = $params['premiumCost'];

// Build post data
$postfields = array(
    'username' => $userIdentifier,
    'password' => $apiKey,
    'testmode' => $testMode,
    'domain' => $sld . '.' . $tld,
    'years' => $registrationPeriod,
    'nameservers' => array(
        'ns1' => $nameserver1,
        'ns2' => $nameserver2,
        'ns3' => $nameserver3,
        'ns4' => $nameserver4,
        'ns5' => $nameserver5,
    ),
    'contacts' => array(
        'registrant' => array(
            'firstname' => $firstName,
            'lastname' => $lastName,
            'companyname' => $companyName,
            'email' => $email,
            'address1' => $address1,
            'address2' => $address2,
            'city' => $city,
            'state' => $state,
            'zipcode' => $postcode,
            'country' => $countryCode,
            'phonenumber' => $phoneNumberFormatted,
        ),
        'tech' => array(
            'firstname' => $adminFirstName,
            'lastname' => $adminLastName,
            'companyname' => $adminCompanyName,
            'email' => $adminEmail,
            'address1' => $adminAddress1,
            'address2' => $adminAddress2,
            'city' => $adminCity,
            'state' => $adminState,
            'zipcode' => $adminPostcode,
            'country' => $adminCountry,
            'phonenumber' => $adminPhoneNumberFormatted,
        ),
    ),
    'dnsmanagement' => $enableDnsManagement,
    'emailforwarding' => $enableEmailForwarding,
    'idprotection' => $enableIdProtection,
);

if ($premiumDomainsEnabled && $premiumDomainsCost) {
    $postfields['accepted_premium_cost'] = $premiumDomainsCost;
}
