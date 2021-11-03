{if file_exists("templates/$template/store/ssl/overwrites/dv.tpl")}
    {include file="{$template}/store/ssl/overwrites/dv.tpl"}  
{else}    
<div class="site site-ssl-certificates">
    <div class="site-banner">
        <div class="container">
            <div class="row d-flex">
                <div class="col-lg-6 col-md-8">
                    <div class="banner-content">
                        <h1 class="banner-title">{lang key="store.ssl.dv.title"}</h1>
                        <div class="banner-desc">
                            <p> {lang key="store.ssl.dv.tagline"}</p>
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
    {include file="$template/store/ssl/shared/nav.tpl" current="dv"}  
    
    <div class="site-section" id="overview">
        <div class="container">
            <div class="section-content">
                <div class="row d-flex-align f-flow">
                        <div class="col-md-6">
                            <h2 class="section-title">{lang key="store.ssl.dv.descriptionTitle"}</h2>
                            <div class="section-desc">
                                <p>{lang key="store.ssl.dv.descriptionContent"}</p>    
                                <br>
                                <h3>{lang key="store.ssl.useCases.title"}</h3>
                                <div class="row row-features row-eq-height">
                                    <div class="col-sm-4">
                                        <div class="feature feature-sm feature-boxed">
                                            <div class="feature-icon">                                            
                                                <i class="fas fa-comment-alt-lines"></i>
                                            </div>
                                            <div class="feature-content">
                                                <h6>{lang key="store.ssl.useCases.blogs"}</h6>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="feature feature-sm feature-boxed">
                                            <div class="feature-icon">                                            
                                                <i class="fas fa-file-alt"></i>
                                            </div>
                                            <div class="feature-content">
                                                <h6>{lang key="store.ssl.useCases.infoPages"}</h6>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="feature feature-sm feature-boxed">
                                            <div class="feature-icon">                                            
                                                <i class="fas fa-server"></i>
                                            </div>
                                            <div class="feature-content">
                                                <h6>{lang key="store.ssl.useCases.serverComms"}</h6>
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
    {include file="$template/store/ssl/shared/certificate-pricing.tpl" type="dv"}
    {include file="$template/store/ssl/shared/features.tpl" type="dv"}       
    {include file="$template/store/ssl/shared/logos.tpl"}
{/if}

</div>