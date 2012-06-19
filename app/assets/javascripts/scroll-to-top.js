(function($) {
    var WINDOW_CHECK_SCROLL_INTERVAL = 250,
        SCROLL_TIME  = 250,
        has_scrolled = false,
        $back_to_top = $('#back-to-top');

    $(window).bind('scroll', function(event) {
        has_scrolled = true;
    });

    $back_to_top.bind('click', function(event) {
        $("html, body").animate({
            scrollTop: 0
        }, SCROLL_TIME, function() {
            $back_to_top.addClass('off-the-screen');
        });
        event.preventDefault();
    });

    setInterval(function() {
        if (has_scrolled) {
            if ($(window).scrollTop() > 100) {
                $back_to_top.removeClass('off-the-screen');
            } else {
                $back_to_top.addClass('off-the-screen');
            }
            has_scrolled = false;
        }
    }, WINDOW_CHECK_SCROLL_INTERVAL);
})(jQuery)
