(function($){
    /*
     * Step 1
     */

    // Filter
    if ( $('#man-selected a').text() ) {
        $('#man-selected-label').text( $('#man-selected a').text() );
    }

    $('[id^="man-item-"]').on('click',function(){
        var cur_id = $(this).attr('id').split('-');

        if ( document.location.href.match(/manufacturer=\d{0,5}/i) ) {
            document.location = document.location.href.replace(/manufacturer=\d{0,5}/i, 'manufacturer=' + cur_id[2]);
        } else if ( document.location.href.match(/\?/i) ) {
            document.location = document.location.href.replace('?', '?manufacturer=' + cur_id[2] + '&');
        } else {
            document.location = '?manufacturer=' + cur_id[2];
        }
    });

    // Product select
    $('.product-trigger')
        .on('click',function(){
            $('.product-trigger')
                .css({ backgroundColor: '#fff' })
                .removeClass('product-trigger-selected')

            $(this)
                .css({ backgroundColor: 'rgb(64, 196, 58)' })
                .addClass('product-trigger-selected');
        });

    // Next step
    $('#goto-step-2').on('click', function(){
        var id = $('.product-trigger-selected').attr('id');
        if ( !id ) {
            alert('Please, select your device');
        } else {
            id = id.split('-')[2];
            $.ajax({
                url     : '/index.php?route=repair/repair/ajax',
                type    : 'POST',
                data    : 'act=device&device=' + id,
                dataType: 'json',
                success : function (response) {
                    if ( response.error !== 0 ) {
                        alert(response.error)
                    } else {
                        document.location = '/index.php?route=repair/repair/step_two';
                    }
                }
            });
        }
    });
})(jQuery);