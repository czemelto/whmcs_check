{if isset($RSThemes['pages']['invoice-payment'])}
    {include file=$RSThemes['pages']['invoice-payment']['fullPath']}
{else}
    {if $showRemoteInput}
        <div id="frmRemoteCardProcess" class="text-center" align="center">
            {$remoteInput}
            <iframe name="ccframe" class="auth3d-area" width="90%" height="600" scrolling="auto" src="about:blank"></iframe>
        </div>

        <script language="javascript">
            jQuery("#frmRemoteCardProcess").find("form:first").attr('target', 'ccframe');
            setTimeout("autoSubmitFormByContainer('frmRemoteCardProcess')", 1000);
        </script>
    {else}
        {include file="$template/payment/$cardOrBank/validate.tpl"}
        <form id="frmPayment" method="post" action="{$submitLocation}" class="main-content w-100" role="form">
            <input type="hidden" name="invoiceid" value="{$invoiceid}" />
            <div class="order-content">
                {if $errormessage}
                    {include file="$template/includes/alert.tpl" type="error" errorshtml=$errormessage}
                {/if}
                <div class="alert alert-danger text-center gateway-errors hidden"></div>
                <div class="section">
                    <div class="section-header">
                        <h3>{$LANG.paymentmethod}</h3>
                    </div>
                    <div class="section__body cc-input-container">
                        <div class="panel panel-form paymethod-info">
                            {include file="$template/payment/$cardOrBank/select.tpl"}
                        </div> 
                    </div>    
                </div>
                {if $servedOverSsl}
                    <div class="section">
                        <div class="alert alert-warning checkout-security-msg">
                            <div class="alert-body">
                                <i class="ls ls-lock"></i>
                                {lang key='creditcardsecuritynotice'}
                            </div>
                        </div>
                    </div> 
                {/if}   
            </div>
            {include file="$template/payment/invoice-summary.tpl"}
        </form>            
        {literal}
            <script type="text/javascript">
                    jQuery(document).ready(function() {
                        jQuery('[data-simple-radio-tab]').on('click', function(){
                            $(this).find('input[type="radio"]').iCheck('check');
                        });
                            $('.cc-item').on('click', function(){
                            $('.cc-item').removeClass('active');
                            $(this).addClass('active');
                            $(this).find('input[type=radio]').iCheck('check');
                        });
                    });

                function mutate(mutations) {
                    mutations.forEach(function(mutation) {
                        if ($(mutation.target).hasClass('hidden')){
                            //$('#submitCheckout').trigger('click');
                        }
                        else{
                            $('#btnSubmit .loader').addClass('hidden');
                            $('#btnSubmit span').removeClass('invisible hidden');
                            $('#btnSubmitMob .loader').addClass('hidden');
                            $('#btnSubmitMob span').removeClass('invisible hidden');
                        }
                    });
                }
                var MutationObserver = window.MutationObserver || window.WebKitMutationObserver || window.MozMutationObserver;
                var target = document.querySelector('.gateway-errors');
                var observer = new MutationObserver( mutate );
                var config = { characterData: false, attributes: false, childList: true, subtree: true };

                observer.observe(target, config);
            </script>
        {/literal}
    {/if}    
{/if}    