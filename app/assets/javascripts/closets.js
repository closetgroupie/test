//= require jquery.sliderkit.1.9
//= require_self
jQuery(function($) {
    $(".sliderkit").sliderkit({
        auto:false,
        autospeed:3000,
        // panelbtnshover:true,
        circular:true,
        fastchange:false
    });
    
    $('body.closets').delegate('.follow-button', 'hover', function (e) {
        if (e.type == 'mouseenter') {
            $(this).children('.icon').hide().end().children('.action').stop().animate({
                "opacity": "toggle",
                "width": "toggle"
            }, 'linear');
        } else {
            $(this).children('.action').hide().end().children('.icon').stop().animate({
                "opacity": "show"
            }, 'swing');
        }
    });
});