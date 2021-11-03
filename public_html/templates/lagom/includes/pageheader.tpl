{if file_exists("templates/$template/includes/overwrites/pageheader.tpl")}
    {include file="{$template}/includes/overwrites/pageheader.tpl"}  
{else}      
    {if $RSheadercenter}
        <div class="header-lined text-center m-b-24">
            <h1>
            {if $desc}
                <span class="text-lighter text-small">{$desc}</span>
                <br />
            {/if}
                {$title}
            </h1>
            {if $showbreadcrumb}{include file="$template/includes/breadcrumb.tpl"}{/if}
        </div>
    {else}
        {if $RSheadersearch}
            <div class="main-header-top">
                <h1 class="m-b-0">{$title}</h1>
                <div class="search-group">
                    <input type="text" id="table-search" class="form-control" placeholder="{$LANG.tableentersearchterm}">
                </div>
            </div>    
        {elseif $RSheaderRenewalSearch}
            <div class="main-header-top">
                <h1>{$title}</h1>
                <div class="search-group">
                    <input type="text" id="domainRenewalFilter" class="form-control" placeholder="{$LANG.tableentersearchterm}">
                </div>
            </div>
        {elseif $templatefile == "products"}
            <h1>
                {$title}
            </h1>
            {if $productGroup.tagline}
                <p>{$productGroup.tagline}</p>
            {/if}
        {else}
            <h1>
                {$title}
            </h1>
        {/if}
        {if $showbreadcrumb || $desc}
            <div class="d-flex space-between align-center">
                {if $showbreadcrumb}{include file="$template/includes/breadcrumb.tpl"}{/if}
                {if $desc}<span class="text-lighter text-small p-t-6">{$desc}</span>{/if}
            </div>
        {/if}
    {/if}
{/if}    