{if file_exists("templates/$template/overwrites/footer.tpl")}
    {include file="{$template}/overwrites/footer.tpl"}  
{else}
    {if $templatefile != 'homepage' && $templatefile != 'affiliatessignup'  && $custompage !='full'}
                        {if !$ignoreSidebars && !$inShoppingCart && ($primarySidebar->hasChildren() || $secondarySidebar->hasChildren()) || ($forceSidebar && !$inShoppingCart)}
                            </div>
                            <div class="main-sidebar sidebar-secondary col-md-3 pull-md-left sidebar">
                                {include file="$template/includes/sidebar-secondary-custom.tpl"}
                                {include file="$template/includes/sidebar.tpl" sidebar=$secondarySidebar}
                                {include file="$template/includes/sidebar-promo.tpl"}
                            </div>
                        {elseif !$ignoreHeader && !$skipMainBodyContainer && !$inShoppingCart}
                            </div>    
                        {/if}

                    <div class="clearfix"></div>
                </div>
            </div>
        </div>       
    {/if}
        {if file_exists("templates/$template/core/layouts/{$RSThemes.layouts.name}/footer.tpl")}
            {include file="{$template}/core/layouts/{$RSThemes.layouts.name}/footer.tpl"}  
        {else}
            {if $RSThemes['pages'][$templatefile]['optionvars']['isFullPage'] !== true && $templatefile!="oauth/layout"}
                <div class="main-footer hidden-print">
                    <div class="container"> 
                        <div class="footer-content">                       
                            <p>{lang key="copyrightFooterNotice" year=$date_year company=$companyname}</p> 
                            {if $languagechangeenabled && count($locales) > 1}
                                <ul class="footer-links">
                                    {include file="$template/includes/language-chooser.tpl"}                 
                                </ul>
                            {/if}
                        </div>
                        <div class="footer-actions">                           
                            <a href="#" class="back-to-top btn btn-sm btn-icon"><i class="lm lm-go-top"></i></a>
                        </div>
                    </div>
                </div>
            {/if}
        {/if}

        <div id="fullpage-overlay" class="hidden">
            <div class="outer-wrapper">
                <div class="inner-wrapper">
                    <img src="{$WEB_ROOT}/assets/img/overlay-spinner.svg">
                    <br>
                    <span class="msg"></span>
                </div>
            </div>
        </div>

        <div class="modal system-modal fade" id="modalAjax" tabindex="-1" role="dialog" aria-hidden="true" style="display: none">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><i class="lm lm-close"></i></button>
                        <h3 class="modal-title"></h3>
                    </div>
                    <div class="modal-body">
                        <div class="loader">
                            {include file="$template/includes/loader.tpl"}
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary modal-submit">
                            {$LANG.submit}
                        </button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">
                        {$LANG.close}
                        </button>
                    </div>
                </div>
            </div>
        </div>
        {include file="$template/includes/generate-password.tpl"}
    </div>
    {$footeroutput}
    <div class="overlay"></div>
    <script src="{$WEB_ROOT}/templates/{$template}/assets/js/vendor.js?v={$RSThemes['templateVersion']}"></script>
    <script src="{$WEB_ROOT}/templates/{$template}/assets/js/lagom-app.js?v={$RSThemes['templateVersion']}"></script>
    <script src="{$WEB_ROOT}/templates/{$template}/assets/js/whmcs-custom.min.js?v={$RSThemes['templateVersion']}"></script>
</body>
</html>
{/if}