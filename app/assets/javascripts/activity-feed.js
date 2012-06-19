var new_activity = '',
    last_seen = 0;
var ping = function () {
    jQuery.ajax('/activity/feed', {
        type: 'get',
        success: function(data) {
            var $refresh = $('#refresh'),
                // $a = $refresh.children('a'),
                span = $refresh.find('span'),
                count = (span.length > 0) ? parseInt(span.text()) : 0;
            // Check for updates, update counter as necessary
            if (data.count > 0) {
                count = count + data.count;
                add_activity(count);
            }
        },
        error: function() {}, // Handle errors gracefully
        complete: function() {
            // Invoke self again after 30s
            setTimeout('ping()', 30000);
        },
        cache: false,
        dataType: "json"
    });
};

var add_activity = function(count) {
    $.post('/activity/present', function(response) {
        $('#refresh').find('a').html('refresh activity <span>'+count+'</span>').end().removeClass('inactive');
        new_activity += response;
    });
};

jQuery(function($) {    
    // $('body:not(.unregistered)').delegate('.activity_item', 'hover', function(e) {
    //     var $that = $(this), 
    //         aid = $that.data('aid'),
    //         sid = 'sh' + aid; 
    //     if (e.type == 'mouseenter') {
    //         $that.addClass('hover');
    //         if ($that.data('gplus')) {
    //             gapi.plusone.go(sid);
    //         }
    //         if ($that.data('fblike')) {
    //             FB.XFBML.parse(document.getElementById(sid));
    //         }
    //     } else {
    //         $that.removeClass('hover');
    //     }
    // }).delegate('.add_favorite', 'click', function(e) {
    //     var $this = $(this),
    //         $fav_count = $('#nav_favorites_count'),
    //         count = parseInt($fav_count.text()),
    //         item_id = $this.data('item_id'),
    //         old_html = $this.html();  // Save the old html in case we need to revert
    //     // Hide the tooltip so it doesn't stay on
    //     $this.tooltip().hide();
    //     // Replace the tooltip with the favorited version for instant feedback
    //     $this.replaceWith('<span class="favorite">Favorite</span>');
    //     // Make a call to toggle
    //     $.get('/favorites/toggle_favorite/'+item_id, function(response) {
    //         if (response.status === 'SUCCESS') {
    //             if (response.favorited == 1) {
    //                 kmqp(['record', 'added to favorites', {'product id': item_id}]);
    //                 count = count + response.favorited;
    //                 $fav_count.text(count);
    //             } else {
    //                 // Failed to favorite, return back to the way it was
    //                 $this.replaceWith(old_html);
    //             }
    //         } else {
    //             // Unsuccessful, inform the user.
    //             alert(response.message);
    //         }
    //     }, "json");
    //     return false;
    // }).delegate('.follow', 'click', function(e) {
    //     var $this = $(this),
    //         uid = $this.data('user_id');

    //     $.get("/favorites/follow/"+uid, function (response) { 
    //         // if (response.status == "SUCCESS") {
    //         //     if (response.following == 1) {
    //         $this.replaceWith("<span class='following'>Already following</span>");
    //         //     }
    //         //     alert(response.message);
    //         // } else {
    //         alert(response.message);
    //         // }
    //     }, "json");
    //     return false;
    // });
    $(document.body).delegate('.btn-refresh', 'click', function(e) {
        $('#refresh').addClass('inactive').find('a').html('refresh activity');
        $('#activity_list').prepend(new_activity).imagesLoaded(function(){
            $('#activity_list').masonry('reload');
            // Reinitializes FB buttons on the new content
            setTimeout('FB.XFBML.parse()', 300);
            // Reinitializes G+ buttons on the new content
            setTimeout('gapi.plusone.go()', 500);
        });
        new_activity = '';
        return false;
    });

    $('.add_favorite').tooltip({offset: [-15, 0]});
    
    // Unfortunately we have to resort to browser sniffing here, because firefox doesn't        
    // play nice with the imagesLoaded and webkit browsers fail to render correctly when
    // images are not loaded...
    if ($.browser.firefox) {
        $('#activity_list').masonry({
            itemSelector: '.activity_item',
            columnWidth: 220,
            isAnimated: !Modernizr.csstransitions
        });
    } else {
        var $activities = $('#activity_list');
        $activities.imagesLoaded(function() {
            $activities.masonry({
                    itemSelector: '.activity_item',
                    columnWidth: 220,
                    isAnimated: !Modernizr.csstransitions
                 });
        });
    }
    
    // Start fetching content 30 seconds after page loads
    // setTimeout('ping()', 30000);
    InfiniteScroller.init($('#activity_list'));
});
