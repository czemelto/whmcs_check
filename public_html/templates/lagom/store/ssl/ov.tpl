{if file_exists("templates/$template/store/ssl/overwrites/ov.tpl")}
    {include file="{$template}/store/ssl/overwrites/ov.tpl"}  
{else}

<div class="site site-ssl-certificates">
    <div class="site-banner">
        <div class="container">
            <div class="row d-flex">
                <div class="col-lg-6 col-md-8">
                    <div class="banner-content">
                        <h1 class="banner-title">{lang key="store.ssl.ov.title"}</h1>
                        <div class="banner-desc">
                            <p> {lang key="store.ssl.ov.tagline"} </p>
                        </div>
                        <div class="banner-actions">
                            <a href="#" class="btn btn-lg btn-primary" onclick="smoothScroll('#pricing');return false">{$LANG.clientareaaddonpricing}</a>
                            <a href="#" class="btn btn-lg btn-outline btn-outline-light" onclick="smoothScroll('#overview');return false">{$LANG.learnmore}</a>
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
    {include file="$template/store/ssl/shared/nav.tpl" current="ov"}  
    <div class="site-section" id="overview">
        <div class="container">
            <div class="section-content">
                <div class="row d-flex-align f-flow">
                        <div class="col-md-6">
                            <h2 class="section-title">{lang key="store.ssl.ov.descriptionTitle"}</h2>
                            <div class="section-desc">
                                <p>{lang key="store.ssl.ov.descriptionContent"}</p>
                                <br>
                                <h3>{lang key="store.ssl.useCases.title"}</h3>
                                <div class="row row-features row-eq-height">
                                    <div class="col-sm-4">
                                        <div class="feature feature-sm feature-boxed">
                                            <div class="feature-icon">                                            
                                                <i class="fas fa-lock-alt"></i>
                                            </div>
                                            <div class="feature-content">
                                                <h6>{lang key="store.ssl.useCases.loginPages"}</h6>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="feature feature-sm feature-boxed">
                                            <div class="feature-icon">                                            
                                                <i class="fas fa-project-diagram"></i>
                                            </div>
                                            <div class="feature-content">
                                                <h6>{lang key="store.ssl.useCases.intranetSites"}</h6>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="feature feature-sm feature-boxed">
                                            <div class="feature-icon">                                            
                                                <i class="fas fa-inbox"></i>
                                            </div>
                                            <div class="feature-content">
                                                <h6>{lang key="store.ssl.useCases.webmail"}</h6>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 section-graphic section-graphic-right">
                            <div class="browser browser-sm has-shadow">
                                <div class="browser-top">
                                    <div class="browser-actions"><span></span><span></span><span></span></div>
                                </div>
                                {if file_exists("templates/$template/assets/svg-icon/store/SSL/ssl-preview-2.tpl")}
                                    {include file="$template/assets/svg-icon/store/SSL/ssl-preview-2.tpl"}
                                {/if}
                            </div> 
                        </div>
                    </div>
            </div>
        </div>
    </div>
    {include file="$template/store/ssl/shared/certificate-pricing.tpl" type="ov"}   
    <div class="site-section">
        <div class="container">
            <div class="section-content">
                <div class="row d-flex-align f-flow">
                    <div class="col-md-6 section-graphic">
                        <div class="graphic">
                            <img class="has-shadow" src="{$WEB_ROOT}/assets/img/marketconnect/symantec/cert-details-ov.png">
                        </div>
                    </div>
                    <div class="col-md-6"> 
                        <h2 class="section-title">{lang key="store.ssl.ov.orgInfo"}</h2>
                        <div class="section-desc">
                            <p>{lang key="store.ssl.ov.orgInfoDescription"}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>    
    {include file="$template/store/ssl/shared/features.tpl" type="ov"}
    {include file="$template/store/ssl/shared/logos.tpl"}
    {*{include file="$template/get-started.tpl"} *}
{/if}
</div>