{if isset($RSThemes.pages.affiliatessignup)}
    {include file=$RSThemes['pages']['affiliatessignup']['fullPath']}
{else}
    {if $affiliatesystemenabled}
        {if $RSThemes.layouts.vars.type != "navbar-left"}
            <div class="app-main">
        {/if}
        <div class="main-body has-banner main-body-affiliates">
            <div class="banner banner-affiliates pattern-bg-affiliates">
                <div class="container text-center">
                    <h1 class="banner-title">{$LANG.affiliatesignuptitle}!</h1>
                    <p class="faded">{$LANG.affiliatesignupintro|replace:"..":""}</p>
                    <form method="post" action="affiliates.php">
                        <input type="hidden" name="activate" value="true"/>
                        <input type="submit" value="{$LANG.affiliatesactivate}" class="btn btn-primary btn-lg">
                    </form>
                </div>
            </div>
            <div class="main-content">
                <div class="container">
                    <div class="main-grid row">
                        <!-- Container for main page display content -->
                        <div class="main-content">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="text-center m-a m-w-466">                                    
                                        {include file="$template//assets/svg-icon/track.tpl"}    
                                        <h3>{$rslang->trans('affiliates.visitors.title')}</h3>
                                        <p class="text-light">{$rslang->trans('affiliates.visitors.desc')}</p>
                                        <small>{$rslang->trans('affiliates.visitors.info')}</small>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="text-center m-a m-w-466">                                    
                                        {include file="$template//assets/svg-icon/comissions.tpl"}
                                        <h3>{$rslang->trans('affiliates.pay_commissions.title')}</h3>
                                        <p class="text-light">{$rslang->trans('affiliates.pay_commissions.desc')}</p>
                                        <small>{$rslang->trans('affiliates.pay_commissions.info')} <a href="{$systemurl}contact.php">{$LANG.contactus|lower}</a> .</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        {if $RSThemes.layouts.vars.type != "navbar-left"}
            </div>
        {/if}
    {else}
        {include file="$template/includes/alert.tpl" type="warning" msg=$LANG.affiliatesdisabled textcenter=true}
    {/if}
{/if}