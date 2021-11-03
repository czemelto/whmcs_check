<?php

namespace WHMCS\Module\Registrar\Hureg;

use \WHMCS\User\Client\Contact;
use \WHMCS\User\Client;
use \WHMCS\CustomField;

class Person
{
    public function __construct(HuReg $hureg)
    {
        $this->hureg = $hureg;
    }

    private function _api()
    {
        return $this->hureg;
    }

    public function get_owner_details_by_person_irl_identity_and_email_address($identity_number, $email)
    {
        /*
         * <COMMAND TODO='altalanos_kereses'>
                <ID>1</ID>
                <ATTRIBUTES>
                    <OBJ>
                        <OPERATOR>=</OPERATOR>
                        <ATTRNAME>domain_name</ATTRNAME>
                        <VALUE>piros.hu</VALUE>
                    </OBJ>
                </ATTRIBUTES>
           </COMMAND>
         */

        $results = $this->_api()->sendRequest([
            'ID' => 1,
            'ATTRIBUTES' => [
                [
                    'OBJ' => [

                        'OPERATOR' => '=',
                        'ATTRNAME' => 'org_fca_ident',
                        'VALUE' => $identity_number,
                    ],
                ],
                [
                    'OBJ' => [

                        'OPERATOR' => '=',
                        'ATTRNAME' => 'org_fca_ident',
                        'VALUE' => $identity_number,
                    ],
                ]
            ],
        ], ['TODO' => 'altalanos_kereses']);
        return $results;
    }

    public function get_owner_details_by_owner_nic_id($identity_number)
    {
        /*
         * <COMMAND TODO='altalanos_kereses'>
                <ID>1</ID>
                <ATTRIBUTES>
                    <OBJ>
                        <OPERATOR>=</OPERATOR>
                        <ATTRNAME>domain_name</ATTRNAME>
                        <VALUE>piros.hu</VALUE>
                    </OBJ>
                </ATTRIBUTES>
           </COMMAND>
         */

        $results = $this->_api()->sendRequest([
            'ID' => 1,
            'ATTRIBUTES' => [
                [
                    'OBJ' => [

                        'OPERATOR' => '=',
                        'ATTRNAME' => 'org_hun_id',
                        'VALUE' => $identity_number,
                    ],
                ]
            ],
        ], ['TODO' => 'altalanos_kereses']);
        return $results;
    }
    public function get_admin_details_by_person_nic_id($identity_number)
    {
        /*
         * <COMMAND TODO='altalanos_kereses'>
                <ID>1</ID>
                <ATTRIBUTES>
                    <OBJ>
                        <OPERATOR>=</OPERATOR>
                        <ATTRNAME>domain_name</ATTRNAME>
                        <VALUE>piros.hu</VALUE>
                    </OBJ>
                </ATTRIBUTES>
           </COMMAND>
         */

        $results = $this->_api()->sendRequest([
            'ID' => 1,
            'ATTRIBUTES' => [
                [
                    'OBJ' => [

                        'OPERATOR' => '=',
                        'ATTRNAME' => 'person_hun_id',
                        'VALUE' => $identity_number,
                    ],
                ]
            ],
        ], ['TODO' => 'altalanos_kereses']);
        return $results;
    }

    public function insert_new_owner_by_contact_id_and_type($contact_id, $contact_type)
    {
        /*
         * <COMMAND TODO='tulajdonos_felvitel'>
            <ID>1</ID>
            <ATTRIBUTES>
            <ORG>
            <NAME_HUN>General Kft.</NAME_HUN>
            <NAME_ENG>General Ltd.</NAME_ENG>
            <IDENT>12345678-2-24</IDENT>
            <COUNTRY>HU</COUNTRY>
            <ZIPCODE>1234</ZIPCODE>
            <CITY>Budapest</CITY>
            <STREET>Utca u.</STREET>
            <STREET_NUMBER>3</STREET_NUMBER>
            <E_MAIL>pelda@proba.hu</E_MAIL>
            <PHONE>30-222222</PHONE>
            <CONFIRMPHONE>+36 30-222.2222</CONFIRMPHONE>
            <FAX_NO>1-222-1222</FAX_NO>
            </ORG>
            </ATTRIBUTES>
            </COMMAND>
         */
        $contact_data = Contact::find($contact_id);

        if ($contact_type == 1) {
            $req = [
                'ID' => 1, //individual person
                'ATTRIBUTES' => [
                    'ORG' =>
                        [
                            'PERS_NAME' => $contact_data->lastName . " " . $contact_data->firstName,
                            'IDENT' => $contact_data->taxId,
                            'COUNTRY' => $contact_data->country,
                            'ZIPCODE' => $contact_data->postcode,
                            'CITY' => $contact_data->city,
                            'STREET' => $contact_data->address1,
                            'STREET_NUMBER' => $contact_data->address2,
                            'E_MAIL' => $contact_data->email,
                            'PHONE' => $contact_data->phoneNumber,
                        ],
                ]
            ];
        } else if ($contact_type == 2) { //TODO: company
            $req = [
                'ID' => 1,
                'ATTRIBUTES' => [
                    'ORG' =>
                        [
                            'NAME_HUN' => $contact_data->companyName,
                            'NAME_ENG' => $contact_data->companyName,
                            'IDENT' => $contact_data->taxId,
                            'COUNTRY' => $contact_data->country,
                            'ZIPCODE' => $contact_data->postcode,
                            'CITY' => $contact_data->city,
                            'STREET' => $contact_data->address1,
                            'STREET_NUMBER' => $contact_data->address2,
                            'E_MAIL' => $contact_data->email,
                            'PHONE' => $contact_data->phoneNumber,
                        ],
                ]
            ];
        }
        $results = $this->_api()->sendRequest($req, ['TODO' => 'tulajdonos_felvitel']);

        return $results;
    }

    public function insert_new_owner_by_client_id_and_type($client_id, $contact_type)
    {
        /*
         * <COMMAND TODO='tulajdonos_felvitel'>
            <ID>1</ID>
            <ATTRIBUTES>
            <ORG>
            <NAME_HUN>General Kft.</NAME_HUN>
            <NAME_ENG>General Ltd.</NAME_ENG>
            <IDENT>12345678-2-24</IDENT>
            <COUNTRY>HU</COUNTRY>
            <ZIPCODE>1234</ZIPCODE>
            <CITY>Budapest</CITY>
            <STREET>Utca u.</STREET>
            <STREET_NUMBER>3</STREET_NUMBER>
            <E_MAIL>pelda@proba.hu</E_MAIL>
            <PHONE>30-222222</PHONE>
            <CONFIRMPHONE>+36 30-222.2222</CONFIRMPHONE>
            <FAX_NO>1-222-1222</FAX_NO>
            </ORG>
            </ATTRIBUTES>
            </COMMAND>
         */

        $command = 'GetClientsDetails';
        $postData = array(
            'clientid' => $client_id,
            'stats' => false,
        );

        $results = localAPI($command, $postData);



        if ($contact_type == 1) {
            $req = [
                'ID' => 1, //individual person
                'ATTRIBUTES' => [
                    'ORG' =>
                        [
                            'PERS_NAME' => $results["lastname"] . " " . $results["firstname"],
                            'IDENT' => $results["customfields1"], //todo: fix custom field
                            'COUNTRY' => $results["country"],
                            'ZIPCODE' => $results["postcode"],
                            'CITY' => $results["city"],
                            'STREET' => $results["address1"],
                            'STREET_NUMBER' => $results["address2"],
                            'E_MAIL' => $results["email"],
                            'PHONE' => "+".$results["phonecc"] . "." . $results["phonenumber"],
                        ],
                ]
            ];
        } else if ($contact_type == 2) { //TODO: company
            $req = [
                'ID' => 1,
                'ATTRIBUTES' => [
                    'ORG' =>
                        [
                            'NAME_HUN' => $results["companyname"],
                            'NAME_ENG' => $results["companyname"],
                            'IDENT' => $results["customfields2"],
                            'COUNTRY' => $results["country"],
                            'ZIPCODE' => $results["postcode"],
                            'CITY' => $results["city"],
                            'STREET' => $results["address1"],
                            'STREET_NUMBER' => $results["address2"],
                            'E_MAIL' => $results["email"],
                            'PHONE' => "+".$results["phonecc"] . "." . $results["phonenumber"],
                        ],
                ]
            ];
        }

        $results = $this->_api()->sendRequest($req, ['TODO' => 'tulajdonos_felvitel']);

        return $results;
    }

    public function insert_new_admin_by_contact_id($contact_id)
    {
        $contact_data = Contact::find($contact_id);
        //individual person
        $req = [
            'ID' => 1,
            'ATTRIBUTES' => [
                'PERSON' =>
                    [
                        'FIRST_NAME' => $contact_data->firstName,
                        'LAST_NAME' => $contact_data->lastName,
                        'COUNTRY' => $contact_data->country,
                        'ZIPCODE' => $contact_data->postcode,
                        'CITY' => $contact_data->city,
                        'STREET' => $contact_data->address1,
                        'STREET_NUMBER' => $contact_data->address2,
                        'E_MAIL' => $contact_data->email,
                        'PHONE' => $contact_data->phoneNumber,
                    ],
            ]
        ];

        if ($contact_data->companyName != "")
        {
            $req['ATTRIBUTES']['PERSON']['LAST_NAME'] = $contact_data->companyName;
            unset($req['ATTRIBUTES']['PERSON']['FIRST_NAME']);
        }

        $results = $this->_api()->sendRequest($req, ['TODO' => 'szemely_felvitel']);

        return $results;
    }
    public function insert_new_admin_by_client_id($client_id)
    {
        $client_data = Client::where("id", $client_id)->first();
        //individual person
        $req = [
            'ID' => 1,
            'ATTRIBUTES' => [
                'PERSON' =>
                    [
                        'FIRST_NAME' => $client_data->firstName,
                        'LAST_NAME' => $client_data->lastName,
                        'COUNTRY' => $client_data->country,
                        'ZIPCODE' => $client_data->postcode,
                        'CITY' => $client_data->city,
                        'STREET' => $client_data->address1,
                        'STREET_NUMBER' => $client_data->address2,
                        'E_MAIL' => $client_data->email,
                        'PHONE' => $client_data->phoneNumberFormatted,
                    ],
            ]
        ];
        if ($client_data->companyName != "")
        {
            $req['ATTRIBUTES']['PERSON']['LAST_NAME'] = $client_data->companyName;
            $req['ATTRIBUTES']['PERSON']['FIRST_NAME'] = "";
        }

        $results = $this->_api()->sendRequest($req, ['TODO' => 'szemely_felvitel']);

        return $results;
    }

    public function modify_owner_by_data($data)
    {

        $owner_nic_id = $data['owner_nic_id'];

        $results = $this->_api()->sendRequest([
            'ID' => 1234,
            'ATTRIBUTES' => [
                ['OBJ' =>
                    [
                        'OBJID' => $owner_nic_id,
                        'ATTRNAME' => "org_tel",
                        'VALUE' => $data['phone_number']
                    ],
                ],
                ['OBJ' =>
                    [
                        'OBJID' => $owner_nic_id,
                        'ATTRNAME' => "org_street",
                        'VALUE' => $data['address1']
                    ]
                ],
                ['OBJ' =>
                    [
                        'OBJID' => $owner_nic_id,
                        'ATTRNAME' => "org_street_number",
                        'VALUE' => $data['address2']
                    ]
                ],
                ['OBJ' =>
                    [
                        'OBJID' => $owner_nic_id,
                        'ATTRNAME' => "org_city",
                        'VALUE' => $data['city']
                    ]
                ],
                ['OBJ' =>
                    [
                        'OBJID' => $owner_nic_id,
                        'ATTRNAME' => "org_zipcode",
                        'VALUE' => $data['postcode']
                    ]
                ],
                ['OBJ' =>
                    [
                        'OBJID' => $owner_nic_id,
                        'ATTRNAME' => "org_country",
                        'VALUE' => $data['country']
                    ]
                ]
            ]

        ], ['TODO' => 'objektum_attributum_modositas']);
        return $results;

    }
    public function modify_admin_by_data($data)
    {

        $owner_nic_id = $data['admin_nic_id'];

        $results = $this->_api()->sendRequest([
            'ID' => 1234,
            'ATTRIBUTES' => [
                ['OBJ' =>
                    [
                        'OBJID' => $owner_nic_id,
                        'ATTRNAME' => "person_tel",
                        'VALUE' => $data['phone_number']
                    ],
                ],
                ['OBJ' =>
                    [
                        'OBJID' => $owner_nic_id,
                        'ATTRNAME' => "person_street",
                        'VALUE' => $data['address1']
                    ]
                ],
                ['OBJ' =>
                    [
                        'OBJID' => $owner_nic_id,
                        'ATTRNAME' => "person_street_number",
                        'VALUE' => $data['address2']
                    ]
                ],
                ['OBJ' =>
                    [
                        'OBJID' => $owner_nic_id,
                        'ATTRNAME' => "person_city",
                        'VALUE' => $data['city']
                    ]
                ],
                ['OBJ' =>
                    [
                        'OBJID' => $owner_nic_id,
                        'ATTRNAME' => "person_zipcode",
                        'VALUE' => $data['postcode']
                    ]
                ],
                ['OBJ' =>
                    [
                        'OBJID' => $owner_nic_id,
                        'ATTRNAME' => "person_country",
                        'VALUE' => $data['country']
                    ]
                ]
            ]

        ], ['TODO' => 'objektum_attributum_modositas']);
        return $results;

    }


}