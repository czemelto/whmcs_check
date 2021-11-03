{if file_exists("templates/$template/includes/overwrites/sidebar.tpl")}
    {include file="{$template}/includes/overwrites/sidebar.tpl"}
{else}
    {foreach $sidebar as $item}
        <div menuItemName="{$item->getName()}" class="panel panel-sidebar {if $item->getClass()}{$item->getClass()}{else}panel-sidebar{/if}{if $item->getExtra('mobileSelect') and $item->hasChildren()} hidden-sm hidden-xs{/if}"{if $item->getAttribute('id')} id="{$item->getAttribute('id')}"{/if}>
            <div class="panel-heading">
                <h3 class="panel-title">
                    {if $item->hasIcon()}<i class="{$item->getIcon()}"></i>&nbsp;{/if}
                    {$item->getLabel()}
                    {if $item->hasBadge()}&nbsp;<span class="badge">{$item->getBadge()}</span>{/if}
                    <i class="fa fa-chevron-up panel-minimise pull-right"></i>
                </h3>
            </div>
            {if $item->hasBodyHtml()}
                <div class="panel-body">
                    {$item->getBodyHtml()}
                </div>
            {/if}
            {if $item->hasChildren()}
                <div class="list-group{if $item->getChildrenAttribute('class')} {$item->getChildrenAttribute('class')}{/if}">
                    {foreach $item->getChildren() as $childItem}
                        {if $childItem->getName() != "Domain Contacts"}
                            {if $childItem->getUri()}
                                <a menuItemName="{$childItem->getName()}" href="{if $item->getName() =="Domain Details Management" || $item->getName() =="Service Details Overview"}{if $childItem->getUri()|strstr:"action"}{$childItem->getUri()}{else}{$childItem->getUri()|replace:$WEB_ROOT:""|replace:"/":""}{/if}{else}{$childItem->getUri()}{/if}" class="list-group-item{if $childItem->isDisabled()} disabled{/if}{if $childItem->getClass()} {$childItem->getClass()}{/if}{if $childItem->isCurrent()} active{/if}"{if $childItem->getAttribute('dataToggleTab')} data-toggle="tab"{/if}{if $childItem->getAttribute('target')} target="{$childItem->getAttribute('target')}"{/if} id="{$childItem->getId()}">
                                    {if $childItem->hasBadge()}<span class="badge">{$childItem->getBadge()}</span>{/if}
                                    {if $item->getName() == "Announcements Months"}
                                        {if $childItem->getName() != "Older" && $childItem->getName() != "RSS Feed"}
                                            <i class="ls ls-calendar"></i>
                                        {else}
                                            {if $childItem->hasIcon()}
                                                <i class="{$childItem->getIcon()}"></i>
                                            {/if}
                                        {/if}
                                    {elseif $item->getName() == "Attachments"}
                                        <i class="ls ls-download"></i>
                                    {else}
                                        {if $childItem->hasIcon()}
                                            <i class="{$childItem->getIcon()}"></i>
                                        {/if}
                                    {/if}
                                    {$childItem->getLabel()|replace:'style="color':'class="status" style="--status-color'}

                                </a>
                            {else}
                                <div menuItemName="{$childItem->getName()}" class="list-group-item{if $childItem->getClass()} {$childItem->getClass()}{/if}" id="{$childItem->getId()}">
                                    {if $childItem->hasBadge()}<span class="badge">{$childItem->getBadge()}</span>{/if}
                                    {if $childItem->hasIcon()}<i class="{$childItem->getIcon()}"></i>&nbsp;{/if}

                                    {if $item->getName() == "Ticket Information" && $childItem->getName() != "Subject"}
                                        {$childItem->getLabel()|replace:'<br />':'<span class="pull-right">'}</span>
                                    {elseif $childItem->getName() == "Subject"}
                                        {$childItem->getLabel()|replace:'class="label"':''|replace:'style="background-color':'class="status" style="--status-color'}
                                    {else}
                                        {$childItem->getLabel()}
                                    {/if}

                                </div>

                            {/if}
                        {/if}
                    {/foreach}

                    {if $item->getLabel() == "Kezelés"}
                        <a menuItemName="Domain tulajdonos kezelése"
                           href="#tabauditlogs"
                           class="list-group-item" data-toggle="tab">

                            <i class="fas fa-ticket ls ls-shield"></i>
                            Audit logok
                        </a>
                        <a menuItemName="Domain tulajdonos kezelése"
                           href="{if $owner_contact_type == 0}/clientarea.php?action=details {elseif $owner_contact_type == 2} /index.php?rp=/account/contacts&contactid={$owner_contact_id} {/if}"
                           class="list-group-item" target="" id="">

                            <i class="fas fa-ticket ls ls-user"></i>
                            Domain tulajdonos kezelése
                        </a>
                        <a menuItemName="Admin kapcsolattartó kezelése"
                           href="{if $admin_contact_type == 0}/clientarea.php?action=details {elseif $admin_contact_type == 2} /index.php?rp=/account/contacts&contactid={$admin_contact_id} {/if}"
                           class="list-group-item" target="" id="">

                            <i class="fas fa-ticket ls ls-user"></i>
                            Admin kapcsolattartó kezelése
                        </a>
                        {$alma}
                    {/if}
                </div>
            {/if}
            {if $item->hasFooterHtml()}
                <div class="panel-footer clearfix">
                    {$item->getFooterHtml()}
                </div>
            {/if}
        </div>
        {* {if $item->getExtra('mobileSelect') and $item->hasChildren()}
            <div class="panel hidden-lg hidden-md {if $item->getClass()}{$item->getClass()}{else}panel-default{/if}"{if $item->getAttribute('id')} id="{$item->getAttribute('id')}"{/if}>
                <div class="panel-heading">
                    <h3 class="panel-title">
                        {if $item->hasIcon()}<i class="{$item->getIcon()}"></i>&nbsp;{/if}
                        {$item->getLabel()}
                        {if $item->hasBadge()}&nbsp;<span class="badge">{$item->getBadge()}</span>{/if}
                    </h3>
                </div>
                <div class="panel-body">
                    <form role="form">
                        <select class="form-control" onchange="selectChangeNavigate(this)">
                            {foreach $item->getChildren() as $childItem}
                                <option menuItemName="{$childItem->getName()}" value="{$childItem->getUri()}" class="list-group-item" {if $childItem->isCurrent()}selected="selected"{/if}>
                                    {$childItem->getLabel()}
                                    {if $childItem->hasBadge()}({$childItem->getBadge()}){/if}
                                </option>
                            {/foreach}
                        </select>
                    </form>
                </div>
                {if $item->hasFooterHtml()}
                    <div class="panel-footer">
                        {$item->getFooterHtml()}
                    </div>
                {/if}
            </div>
        {/if} *}
    {/foreach}
{/if}