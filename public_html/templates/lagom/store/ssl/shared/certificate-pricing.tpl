<div class="site-section section-dark" id="pricing" {$type}>
    <div class="container">
        <div class="currency-flex currency-ssl">
            <h2 class="section-title text-center">{lang key='store.ssl.shared.pricing'}</h2>
            {include file="$template/store/ssl/shared/currency-chooser.tpl"}
        </div>
        <div class="section-content certificate-options dv">
            <div class="row row-eq-height row-eq-height-xs">
                {if count($certificates.$type) > 0}
                    {foreach $certificates.$type as $product}
                        <div class="col-md-{if count($certificates.$type) == 1}12{elseif count($certificates.$type) == 2}6{else}4{/if}">
                            <div class="package">
                                <h4 class="package-title">{$product->name}</h4>
                                <div class="package-price">
                                    <div class="price">
                                    {if $product->pricing()->annual()}
                                        <span class="1yr">{if $activeCurrency.prefix}<span class="price-prefix">{$activeCurrency.prefix}</span>{/if}{$product->pricing()->annual()->yearlyPrice()|replace:$activeCurrency.suffix:""|replace:$activeCurrency.prefix:""|replace:"/":""|replace:$LANG.pricingCycleShort.annually:''}{$activeCurrency.suffix}<span class="price-cycle">{lang key="orderForm.shortPerYear" years={$LANG.pricingCycle.annually}}</span></span>
                                    {/if}
                                    {if $product->pricing()->biennial() && !$product->pricing()->annual()}
                                        <span class="1yr">{if $activeCurrency.prefix}<span class="price-prefix">{$activeCurrency.prefix}</span>{/if}{$product->pricing()->biennial()->yearlyPrice()|replace:$activeCurrency.suffix:""|replace:$activeCurrency.prefix:""|replace:"/":""|replace:$LANG.pricingCycleShort.annually:''}{$activeCurrency.suffix}<span class="price-cycle">{lang key="orderForm.shortPerYears" years={$LANG.pricingCycle.biennially}}</span></span>
                                    {/if}
                                    </div>
                                </div>    
                                <ul class="package-features">                              
                                    <li>{lang key='store.ssl.shared.encryption256'}</li>
                                    <li>{lang key='store.ssl.shared.issuanceTime'}: {$certificateFeatures.{$product->configoption1}.issuance}</li>
                                    <li>{lang key='store.ssl.shared.greatFor'}: <b>{$certificateFeatures.{$product->configoption1}.for} </b> </li>
                                    <li>{lang key='store.ssl.shared.warrantyValue'}: <b>USD ${$certificateFeatures.{$product->configoption1}.warranty}</b></li>
                                    <li>{lang key='store.ssl.shared.siteSeal'}</li>
                                    <li>{lang key='store.ssl.shared.freeReissues'}</li>
                                    <li>{lang key='store.ssl.shared.browserSupport'}: <b>99.9%</b></li>
                                </ul>
                                <div class="package-actions">
                                    <form method="post" action="{routePath('cart-order')}">
                                        <input type="hidden" name="pid" value="{$product->id}">
                                        <button type="submit" class="btn btn-primary btn-block">{$LANG.store.ssl.landingPage.buyNow}</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    {/foreach}
                {else}
                <div class="col-xs-9">
                    <div class="lead preview-text">
                        {lang key='store.ssl.shared.noProducts'}
                    </div>
                </div>
                {/if}
                {*
                <br>
                <div class="row">
                    <div class="{if count($certificates.$type) == 1}col-sm-6 col-sm-offset-6{elseif count($certificates.$type) == 2}col-sm-8 col-sm-offset-4{else}col-sm-9 col-sm-offset-3{/if} text-center">
                        <a href="{routePath('store-ssl-certificates-index')}#helpmechoose" class="help-me-choose">
                            <i class="fas fa-question-circle"></i>
                            {lang key='store.ssl.shared.helpMeChoose'}
                        </a>
                    </div>
                </div>
                *}
            </div>
        </div>
    </div>
</div>                
