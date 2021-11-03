{if file_exists("templates/$template/store/promos/overwrites/upsell.tpl")}
    {include file="{$template}/store/promos/overwrites/upsell.tpl"}  
{else}        
    <div class="promo-banner promo-banner-rounded promo-banner-slim {$promotion->getClass()}">
        <div class="panel-body">
            <div class="icon-left">
                <a href="{$promotion->getLearnMoreRoute()}">
                    <img src="{$promotion->getImagePath()}">
                </a>
            </div>

            <div class="content">

                <h3>
                    {$promotion->getHeadline()}
                </h3>
                <h4>
                    {$promotion->getTagline()}
                </h4>

                <form method="post" action="{$targetUrl}">
                    <input type="hidden" name="pid" value="{$product->id}">
                    {if $serviceId}
                        <input type="hidden" name="serviceid" value="{$serviceId}">
                    {/if}
                    <button type="submit" class="btn btn-success">
                    {if $product->isFree()}
                        {$promotion->getCta()}
                        {lang key="orderfree"}
                    {else}
                        {$promotion->getCta()} {$product->name}
                        {lang key="fromJust"}
                        {if $product->pricing()->first()->isYearly()}
                            {$product->pricing()->first()->yearlyPrice()}
                        {elseif $product->pricing()->first()->isOneTime()}
                            {$product->pricing()->first()->oneTimePrice()}
                        {else}
                            {$product->pricing()->first()->monthlyPrice()}
                        {/if}
                    {/if}
                    </button>

                {if $promotion->getLearnMoreRoute()}
                    <a href="{$promotion->getLearnMoreRoute()}">{lang key='learnmore'}...</a>
                {/if}
                </form>

            </div>

        </div>
    </div>
{/if}