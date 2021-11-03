<div class="site-section">
    <div class="container">
        <div class="section-content">
            <div class="row row-features">
                {if $type == 'ev'}
                    <div class="col-sm-4 m-safari">
                        <div class="feature">
                                <h3 class="feature-title">{lang key='store.ssl.shared.ev.visualVerification'}</h3>
                                <p class="feature-desc">{lang key='store.ssl.shared.ev.visualVerificationDescription'}</p>
                            </div>
                        </div>
                {elseif $type == 'ov'}
                    <div class="col-sm-4 m-safari">
                        <div class="feature">
                            <h3 class="feature-title">{lang key='store.ssl.shared.ov.ov'}</h3>
                            <p class="feature-desc">{lang key='store.ssl.shared.ov.ovDescription'}</p>
                        </div>
                    </div>
                {else}
                    <div class="col-sm-4 m-safari">
                        <div class="feature">
                            <h3 class="feature-title">{lang key='store.ssl.shared.delivery'}</h3>
                            <p class="feature-desc">{lang key='store.ssl.shared.deliveryDescription'}</p>
                        </div>
                    </div>
                {/if}
                <div class="col-sm-4 m-safari">
                    <div class="feature">
                        <h3 class="feature-title">{lang key='store.ssl.shared.siteSeal'}</h3>
                        <p class="feature-desc">{lang key='store.ssl.shared.siteSealDescription'}</p>
                    </div>
                </div>
                {if $type == 'ev'}
                    <div class="col-sm-4 m-safari">
                        <div class="feature">
                            <h3 class="feature-title">{lang key='store.ssl.shared.ev.warranty'}</h3>
                            <p class="feature-desc">{lang key='store.ssl.shared.ev.warrantyDescription'}</p>
                        </div>
                    </div>
                {elseif $type == 'ov'}
                    <div class="col-sm-4 m-safari">
                        <div class="feature">
                            <h3 class="feature-title">{lang key='store.ssl.shared.ov.warranty'}</h3>
                            <p class="feature-desc">{lang key='store.ssl.shared.ov.warrantyDescription'}</p>
                        </div>
                    </div>
                {else}
                    <div class="col-sm-4">
                        <div class="feature">
                            <h3 class="feature-title">{lang key='store.ssl.shared.googleRanking'}</h3>
                            <p class="feature-desc">{lang key='store.ssl.shared.googleRankingDescription'}</p>
                        </div>
                    </div>
                {/if}
            </div>
        </div>
    </div>
</div>
<div class="site-section">
    <div class="container">
        <h2 class="section-title text-center">{lang key='store.ssl.shared.features'}</h2>
        <div class="section-content">
            <div class="row row-eq-height-xs row-features">
                <div class="col-md-3 col-sm-6 m-safari">
                    <div class="feature feature-xs-left">
                        <div class="feature-icon">
                            {if file_exists("templates/$template/assets/svg-icon/encryp-sensitive-data.tpl")}
                                {include file="$template/assets/svg-icon/encryp-sensitive-data.tpl"}
                           {/if}
                        </div>
                        <h4 class="feature-title">{lang key='store.ssl.shared.encryptData'}</h4>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 m-safari">
                    <div class="feature feature-xs-left">
                        <div class="feature-icon">
                            {if file_exists("templates/$template/assets/svg-icon/secure-online-transactions.tpl")}
                                {include file="$template/assets/svg-icon/secure-online-transactions.tpl"}
                           {/if}
                        </div>
                        <h4 class="feature-title">{lang key='store.ssl.shared.secureTransactions'}</h4>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 m-safari">
                    <div class="feature feature-xs-left">
                        <div class="feature-icon">
                            {if file_exists("templates/$template/assets/svg-icon/prove-legitimacy.tpl")}
                                {include file="$template/assets/svg-icon/prove-legitimacy.tpl"}
                            {/if}
                        </div>
                        <h4 class="feature-title">{lang key='store.ssl.shared.legitimacy'}</h4>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 m-safari">
                    <div class="feature feature-xs-left">
                        <div class="feature-icon">
                            {if file_exists("templates/$template/assets/svg-icon/strongest-fastest-SSL.tpl")}
                                {include file="$template/assets/svg-icon/strongest-fastest-SSL.tpl"}
                            {/if}
                        </div>
                        <h4 class="feature-title">{lang key='store.ssl.shared.fastestSsl'}</h4>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 m-safari">
                    <div class="feature feature-xs-left">
                        <div class="feature-icon">
                            {if file_exists("templates/$template/assets/svg-icon/99.9-browser-compatibility.tpl")}
                                {include file="$template/assets/svg-icon/99.9-browser-compatibility.tpl"}
                            {/if}
                        </div>
                        <h4 class="feature-title">{lang key='store.ssl.shared.browserCompatability'}</h4>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 m-safari">
                    <div class="feature feature-xs-left">
                        <div class="feature-icon">
                            {if file_exists("templates/$template/assets/svg-icon/increase-SEO-rank.tpl")}
                                {include file="$template/assets/svg-icon/increase-SEO-rank.tpl"}
                            {/if}
                        </div>
                        <h4 class="feature-title">{lang key='store.ssl.shared.seoRank'}</h4>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 m-safari">
                    <div class="feature feature-xs-left">
                        {if $type == 'ev'}
                            <div class="feature-icon">
                                {if file_exists("templates/$template/assets/svg-icon/issued-in-1-2-days.tpl")}
                                    {include file="$template/assets/svg-icon/issued-in-1-2-days.tpl"}
                                {/if}
                            </div>
                            <h4 class="feature-title">{lang key='store.ssl.shared.ev.issuance'}</h4>
                        {elseif $type == 'ov'}
                            <div class="feature-icon">
                                {if file_exists("templates/$template/assets/svg-icon/issued-in-1-2-days.tpl")}
                                    {include file="$template/assets/svg-icon/issued-in-1-2-days.tpl"}
                                {/if}
                            </div>
                            <h4 class="feature-title">{lang key='store.ssl.shared.ov.issuance'}</h4>
                        {else}
                        <div class="feature-icon">
                            {if file_exists("templates/$template/assets/svg-icon/instant-issuance.tpl")}
                                {include file="$template/assets/svg-icon/instant-issuance.tpl"}
                            {/if}
                        </div>
                            <h4 class="feature-title">{lang key='store.ssl.shared.issuance'}</h4>
                        {/if}
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 m-safari">
                    <div class="feature feature-xs-left">
                        <div class="feature-icon">
                            {if file_exists("templates/$template/assets/svg-icon/free-reissues.tpl")}
                                {include file="$template/assets/svg-icon/free-reissues.tpl"}
                            {/if}
                        </div>
                        <h4 class="feature-title">{lang key='store.ssl.shared.freeReissues'}</h4>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
