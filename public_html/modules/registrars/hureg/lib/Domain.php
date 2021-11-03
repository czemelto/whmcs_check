<?php

namespace WHMCS\Module\Registrar\Hureg;

class Domain
{
    public function __construct(HuReg $hureg)
    {
        $this->hureg = $hureg;
    }

    private function _api()
    {
        return $this->hureg;
    }

    public function get_details_by_domain_name($domain_name)
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
                'OBJ' => [
                    'OPERATOR' => '=',
                    'ATTRNAME' => 'domain_name',
                    'VALUE' => $domain_name
                ]
            ]
        ], ['TODO' => 'altalanos_kereses']);
        return $results;
    }

    public function new_domain($domain_name, $params, $owner_id, $admin_id)
    {

        /*
         * <ID>1</ID>
            <ATTRIBUTES>
            <DOMAIN DSTATE='BEJEGYZES' RIGHT='NON_PRI' OWNER='nic-hdl'
            ADMIN_C='nic-hdl' TECH_C='nic-hdl' ZONE_C='nic-hdl'
            ELECTRONIC='yes'>
            <DNAME>proba.hu</DNAME>
            <DNS>ns1.domain.hu</DNS>
            <ORG>
            <IDENT>1000542799</IDENT>
            </ORG>
            <PERSON ROLE='admin-c'>
            <IDENT>2000656212</IDENT>
            </PERSON>
            <PERSON ROLE='tech-c'>
            <IDENT>2000682469</IDENT>
            </PERSON>
            <PERSON ROLE='zone-c'>
            <IDENT>2001117870</IDENT>
            </PERSON>
            </DOMAIN>
            </ATTRIBUTES>
         */
        $results = $this->_api()->sendRequest([
            'ID' => 1,
            'ATTRIBUTES' => [
                'DOMAIN' => [
                    '_attributes' => ['RIGHT' => "NON_PRI",
                        "OWNER" => "nic-hdl",
                        "ADMIN_C" => "nic-hdl",
                        "TECH_C" => "nic-hdl",
                        "ZONE_C" => "nic-hdl",
                        "ELECTRONIC" => "yes",
                    ],
                    'DNAME' => $domain_name,
                    'DNS' => $params['ns1'],
                    'ORG' =>
                        [
                            'IDENT' => $owner_id
                        ],
                    'PERSON001' => [
                        '_attributes' => ['ROLE' => "admin-c"],
                        'IDENT' => $admin_id
                    ],
                    'PERSON002' => [
                        '_attributes' => ['ROLE' => "tech-c"],
                        'IDENT' => $admin_id
                    ],
                    'PERSON003' => [
                        '_attributes' => ['ROLE' => "zone-c"],
                        'IDENT' => $admin_id
                    ],
                ]
            ]
        ], ['TODO' => 'uj_domain']);
        return $results;

    }

    public function transfer_domain($params, $domain_id, $owner_id, $admin_id)
    {
        $req = [
            'ID' => 1234,
            'ATTRIBUTES' => [

                [
                    'OBJ' => [
                        'OBJID' => $domain_id,
                        'ATTRNAME' => "domain_pri_ns",
                        'VALUE' => $params['ns1']
                    ]
                ],
                [
                    'OBJ' => [
                        'OBJID' => $domain_id,
                        'ATTRNAME' => "domain_owner_org_id",
                        'VALUE' => $owner_id
                    ]
                ],
                [
                    'OBJ' => [
                        'OBJID' => $domain_id,
                        'ATTRNAME' => "domain_admin_c_id",
                        'VALUE' => $admin_id
                    ]
                ],
                ['OBJ' => [
                    'OBJID' => $domain_id,
                    'ATTRNAME' => "domain_mnt_org_id",
                    'VALUE' => "1006101551",//digitalegg owner_org_id
                ]
                ]
            ]
        ];
        $results = $this->_api()->sendRequest($req, ['TODO' => 'objektum_attributum_modositas']);
        return $results;

    }

    public function change_domain_status($nic_id, $status)
    {
        /*
         *
         *<COMMAND TODO="domain">
            <ID>1</ID>
            <ATTRIBUTES>
            <OBJ>
            <OBJID>0999999999</OBJID>
            <VALUE>29</VALUE>
            </OBJ>
            </ATTRIBUTES>
            </COMMAND>
         *
         *
         */
        $results = $this->_api()->sendRequest([
            'ID' => 1,
            'ATTRIBUTES' => [
                'OBJ' => [
                    "OBJID" => $nic_id,
                    "VALUE" => $status
                ]
            ]
        ], ['TODO' => 'domain']);
        return $results;
    }


    public function request_confirmation($owner_id, $domain_nic_id)
    {
        /*
            <COMMAND TODO='nyilatkozat_keres'>
            <ID>1234</ID>
            <ATTRIBUTES>
            <DECL_REQ OWNER=”1234567890”>
            <OBJ><VALUE>0000000001</VALUE></OBJ>
            <OBJ><VALUE>0000000002</VALUE></OBJ>
            ...
            <OBJ><VALUE>000000000n</VALUE></OBJ>
            </DECL_REQ>
            </ATTRIBUTES>
            </COMMAND>
        */
        $results = $this->_api()->sendRequest([
            'ID' => 1234,
            'ATTRIBUTES' => [
                'DECL_REQ' => [
                    '_attributes' => ["OWNER" => $owner_id],
                    'OBJ' => [
                        'VALUE' => $domain_nic_id
                    ]
                ]
            ]
        ], ['TODO' => 'nyilatkozat_keres']);
        return $results;
    }

    public function send_confirmation($confirmation_id, $client_ip, $captcha, $timestamp, $hash)
    {
        /*
            <COMMAND TODO='nyilatkozat_bekuldes'>
            <ID>123466</ID>
            <ATTRIBUTES>
            <DECL_REPLY ID=”000011001100” IP='2a00:e6a0:0001::2'
            CAPTCHA='titkosszoveg' TIMESTAMP='2015-01-09 14:22:20'
            HASH='a1b2c3d4e4f6a1b2c3d4e4f6a1b2c3d4' COMMENT='regi ismeros'>
            </DECL_REPLY>
            </ATTRIBUTES>
            </COMMAND>
        */
        $results = $this->_api()->sendRequest([
            'ID' => 1234,
            'ATTRIBUTES' => [
                'DECL_REPLY' => [
                    '_attributes' => [
                        "ID" => $confirmation_id,
                        "IP" => $client_ip,
                        "CAPTCHA" => $captcha,
                        "TIMESTAMP" => $timestamp,
                        "HASH" => $hash
                    ]
                ]
            ]
        ], ['TODO' => 'nyilatkozat_bekuldes']);
        return $results;
    }

    public function modify_nameservers_by_domain_id($domain_id, $ns1, $ns2)
    {
        if ($ns1) {
            $attrname = 'domain_pri_ns';
            $value = $ns1;
        } else if ($ns2) {
            $attrname = 'domain_sec_ns';
            $value = $ns2;
        }

        $results = $this->_api()->sendRequest([
            'ID' => 1234,
            'ATTRIBUTES' => [

                'OBJ' => [
                    'OBJID' => $domain_id,
                    'ATTRNAME' => $attrname,
                    'VALUE' => $value
                ]

            ]
        ], ['TODO' => 'objektum_attributum_modositas']);
        return $results;


    }

    public function get_incoming_domain_transfers()
    {
        $results = $this->_api()->sendRequest([
            'ID' => 10000
        ], ['TODO' => 'atregisztralt_domainek']);
        return $results;
    }

    public function test_set_domain_status_to_bejegyezheto($domain_id)
    {
        /*
            <COMMAND TODO='teszt_modositaskeres_delegalt_allapot'>
            <ID>1</ID>
            <ATTRIBUTES>
            <STATUSMOD>
            <DOMAIN_ID>0992397813</DOMAIN_ID>
            </STATUSMOD>
            </ATTRIBUTES>
            </COMMAND>
        */
        /*$results = $this->_api()->sendRequest([
            'ID' => 1234,
            'ATTRIBUTES' => [
                'STATUSMOD' => [
                    'DOMAIN_ID' => $domain_id,
                ]
            ]
        ], ['TODO' => 'teszt_elbiralas_bejegzezheto_allapot']);
        */
        $results = $this->_api()->sendRequest([
            'ID' => 1234,
            'ATTRIBUTES' => [
                'STATUSMOD' => [
                    'DOMAIN_ID' => $domain_id,
                ]
            ]
        ], ['TODO' => 'teszt_modositaskeres_delegalt_allapot']);

        return $results;

    }
    public function test_set_domain_status_to_delegalt($domain_id)
    {
        /*
            <COMMAND TODO='teszt_modositaskeres_delegalt_allapot'>
            <ID>1</ID>
            <ATTRIBUTES>
            <STATUSMOD>
            <DOMAIN_ID>0992397813</DOMAIN_ID>
            </STATUSMOD>
            </ATTRIBUTES>
            </COMMAND>
        */
        /*$results = $this->_api()->sendRequest([
            'ID' => 1234,
            'ATTRIBUTES' => [
                'STATUSMOD' => [
                    'DOMAIN_ID' => $domain_id,
                ]
            ]
        ], ['TODO' => 'teszt_elbiralas_bejegzezheto_allapot']);
        */
        $results = $this->_api()->sendRequest([
            'ID' => 1234,
            'ATTRIBUTES' => [
                'STATUSMOD' => [
                    'DOMAIN_ID' => $domain_id,
                ]
            ]
        ], ['TODO' => 'teszt_elbiralas_bejegzezheto_allapot']);

        return $results;

    }

    public function test_create_transferrable_domain($domain_name)
    {
        /*
         * <COMMAND TODO='teszt_domain_letrehozas_atkereshez'>
            <ID>1</ID>
            <ATTRIBUTES>
            <OBJ>
            <ATTRNAME>domain_name</ATTRNAME>
            <VALUE>példa.hu</VALUE>
            </OBJ >
            </ATTRIBUTES>
            </COMMAND>
         *
         */
        $results = $this->_api()->sendRequest([
            'ID' => 1234,
            'ATTRIBUTES' => [
                'OBJ' => [
                    'ATTRNAME' => 'domain_name',
                    'VALUE' => $domain_name

                ]
            ]
        ], ['TODO' => 'teszt_domain_letrehozas_atkereshez']);
        return $results;

    }


    public function new_domain_with_existing_customer($domain_name, $customer_details)
    {
    }


}