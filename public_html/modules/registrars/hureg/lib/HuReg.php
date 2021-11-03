<?php
namespace WHMCS\Module\Registrar\HuReg;

//use WHMCS\Module\Registrar\HuReg\HuRegRequestManager;
//use WHMCS\Module\Registrar\HuReg\Domain;
use WHMCS\Module\Registrar\HuReg\Logger;


class HuReg extends HuRegRequestManager
{
    public function domain(): Domain
    {
        return new Domain($this);
    }
    public function person(): Person
    {
        return new Person($this);
    }

}