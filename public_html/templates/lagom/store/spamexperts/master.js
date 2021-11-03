$(document).ready(function() {
    $('#inputDomainChooser').multiselect({
        buttonWidth: '250px',
        dropRight: true,
        nonSelectedText: 'Choose domain(s)'
    });

    $('.site-spamexperts .get-started .choose-product button').click(function(e) {
        var product = $(this).data('product');
        $('.site-spamexperts .get-started .choose-product button').removeClass('active');
        $(this).addClass('active');
        $('.site-spamexperts .get-started .additional-options .option').hide();
        $('.site-spamexperts .get-started .additional-options .options-' + product).show();
        $('.site-spamexperts .get-started .price').hide();
        $('.site-spamexperts .get-started .price-' + product).show();
        $('#productKey').val('spamexperts_' + product);
    });

    $('.site-spamexperts .get-started .additional-options input[type="checkbox"]').on('ifChecked',function(e) {
        $('.site-spamexperts .get-started .additional-options input[type="checkbox"]').not($(this)).prop('checked', false).iCheck('update');
        $('.site-spamexperts .get-started .price').hide();
        $('.site-spamexperts .get-started .price-' + $(this).val()).show();
        $('#productKey').val('spamexperts_' + $(this).val());
    });
    $('.site-spamexperts .get-started .additional-options input[type="checkbox"]').on('ifUnchecked',function(e) {
        var product = $('.site-spamexperts .get-started .choose-product button.active').data('product');
        $('.site-spamexperts .get-started .price').hide();
        $('.site-spamexperts .get-started .price-' + product).show();
        $('#productKey').val('spamexperts_' + product);
    });

    $('.package-learn-more').click(function(e) {
        e.preventDefault();
        $('#howitworks a[href="#' + $(this).data('target') + '"]').tab('show');
        smoothScroll('#howitworks');
    });

    $('.btn-buy').click(function(e) {
        e.preventDefault();
        var target = $(this).data('target'),
            pricing = $('#pricing');
        if (target === 'incomingoutgoingarchiving') {
            if (pricing.find('button[data-product="incoming"]').length) {
                pricing.find('button[data-product="incoming"]').click();
            } else {
                pricing.find('button[data-product="outgoing"]').click();
            }
            var option = $('input[name="options"][value="incomingoutgoingarchiving"]').first();
            if (option.is(':checked')) {   
                option.click();
                option.iCheck('uncheck');
            }
            option.click();
            option.iCheck('check');
        } else {
            pricing.find('button[data-product="' + $(this).data('target') + '"]').click();
        }
        smoothScroll('#pricing');
    });
});
