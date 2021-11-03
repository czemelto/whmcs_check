{if $type == "login"}
    <div class="logincontainer-language dropup language" data-language-select>
        <span>{$LANG.language}:&nbsp;</span>
        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
            {$activeLocale.localisedName}
            <b class="ls ls-caret"></b>
        </a>
        <div class="dropdown-menu dropdown-language-search dropdown-menu-right" id="languageChooserContent" >
            <input type="hidden" data-language-select-value value="{$activeLocale.localisedName}">
            <input type="hidden" data-language-select-backlink value="{$currentpagelinkback}">
            <input type="hidden" data-language-select-lang value="{$LANG['upgradeService']['select']}">
            <div class="dropdown-header input-group align-center">
                <i class="input-group-icon lm lm-search"></i>
                <input class="form-control" placeholder="{$LANG.search}..." type="text" data-language-select-search>
            </div>
            <div class="nav-divider"></div>
            <div class="dropdown-menu-items" data-language-select-list>
            {foreach $locales as $locale}
                <div class="dropdown-menu-item {if $activeLocale.language == $locale.language}active{/if}" data-value="{$locale.language}" data-language="{$locale.localisedName}">
                    <a href="{$currentpagelinkback}language={$locale.language}">
                        <span class="language-flag {$locale.language}"></span>
                        <span class="language-text">{$locale.localisedName}</span>
                    </a>
                </div>
            {/foreach}
            </div>
            <div class="dropdown-menu-item dropdown-menu-no-data">
                <span class="text-info text-large">
                    {$LANG.norecordsfound}
                </span>
            </div>                  
        </div>   
    </div>
{else}
    <li class="dropdown language" data-language-select>
        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
            {$activeLocale.localisedName}
            <b class="ls ls-caret"></b>
        </a>
        <div class="dropdown-menu dropdown-language-search dropdown-menu-right" id="languageChooserContent" >
            <input type="hidden" data-language-select-value value="{$activeLocale.localisedName}">
            <input type="hidden" data-language-select-backlink value="{$currentpagelinkback}">
            <input type="hidden" data-language-select-lang value="{$LANG['upgradeService']['select']}">
            <div class="dropdown-header input-group align-center">
                <i class="input-group-icon lm lm-search"></i>
                <input class="form-control" placeholder="{$LANG.search}..." type="text" data-language-select-search>
            </div>
            <div class="nav-divider"></div>
            <div class="dropdown-menu-items" data-language-select-list>
            {foreach $locales as $locale}
                <div class="dropdown-menu-item {if $activeLocale.language == $locale.language}active{/if}" data-value="{$locale.language}" data-language="{$locale.localisedName}">
                    <a href="{$currentpagelinkback}language={$locale.language}">
                        <span class="language-flag {$locale.language}"></span>
                        <span class="language-text">{$locale.localisedName}</span>
                    </a>
                </div>
            {/foreach}
            </div>
            <div class="dropdown-menu-item dropdown-menu-no-data">
                <span class="text-info text-large">
                    {$LANG.norecordsfound}
                </span>
            </div>                  
        </div>                 
    </li>
{/if}