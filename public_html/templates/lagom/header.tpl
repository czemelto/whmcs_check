{if file_exists("templates/$template/overwrites/header.tpl")}
    {include file="{$template}/overwrites/header.tpl"}  
{else}
    <!DOCTYPE html>
    <html lang="en" {if isset($RSThemes['styles']['files'])}{if ($language == 'arabic' || $language == 'hebrew' || $language == 'farsi') && (file_exists("templates/{$template}/core/styles/{$RSThemes['styles']['name']}/assets/css/theme-rtl.css") || file_exists("templates/{$template}/core/styles/{$RSThemes['styles']['name']}/assets/css/theme-rtl.min.css"))}dir="rtl"{/if}{/if}>
    <head>
        <meta charset="{$charset}" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
        <title>{if $kbarticle.title}{$kbarticle.title} - {/if}{$pagetitle} - {$companyname}</title>
        {include file="$template/includes/head.tpl"}
        {$headoutput}
    </head>
    <body class="lagom {$bodyClasses} {if !$loggedin} lagom-not-portal{/if}{if $RSThemes.layouts.vars.bodyClass} {$RSThemes.layouts.vars.bodyClass}{/if}{if !$templatefile|strstr:"/"} page-{$templatefile}{/if}{if $pageModuleName} page-{$pageModuleName}{/if}{if $module} page-{$module|lower|replace:" ":""}{/if}{if $mgCaResult['vars']['mainName']} page-{$mgCaResult['vars']['mainName']|lower|replace:" ":""}{/if}{if $loggedin} page-user-logged{/if}{if $RSThemes['pages'][$templatefile]['optionvars']['isFullPage'] == true || $templatefile=="oauth/layout"} page-type-full{/if}" data-phone-cc-input="{$phoneNumberInputStyle}">
        {$headeroutput}
        {if isset($RSThemes.layouts)}
            {include file=$RSThemes['layouts']['mediumPath']}
        {else}
            {include file="templates/{$template}/core/layouts/default/default.tpl"}
        {/if}
{/if}