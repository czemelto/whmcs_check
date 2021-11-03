{if file_exists("templates/$template/store/ssl/overwrites/competitive-upgrade.tpl")}
    {include file="{$template}/store/ssl/overwrites/competitive-upgrade.tpl"}  
{else} 
 <div class="site site-ssl-certificates">
    <div class="site-banner">
        <div class="container">
            <div class="row d-flex">
                <div class="col-lg-6 col-md-8">
                    <div class="banner-content">
                        <h1 class="banner-title">{lang key='store.ssl.competitiveUpgrades.switch'}</h1>
                        <div class="banner-desc">
                            <p>{lang key='store.ssl.competitiveUpgrades.replace'}</p>
                        </div>
                        <div class="banner-actions">
                            <a href="#" class="btn btn-lg btn-primary" onclick="smoothScroll('#overview');return false">{lang key='store.ssl.shared.switch'}</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-4">
                    <div class="banner-graphic"> 
                        {if file_exists("templates/$template/assets/svg-illustrations/products/sitelock.tpl")}
                            {include file="$template/assets/svg-illustrations/products/sitelock.tpl"}
                        {/if}
                    </div>
                </div>
            </div>
        </div>
    </div>
    {include file="$template/store/ssl/shared/nav.tpl" current="competitiveupgrade"}   
    <div class="site-section" id="overview">
        <div class="container">
            <div class="section-content text-center">
                    <div class="m-w-928 m-h-a">
                        <h4 class="m-b-24">{lang key='store.ssl.competitiveUpgrades.buyWithTime'} <strong>{lang key='store.ssl.competitiveUpgrades.foc'}</strong>.</h4>
                        <div class="alert alert-warning text-left">
                            <div class="alert-body">
                                <strong>{lang key='store.ssl.competitiveUpgrades.exampleScenario'}</strong><br>
                                {lang key='store.ssl.competitiveUpgrades.example.line1'}
                                {lang key='store.ssl.competitiveUpgrades.example.line2'}
                                {lang key='store.ssl.competitiveUpgrades.example.line3'}
                            </div>
                        </div>
                        <p>{lang key='store.ssl.competitiveUpgrades.eligibilityCheck'}</p>
                        {if $connectionError}
                            <div class="alert alert-danger">
                                <div class="alert-body">
                                    {lang key='store.ssl.competitiveUpgrades.checkFailed'}
                                </div>
                            </div>
                        {elseif $error}
                            <div class="alert alert-danger">
                                <div class="alert-body">
                                {$error}
                                    </div>
                            </div>
                        {else}
                            <br>
                        {/if}

                        <form method="post" action="{routePath('cart-ssl-certificates-competitiveupgrade-validate')}">

                            {if $validated}
                                {if $eligible}
                                    <div class="alert alert-success text-center">
                                        <div class="alert-body">
                                        {lang key='store.ssl.competitiveUpgrades.eligible'}
                                        </div>
                                    </div>
                                    <table class="table table-striped">
                                        <tr>
                                            <td>{lang key='store.ssl.competitiveUpgrades.expirationDate'}</td>
                                            <td>{$expirationDate}</td>
                                        </tr>
                                        <tr>
                                            <td>{lang key='store.ssl.competitiveUpgrades.monthsRemaining'}</td>
                                            <td>{lang key='store.ssl.competitiveUpgrades.months' months=$monthsRemaining}</td>
                                        </tr>
                                        <tr>
                                            <td>{lang key='store.ssl.competitiveUpgrades.freeExtension'}</td>
                                            <td>{lang key='store.ssl.competitiveUpgrades.months' months=$freeExtensionMonths}{if $freeExtensionMonths < $monthsRemaining} ({lang key='store.ssl.competitiveUpgrades.maxMonths'}){/if}</td>
                                        </tr>
                                        {if isset($maxPotentialSavingAmount)}
                                            <tr>
                                                <td>{lang key='store.ssl.competitiveUpgrades.saving'}</td>
                                                <td>{lang key='store.ssl.competitiveUpgrades.savingDescription' saveAmount=$maxPotentialSavingAmount}</td>
                                            </tr>
                                        {/if}
                                    </table>
                                    <a class="btn btn-primary btn-lg" href="{routePath('store-product-group', $productGroupSlug, 'ev')}">
                                        {lang key='store.ssl.competitiveUpgrades.continue'}
                                    </a>
                                {else}
                                    <div class="alert alert-warning text-center">
                                        {lang key='store.ssl.competitiveUpgrades.ineligible'}*.
                                    </div>
                                {/if}
                            {/if}

                            {if !$validated || !$eligible}
                                <div class="input-group input-group-lg">
                                    <span class="input-group-addon">https://</span>
                                    <input type="text" name="url" value="{$url}" class="form-control" placeholder="{lang key='store.ssl.competitiveUpgrades.enterDomain'}">
                                    <span class="input-group-btn">
                                        <button type="submit" class="btn btn-primary">
                                            {lang key='store.ssl.competitiveUpgrades.validate'}
                                        </button>
                                    </span>
                                </div>
                                <p><small>* {lang key='store.ssl.competitiveUpgrades.competitors'}</small></p>
                            {/if}
                        </form>

                    </div>
                </div>
            </div>
        </div>
    </div>
    {literal}
        <script>
            if(window.location.hash == "#overview") {
                smoothScroll('#overview');
            }
        </script>
    {/literal}
{/if}