$(function(){
    var $container = $('.item-list:first'),
        start_infinitescroll = function(opts) {
            $('nav.pagination').hide();
            $('#loading').show();
            beginAjax(opts);
        },
        stop_infinitescroll = function() {
            $('#loading').fadeOut();
        };

    $('#loading').spin().hide();

    $container.infinitescroll({
        navSelector  : 'nav.pagination',    // selector for the paged navigation 
        nextSelector : 'nav.pagination a[rel="next"]:first',  // selector for the NEXT link (to page 2)
        itemSelector : '.item',     // selector for all items you'll retrieve
        errorCallback: stop_infinitescroll,
        bufferPx     : 200,
        loading: {
            msgText: "",
            img: "",
            finishedMsg: '',
            start: start_infinitescroll,
            selector: '#loading'
        }
    });
});
