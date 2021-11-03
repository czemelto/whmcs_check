{if file_exists("templates/$template/includes/overwrites/navbar.tpl")}
    {include file="{$template}/includes/overwrites/navbar.tpl"}  
{else}    
    {foreach $navbar as $item}
        <li menuItemName="{$item->getName()}" class="{if $item->hasChildren()}dropdown{/if} {if $navtype == "account"}account{/if}{if $item->getClass()} {$item->getClass()}{/if} {if $navtype == 'leftwide' && $item->getName() == $rsactivegroup}open{/if}" id="{$item->getId()}">
            <a {if $item->hasChildren()}class="dropdown-toggle" {if $navtype != 'leftwide'}data-toggle="dropdown"{/if} href="#"{else}href="{$item->getUri()}"{/if}{if $item->getAttribute('target')} target="{$item->getAttribute('target')}"{/if}>
                {if $item->hasIcon()}<i class="{$item->getIcon()}"></i>{/if}
                {if $navtype == "account" && $item->getName() == "Account"}
                    {if $loggedin}
                        <span class="item-text">{$loggedinUser->first_name} {$loggedinUser->last_name}</span>
                    {else}
                        <span class="item-text">{$LANG.myaccount}</span>
                    {/if}
                {else}
                    <span>{$item->getLabel()}</span>
                {/if}
                {if $item->hasBadge()}<span class="badge">{$item->getBadge()}</span>{/if}                
                {if $item->hasChildren()}<b class="ls ls-caret"></b>{/if}               
            </a>
            {if $item->hasChildren()}
                <ul class="dropdown-menu {if $navtype == "account"}dropdown-menu-right{/if}" {if $navtype == 'leftwide' && $item->getName() == $rsactivegroup}style="display: block"{/if}>
                    {if $RSThemes.layouts.vars.type == "navbar-left" && $navtype != "account"}
                        <li class="dropdown-header">{$item->getLabel()}</li>
                    {/if}
                    {if $navtype == "account" && $item->getName() == "Account" && $loggedin}    
                        <li class="dropdown-header">
                        <div class="dropdown-header-title">
                                {$loggedinUser->first_name} {$loggedinUser->last_name}
                            </div>
                            <div class="dropdown-header-desc">
                                {$loggedinUser->email} 
                            </div>
                        </li>
                        <li class="nav-divider"> 
                            -----
                        </li>
                    {/if}
                    {foreach $item->getChildren() as $childItem}
                        <li menuItemName="{$childItem->getName()}" class="{if $childItem->getClass()}{$childItem->getClass()}{/if} {if $childItem->getName() == $rsactivepage}active{/if}" id="{$childItem->getId()}">
                            <a href="{$childItem->getUri()}"{if $childItem->getAttribute('target')} target="{$childItem->getAttribute('target')}"{/if}>
                                {if $childItem->hasIcon()}<i class="{$childItem->getIcon()}"></i>{/if}
                                {$childItem->getLabel()}
                                {if $childItem->hasBadge()}<span class="badge">{$childItem->getBadge()}</span>{/if}
                            </a>
                        </li>
                    {/foreach}
                </ul>
            {/if}
        </li>
    {/foreach}
{/if}