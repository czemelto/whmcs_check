<?php

namespace WHMCS\Module\Registrar\Hureg;

use gnupg;
use GuzzleHttp\Client;
use Spatie\ArrayToXml\ArrayToXml;
use Respect\Validation\Validator as validate;

class HuRegRequestManager
{
    public function __construct(string $api_username, string $api_password
        , string $public_key_fingerprint, string $api_endpoint, string $api_pgp_password)
    {

        $this->api_username = $api_username;
        $this->api_password = $api_password;
        $this->api_pgp_password = $api_pgp_password;
        $this->public_key_fingerprint = $public_key_fingerprint;


        //TODO: refactor out to config and reference file
        $this->xml_route_name = "DAPI";
        $this->api_endpoint = $api_endpoint;

    }

    public function xml_to_array(string $xml, bool $toArray = true)
    {
        $obj = simplexml_load_string($xml, null, LIBXML_NOCDATA);
        return json_decode(json_encode($obj), $toArray);
    }

    public function getSignatureByCommandBlock($command_block)
    {

        // 1. convert command block to string
        $atox = new ArrayToXml($command_block);
        $command_block_string = $atox->toXml();

        $command_block_string = str_replace("<?xml version=\"1.0\"?>\n", "", $command_block_string);
        $command_block_string = str_replace("<root>", "", $command_block_string);
        $command_block_string = str_replace("</root>", "", $command_block_string);

        $command_block_string = $this->personFix($command_block_string);


        if (!preg_match("%^<COMMAND\s+TODO\s*?=.*?</COMMAND>\n$%ms", $command_block_string)) {
            return "The file must contain only the command\n";
        }
        $gpg = new gnupg();

        //$res = gnupg_init();

        $gpg->seterrormode(gnupg::ERROR_EXCEPTION); // raise a PHP-Warning in case of an error
        //gnupg_seterrormode($res, gnupg::ERROR_EXCEPTION);

        $gpg->addsignkey($this->public_key_fingerprint);
        //gnupg_addsignkey($res,$this->public_key_fingerprint);

        $gpg->setsignmode(gnupg::SIG_MODE_DETACH);
        //gnupg_setsignmode($res,gnupg::SIG_MODE_DETACH);

        $command_block_signature = $gpg->sign($command_block_string);
        //$command_block_signature = gnupg_sign($res,$command_block_string);

        return $command_block_signature;
    }

    public function buildRequestData(array $command_inside_object, array $command_attribute = []): string
    {
        /*
         * Concatenate:
         *  - Authentication strings <DAPI><USERNAME>user</USERNAME><PASSWORD>pwd</PASSWORD>
         *  - Request content <COMMAND><OTHER_BLOCKS></OTHER_BLOCKS></COMMAND>
         *  - Signature and ending <SIGNATURE>asd</SIGNATURE></DAPI>
         */

        $command_block = ['COMMAND' => [
            '_attributes' => $command_attribute,
        ]];
        $command_block = ['COMMAND' => array_merge($command_block['COMMAND'], $command_inside_object)];


        $request_array = [
            'USERNAME' => $this->api_username,
            'PASSWORD' => $this->api_password,
        ];
        $request_array = array_merge($request_array, $command_block);

        $request_array['SIGNATURE'] = $this->getSignatureByCommandBlock($command_block);

        $arrayToXml = new ArrayToXml($request_array, $this->xml_route_name);

        $request_data = str_replace("<?xml version=\"1.0\"?>", "", $arrayToXml->toXml());
        $request_data = str_replace("\t", "", $request_data);
        $request_data = str_replace('</COMMAND><SIGNATURE>', "</COMMAND>\n<SIGNATURE>", $request_data);
        return $request_data;
    }

    public function personFix($request_data)
    {
        //TODO: FIX in code
        // explanation, use: <PERSON> ---->   [ ['PERSON' => [...] ],['PERSON', [...] ] ]
        $request_data = str_replace("<PERSON001", "<PERSON", $request_data);
        $request_data = str_replace("<PERSON002", "<PERSON", $request_data);
        $request_data = str_replace("<PERSON003", "<PERSON", $request_data);

        $request_data = str_replace("</PERSON001>", "</PERSON>", $request_data);
        $request_data = str_replace("</PERSON002>", "</PERSON>", $request_data);
        $request_data = str_replace("</PERSON003>", "</PERSON>", $request_data);

        return $request_data;
    }

    public function sendRequest(array $command_object, array $command_attribute)
    {


        // ( ezt a command mezőt kell megadni a HTTP POST paraméternek,
        // ez nem ugyanaz mint a <COMMAND> !!
        $request_data = $this->buildRequestData($command_object, $command_attribute);
        $request_data = $this->personFix($request_data);
        /*
                echo "<pre>";
                echo htmlentities($request_data);
                echo "<br>";
        */

        //return ["status" => "success","success" => ["data" => json_encode($request_data)]];

        //return ["data" => $request_data];


        //echo "<pre>";
        //echo(htmlentities($request_data));
        //exit;

        //exit;


        // TODO: curl or guzzleHTTP
        try {
            $client = new Client();

            $response = $client->request('POST', $this->api_endpoint, array(
                    'form_params' => array(
                        'command' => $request_data . "\n"
                    )
                )
            );
            $response_body = $response->getBody()->getContents();
            $response_body_array = $this->xml_to_array($response_body);

            if ($response->getStatusCode() != 200 ||
                count($response_body_array["COMMAND"]["ATTRIBUTES"]) > 1
                && array_key_exists("ERRORS", $response_body_array["COMMAND"]["ATTRIBUTES"][1])
            ) {

                $errors = [];
                $error_response = $response_body_array["COMMAND"]["ATTRIBUTES"][1];

                if (count($error_response["ERRORS"]) > 1) {
                    foreach ($error_response["ERRORS"]["ERROR"] as $error_entry) {
                        $errors[] = [
                            "code" => $error_entry["ECODE"],
                            "message" => $error_entry["ETEXT"],
                            "data" => $error_entry];
                    }
                }
                else {
                    $error_entry = $error_response["ERRORS"];
                    $errors = [
                        "code" => $error_entry["ERROR"]["ECODE"],
                        "message" => $error_entry["ERROR"]["ETEXT"],
                        "data" => $error_entry];
                }


                $error_array = [
                    "status" => "error",
                    "error" => $errors

                ];

                logActivity("Error encountered during hureg request: " . json_encode($error_array));

                return $error_array;
            }

        } catch (\GuzzleHttp\Exception\BadResponseException $e) {
            $error_array = [
                "status" => "error",
                "error" => ["code" => -1, "message" => "Endpoint error", "data" => $response_body_array]
            ];
            logActivity("Error encountered during hureg request - (bad response): " . json_encode($error_array));
            return $error_array;
        }

        return [
            "status" => "success",
            "success" => ["data" => $response_body_array]
        ];
    }

}