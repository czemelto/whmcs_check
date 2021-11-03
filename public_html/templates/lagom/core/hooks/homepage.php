<?php

use WHMCS\Database\Capsule;
use \RSThemes\Extensions\PromoBannersExtension as Banner;
use \WHMCS\Product\Group;
use \Punic\Currency;
use \WHMCS\Domains\Domain;
use WHMCS\Session;
use WHMCS\View\Formatter\Price as Price;

class GetHomeVars
{
    private $table = 'tbldomainpricing';
    private $lang = 'english';
    private $productGroupCache = [];
    private $tldPricingCache = [];
    private $marketConnectCount;
    private $promotionExtensionStatus;
    private $promotionBanner;
    private $currentCurrency;

    public function __construct($vars)
    {
        $this->lang = $vars['activeLocale']['language'];
    }

    public function getMarketConnectCount()
    {
        if (isset($this->marketConnectCount)) {
            return $this->marketConnectCount;
        } else {
            $this->marketConnectCount = Capsule::table('tblmarketconnect_services')->where('settings', 'like', '%client-home":true%')->where('status', 1)->count();
            return $this->marketConnectCount;
        }
    }

    public function getMarketConnect()
    {
        $pdo = Capsule::connection()->getPdo();
        $pdo->beginTransaction();
        try {
            $statement = $pdo->prepare(
                'SELECT `tblmarketconnect_services`.`id`, 
                    `tblproductgroups`.`id` as `gid`, 
                    `tblproducts`.`id` as `pid`,
                    `tblmarketconnect_services`.`name`, 
                    `tblmarketconnect_services`.`settings`,
                    `tblproductgroups`.`slug`, 
                    `tblproductgroups`.`tagline`, 
                    `tblproductgroups`.`headline`, 
                    `tblproductgroups`.`name` as `tabname`
                FROM `tblproductgroups` 
                INNER JOIN `tblproducts` ON `tblproducts`.`gid` = `tblproductgroups`.`id` 
                INNER JOIN `tblmarketconnect_services` ON `tblmarketconnect_services`.`product_ids`
                COLLATE utf8_bin LIKE CONCAT(\'%\',`tblproducts`.`configoption1`, \'%\') 
                WHERE `tblproductgroups`.`tagline` != \'\' 
                AND `tblmarketconnect_services`.`status` = 1 
                AND `tblproducts`.`configoption1` != \'\' 
                GROUP BY `tblmarketconnect_services`.`id`'
            );
            $statement->execute();
        } catch (PDOException $e) {
            //echo $e->getMessage();
        }
        if (!is_null($statement)) {
            $list = $statement->fetchAll();
            $pdo->commit();
            $items = [];
            foreach ($list as $item) {
                //translations for tabname, headline, tagline
                $tabNameResult = Capsule::table('tbldynamic_translations')
                    ->select('tbldynamic_translations.translation')
                    ->where('related_id', $item['gid'])
                    ->where('language', $this->lang)
                    ->where('related_type', 'product_group.{id}.name')
                    ->first();
                if ($tabNameResult !== null) {
                    $item['tabname'] = $tabNameResult->translation;
                }
                $headlineResult = Capsule::table('tbldynamic_translations')
                    ->select('tbldynamic_translations.translation')
                    ->where('related_id', $item['gid'])
                    ->where('language', $this->lang)
                    ->where('related_type', 'product_group.{id}.headline')
                    ->first();
                if ($headlineResult !== null) {
                    $item['headline'] = $headlineResult->translation;
                }
                $taglineResult = Capsule::table('tbldynamic_translations')
                    ->select('tbldynamic_translations.translation')
                    ->where('related_id', $item['gid'])
                    ->where('language', $this->lang)
                    ->where('related_type', 'product_group.{id}.tagline')
                    ->first();
                if ($taglineResult !== null) {
                    $item['tagline'] = $taglineResult->translation;
                }
                $items[] = $item;
            }
            return $items;
        }
        return [];
    }

    public function getCurrentCurrency()
    {
        if (isset($this->currentCurrency)) {
            return $this->currentCurrency;
        } else {
            $currencyId = $_SESSION['currency'] ?? getCurrency($_SESSION['uid'], $_SESSION['currency'])['id'] ?? 1;
            return WHMCS\Database\Capsule::table("tblcurrencies")->where('id', $currencyId)->first();
        }
    }

    public function productGroup($groupId = 1)
    {
        if (isset($this->productGroupCache[$groupId])) {
            return $this->productGroupCache[$groupId];
        }
        $products = Group::find($groupId)->products;
        $currencyId = $_SESSION['currency'] ?: 1;
        $cheapest = NULL;
        $cheapestPrice = PHP_INT_MAX;
        $cheapestBilling = "";


        foreach ($products as $product) {
            if ($product->hidden == 0) {
                $prices = $product->pricing(getCurrency($_SESSION['uid'], $_SESSION['currency']))->allAvailableCycles();

                foreach ($prices as $price) {
                    if ($price->isFree()) {
                        $cheapest = $product;
                        $cheapestPrice = 0;
                        $cheapestBilling = $price->cycle();
                        break 2;
                    } else {
                        if ($price->price()->toNumeric() < $cheapestPrice) {
                            if ($price->cycle() == 'annually') {
                                $cycle = 12;
                            } elseif ($price->cycle() == 'semiannually') {
                                $cycle = 6;
                            } elseif ($price->cycle() == 'quarterly') {
                                $cycle = 3;
                            } elseif ($price->cycle() == 'biennially') {
                                $cycle = 24;
                            } elseif ($price->cycle() == 'triennially') {
                                $cycle = 36;
                            }

                            if (isset($cycle)) {
                                $cheapestPrice = $price->price()->toNumeric() / $cycle;
                            } else {
                                $cheapestPrice = $price->price()->toNumeric();
                            }
                            $cheapest = $product;
                            if (isset($cycle)) {
                                $cheapestBilling = 'monthly';
                            } else {
                                $cheapestBilling = $price->cycle();
                            }
                        }
                    }
                }
            }

        }

        $formattedPrice = round($cheapestPrice, 2);
        $formattedPrice = new Price($formattedPrice, getCurrency($_SESSION['uid'], $_SESSION['currency']));

        $this->productGroupCache[$groupId] = (object)["product" => $cheapest, "price" => $formattedPrice, "billing" => $cheapestBilling];
        return $this->productGroupCache[$groupId];
    }

    public function getSpotlight()
    {
        $domainsTLD = [];
        $spotlightTLD = explode(',', \WHMCS\Config\Setting::getValue("SpotlightTLDs"));
        foreach ($spotlightTLD as $k => $item) {
            if ($this->spotlightPrice($item)) {
                $domainsTLD[$k]['ext'] = $item;
                $domainsTLD[$k]['price'] = $this->spotlightPrice($item);
            }
        }
        return $domainsTLD;

    }

    public function spotlightPrice($ext = null)
    {
        if (isset($this->tldPricingCache[$ext])) {
            return $this->tldPricingCache[$ext];
        }

        $extensionId = Capsule::table('tbldomainpricing')->select('id')->where('extension', $ext)->first()->id;
        $price = Capsule::table('tblpricing')
            ->where('relid', $extensionId)
            ->where('type', 'domainregister')
            ->where('currency', $_SESSION['currency'] ?? getCurrency($_SESSION['uid'], $_SESSION['currency'])['id'] ?? 1)
            ->first();

        $price = (($price->msetupfee > 0) ? $price->msetupfee : $price->qsetupfee);
        $formatedPrice = new Price($price, getCurrency($_SESSION['uid'], $_SESSION['currency']));

        if ($ext !== null && intval($price) >= 0) {
            $this->tldPricingCache[$ext] = $formatedPrice;
            return $formatedPrice;
        }
    }

    public function getPromotionExtensionStatus()
    {
        if (Capsule::schema()->hasTable("rsextension_promobanners_slides") && Capsule::schema()->hasTable("rsextension_translation_content") && Capsule::table('tblconfiguration')->where('setting', 'lagom_promobanners_exstatus')->select('value')->first()->value == 1) {
            $this->promotionExtensionStatus = true;
        } else {
            $this->promotionExtensionStatus = false;
        }
        return $this->promotionExtensionStatus;
    }

    public function getPromotionBanner()
    {
        if (isset($this->promotionBanner)) {
            return $this->promotionBanner;
        }

        if ($this->getPromotionExtensionStatus()) {
            $this->promotionBanner = Banner::getHomepageSlides();
        } else {
            $this->promotionBanner = $this->getMarketConnect();
        }

        return $this->promotionBanner;
    }
}

add_hook('ClientAreaPage', 22, function ($v) {
    if (Capsule::schema()->hasTable("rstheme_themes")) {
        $pageConfig = Capsule::table('rstheme_themes')->select('pages_configuration')->whereName('lagom')->first()->pages_configuration;
        if ($v['templatefile'] == 'homepage') {
            return [
                'homepage' => new GetHomeVars($v)
            ];
        }
    }
});
