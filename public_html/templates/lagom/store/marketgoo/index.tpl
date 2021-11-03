{if file_exists("templates/$template/store/marketgoo/overwrites/index.tpl")}
    {include file="{$template}/store/marketgoo/overwrites/index.tpl"}  
{else} 
    <div class="site site-marketgoo">
        <div class="site-banner">
            <div class="container">
                <div class="row d-flex">
                    <div class="col-lg-6 col-md-8">
                        <div class="banner-content">
                            <h1 class="banner-title">{lang key="store.marketgoo.headline"} {lang key="store.marketgoo.tagline"}</h1>
                            <div class="banner-actions">
                                <a href="#" class="btn btn-lg btn-primary" onclick="smoothScroll('#pricing');return false">{lang key='store.sitelockvpn.getStarted'}</a>
                                <a href="#" class="btn btn-lg btn-outline btn-outline-light" onclick="smoothScroll('#overview');return false">{lang key='learnmore'}</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-4">
                        <div class="banner-graphic"> 
                            {if file_exists("templates/$template/assets/svg-illustrations/products/marketgoo.tpl")}
                                {include file="$template/assets/svg-illustrations/products/marketgoo.tpl"}
                            {/if}
                        </div>
                    </div>
                </div>
            </div>
        </div> 
        <div class="site-section section-tiles" id="overview">
            <div class="container">
                <div class="section-content">
                    <div class="row row-eq-height">
                        <div class="col-md">
                            <div class="tile has-shadow has-arrow">
                                <span class="number">
                                    1
                                </span>
                                <span class="title">
                                    {lang key="store.marketgoo.features.1"}
                                </span>
                            </div>
                        </div>
                        <div class="col-md">
                            <div class="tile has-shadow has-arrow">
                                <span class="number">
                                    2
                                </span>
                                <span class="title">
                                    {lang key="store.marketgoo.features.2"}
                                </span>
                            </div>
                        </div>
                        <div class="col-md">
                            <div class="tile has-shadow">
                                <span class="number">
                                    3
                                </span>
                                <span class="title">
                                    {lang key="store.marketgoo.features.3"}
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="site-section section-video">
            <div class="container">
                <div class="section-content">
                    <div class="embed-responsive has-shadow">                 
                        <iframe src="https://player.vimeo.com/video/394484913" class="embed-responsive-item" allow="autoplay; fullscreen" allowfullscreen></iframe>
                    </div>
                </div>
            </div>
        </div>     
        <div class="site-section">
            <div class="container">
                <div class="section-content">
                    <div class="row d-flex-align f-flow">
                        <div class="col-md-6 section-graphic">
                            <div class="browser has-shadow">
                                <div class="browser-top">
                                    <div class="browser-actions"><span></span><span></span><span></span></div>
                                </div>
                                <img class="w-100" src="{$WEB_ROOT}/templates/{$template}/assets/img/store/marketgoo/start-improving.gif" alt="{lang key="store.marketgoo.features.4"}" />
                            </div> 
                        </div>
                        <div class="col-md-6">
                            <div class="section-content">
                                <h2 class="section-title">{lang key="store.marketgoo.features.4"}</h2>
                                <p class="section-desc">{lang key="store.marketgoo.featuresdetail.4"}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>   
        <div class="site-section">
            <div class="container">
                <div class="section-content">
                    <div class="row d-flex-align f-flow">                       
                        <div class="col-md-6">
                            <div class="section-content">
                                <h2 class="section-title">{lang key="store.marketgoo.features.5"}</h2>
                                <p class="section-desc">{lang key="store.marketgoo.featuresdetail.5"}</p>
                            </div>
                        </div>
                         <div class="col-md-6 section-graphic">
                            <div class="browser has-shadow">
                                <div class="browser-top">
                                    <div class="browser-actions"><span></span><span></span><span></span></div>
                                </div>
                                <img class="w-100" src="{$WEB_ROOT}/templates/{$template}/assets/img/store/marketgoo/track.gif" alt="{lang key="store.marketgoo.features.5"}" />
                            </div> 
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="site-section section-dark" id="pricing">
            <div class="container">
                <div class="currency-flex currency-sitelock">
                    <h2 class="section-title text-center">
                        {lang key='store.marketgoo.tab.features'}
                    </h2>
                    <div class="currency-selector">
                        {if !$loggedin && $currencies}
                            <form method="post" action="">
                                <select name="currency" class="form-control currency-selector" onchange="submit()">
                                    <option>{lang key="changeCurrency"} ({$activeCurrency.prefix} {$activeCurrency.code})</option>
                                    {foreach $currencies as $currency}
                                        <option value="{$currency['id']}">{$currency['prefix']} {$currency['code']}</option>
                                    {/foreach}
                                </select>
                            </form>
                        {/if}
                    </div>
                </div>
                <div class="section-content">                     
                    <div class="row row-eq-height row-eq-height-sm">
                        {if count($plans) > 0}
                            {foreach $plans as $plan}
                                <div class="col-lg-{if $plan@total == 1}4 {if $plan@first}col-md-offset-4{/if}{elseif $plan@total == 2}4 {if $plan@first}col-md-offset-2{/if}{elseif $plan@total == 3}4{elseif $plan@total == 4}3{elseif $plan@total == 5}4{else}3{/if}">
                                    <div class="package">
                                        <h4 class="package-title">{$plan->name}</h4>
                                    
                                        <div class="package-price"> 
                                            <div class="price monthly">
                                            {if $plan->isFree()}
                                                {lang key='orderpaymenttermfree'}
                                            {elseif $plan->pricing()->first()}
                                                {$plan->pricing()->first()->toPrefixedString()}
                                            {else}
                                                -
                                            {/if}
                                            </div>
                                        </div>
                                        <ul class="package-features">
                                            {foreach $plan->features as $label => $value}
                                                <li>
                                                    <span>{lang key="store.marketgoo.featurematrix."|cat:$value@iteration}</span> 
                                                    {if is_bool($value)}{else} - <b>{$value}</b>{/if}
                                                </li>
                                            {/foreach}
                                        </ul>
                                        <div class="package-actions">
                                            <form action="{routePath('cart-order')}" method="post">
                                                <input type="hidden" name="pid" value="{$plan->id}">
                                                <button type="submit" class="btn btn-primary btn-block btn-signup">
                                                    {lang key='store.marketgoo.signup'}
                                                </button>
                                            </form>
                                        </div>
                                    </div>    
                                </div>
                            {/foreach}
                        {elseif $inPreview}
                            <div class="lead text-center">
                                {lang key="store.sitelockvpn.adminPreview"}
                            </div>
                        {/if}    
                    </div>
                </div>
            </div>
        </div>    


        {assign var=testimonials value=[
            [
            'author'=> 'Heather Figi',
            'avatar' => 'user-testimonial-1.jpg',
            'website'=> 'https://www.marketgoo.com/blog-post/2018/08/30/review-music-for-violinists/',
            'description' => 'marketgoo made the complicated simple for me. I never knew where to start with SEO until I started using this service. Literally, I more than doubled my traffic when I started using this.'
            ],
            [
            'author'=> 'Ian Glass',
            'avatar' => 'user-testimonial-2.jpg',
            'website'=> 'https://www.marketgoo.com/blog-post/2019/10/29/review-ian-glass-fitness/',
            'description' => 'Without marketgoo I would never have been able to have my website on the first page of google for all the keywords that are linked to my business, its ease of use and the customer service when I’ve needed help has been first class.'
            ],
            [
            'author'=> 'Simon Saleh',
            'avatar' => 'user-testimonial-3.jpg',
            'website'=> 'https://www.marketgoo.com/blog-post/2019/09/09/review-wanderlust-ironworks/',
            'description' => 'Such a simple reliable platform! It’s helped me see where we stand next to our local competitors. Its part of our day to day. The best feature is the keyword tool.'
            ],
            [
            'author'=> 'Svein Koningen',
            'avatar' => 'user-testimonial-4.jpg',
            'website'=> 'https://www.marketgoo.com/blog-post/2018/06/24/marketgoo-review-koningen-art/',
            'description' => 'marketgoo reports give me everything I need to know for my site’s SEO. I am constantly fine tuning my site to work towards a higher rating. I read various marketgoo reports then immediately work out how to implement recommendations.'
            ]
        ]}
        <div class="site-section">
            <div class="section-content">
                <div class="container">
                    <h2 class="section-title text-center">{$rslang->trans('homepage.testimonials.title')}</h2>
                    <p class="section-subtitle text-center">{$rslang->trans('homepage.testimonials.subtitle')}</p>
                    <div class="slider testimonials" data-testimonial-slider>
                        <div class="content-slider" data-slider-container>
                            <div class="content-slider-wrapper" data-slider-wrapper>
                                {foreach from=$testimonials item=testimonial key=testimonial_key}
                                    <div class="content-slider-item testimonials-item has-shadow">
                                        <div class="testimonials-desc">
                                            <p>{$testimonial.description}</p>
                                        </div>
                                        <div class="testimonials-details">
                                            <div class="testimonials-avatar">
                                                <img src="{$WEB_ROOT}/assets/img/marketconnect/marketgoo/{$testimonial.avatar}" alt="{$testimonial.author}">
                                                <span>”</span>
                                            </div>
                                            <div class="testimonials-author">
                                                <span>{$testimonial.author}</span><br>
                                                <a href="{$testimonial.website}" target="_blank">{lang key="store.marketgoo.testimonials.casestudy"}</a>
                                            </div>
                                        </div>
                                    </div>
                                {/foreach}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>    
        <div class="site-section">
            <div class="container">
                <h2 class="section-title text-center">{lang key="store.marketgoo.faqs.title"}</h2>
                <div class="section-content m-w-md m-a">
                    <div id="accordion">
                        <div class="panel panel-default panel-accordion is-open">
                            <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#faq1" aria-expanded="true">
                                <h4 class="panel-title"><i class="lm lm-plus"></i>{lang key="store.marketgoo.faqs.q1"}</h4>
                            </div>
                            <div id="faq1" class="panel-collapse collapse in" aria-expanded="true" style="">
                                <div class="panel-body">
                                    <p>{lang key="store.marketgoo.faqs.a1"}</p>
                                    <a href="https://vimeo.com/whmcs/marketgoo-lite-vs-pro" target="_blank">
                                        <img style="min-width: 50%"src="{$WEB_ROOT}/assets/img/marketconnect/marketgoo/video-comparison.png">
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default panel-accordion">
                            <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#faq2" aria-expanded="true">
                                <h4 class="panel-title"><i class="lm lm-plus"></i>{lang key="store.marketgoo.faqs.q2"}</h4>
                            </div>
                            <div id="faq2" class="panel-collapse collapse" aria-expanded="true" style="">
                                <div class="panel-body">
                                    <p>{lang key="store.marketgoo.faqs.a2"}</p>
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default panel-accordion">
                            <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#faq3" aria-expanded="true">
                                <h4 class="panel-title"><i class="lm lm-plus"></i>{lang key="store.marketgoo.faqs.q3"}</h4>
                            </div>
                            <div id="faq3" class="panel-collapse collapse" aria-expanded="true" style="">
                                <div class="panel-body">
                                    <p>{lang key="store.marketgoo.faqs.a3"}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div> 
        </div>
    </div>

{/if}



