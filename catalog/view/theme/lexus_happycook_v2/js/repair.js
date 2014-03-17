function gotoStep(step)
{
    switch (step) {
        case 1:
            document.location = '/index.php?route=repair/repair';
            break;
        case 2:
            document.location = '/index.php?route=repair/repair/step_two';
            break;
        case 3:
            document.location = '/index.php?route=repair/repair/step_three';
            break;
        case 4:
            document.location = '/index.php?route=repair/repair/step_four';
            break;
        default:
            document.location = '/index.php?route=repair/repair';
    }
}

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


    /*
     * Step 2
     */

    // Selection color
    $('[id^="color-item-"]').on('click',function(){
        $('[id^="color-item-"]')
            .removeClass('product-trigger-selected')
            .css({ boxShadow:'none' });
        $(this)
            .addClass('product-trigger-selected')
            .css({ boxShadow:'0 0 4px 4px #333' });
    });

    // Next Step
    $('#goto-step-3').on('click', function(){
        var id = $('.product-trigger-selected').attr('id');
        if ( !id ) {
            alert('Please, select color of your device');
        } else {
            id = id.split('-')[2];
            $.ajax({
                url     : '/index.php?route=repair/repair/ajax',
                type    : 'POST',
                data    : 'act=color&color=' + id,
                dataType: 'json',
                success : function (response) {
                    if ( response.error !== 0 ) {
                        alert(response.error)
                    } else {
                        document.location = '/index.php?route=repair/repair/step_three';
                    }
                }
            });
        }
    });

    /*
     * Step 3
     */

    // Next Step
    $('#goto-step-4').on('click', function(){
        var ids = new Array();
        $('input[type="checkbox"]:checked').each(function(a,b){
            ids.push( $(b).attr('id').split('-')[2] );
        });

        if ( !ids ) {
            alert('Please, select issues of your device');
        } else {
            $.ajax({
                url     : '/index.php?route=repair/repair/ajax',
                type    : 'POST',
                data    : 'act=issue&issue=' + ids.join(','),
                dataType: 'json',
                success : function (response) {
                    if ( response.error !== 0 ) {
                        alert(response.error)
                    } else {
                        document.location = '/index.php?route=repair/repair/step_four';
                    }
                }
            });
        }
    });


    /*
     * Step 4
     */

    // Next Step
    $('#goto-step-5').on('click', function(){
        var id = $('input[type="radio"]:checked').attr('id');
        console.log(id);
        if ( !id ) {
            alert('Please, select the service for repair your device');
        } else {
            $.ajax({
                url     : '/index.php?route=repair/repair/ajax',
                type    : 'POST',
                data    : 'act=service&service=' + id,
                dataType: 'json',
                success : function (response) {
                    if ( response.error !== 0 ) {
                        alert(response.error)
                    } else {
                        document.location = '/index.php?route=repair/repair/step_five';
                    }
                }
            });
        }
    });
})(jQuery);