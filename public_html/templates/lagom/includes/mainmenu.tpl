{if file_exists("templates/$template/includes/overwrites/mainmenu.tpl")}
    {include file="{$template}/includes/overwrites/mainmenu.tpl"}
{else}
    <section id="main-menu">
        <nav id="nav" class="navbar navbar-default navbar-main {if $languagechangeenabled && count($locales) > 1}{else}no-lang{/if}" role="navigation">
            <div class="container">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    {$rslang->trans('generals.menu')}
                </div>
                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="navbar-collapse" id="primary-nav">
                    <ul class="nav navbar-nav">
                        {include file="$template/includes/navbar.tpl" navbar=$primaryNavbar}
                    </ul>
                    <div class="navbar-nav navbar-right">
                        {if !$loggedin}
                            {if $type == "condensed"}<a href="{$WEB_ROOT}/cart.php?a=view" class="btn btn-link btn-icon"><i class="lm lm-basket">{if $cartitemcount > 0}<span class="label label-info">&nbsp;</span>{/if}</i></a>{/if}
                            {if $condlinks.allowClientRegistration == "on"}<a href="{$WEB_ROOT}/register.php" class="btn btn-default btn-outline">{$LANG.register}</a>{/if}
                            <a href="{$WEB_ROOT}/login.php" class="btn btn-primary">{$LANG.login}</a>
                        {else}
                            {if $type != "condensed"}
                                <a href="{$WEB_ROOT}/submitticket.php" class="btn btn-primary">
                                    {$LANG.navopenticket}
                                </a>
                            {/if}
                        {/if}
                    </div>
                    {if $languagechangeenabled && count($locales) > 1}
                        <ul class="nav navbar-nav language-nav">
                            <li class="dropdown language">
                                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                    <span class="item-text">{$activeLocale.localisedName}</span>
                                    <i class="ls ls-caret"></i>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-right" id="languageChooserContent">
                                    {foreach $locales as $locale}
                                        <li class="{if $activeLocale.language == $locale.language}active{/if}">
                                            <a href="{$currentpagelinkback}language={$locale.language}">{$locale.localisedName}</a>
                                        </li>
                                    {/foreach}
                                </ul>
                            </li>
                        </ul>
                    {/if}
                </div><!-- /.navbar-collapse -->
            </div>
        </nav>
    </section>
{/if}