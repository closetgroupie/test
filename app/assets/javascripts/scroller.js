var InfiniteScroller = (function () {
    var did_scroll = false,
        all_content_loaded = false,
        fetching_content = false,
        el = null;

    var init = function (element) {
        el = element;

        $(window).scroll(function(e) {
            did_scroll = true;
        });
        
        setInterval(function() {
            if (did_scroll) {
                load_more_activity();
                did_scroll = false;
            }
        }, 250);
    };

    var load_more_activity = function () {
        var last_activity = $(el).children().last(),
            last_id = last_activity.data('aid');

        // If we are already fetching stuff, don't try to load more again.
        if (fetching_content) {
            return;
        }

        if (!all_content_loaded && $(window).scrollTop() >= last_activity.offset().top - 600) {
            fetching_content = true;
            $('#loading').spin();
            $.get('/activity/previous/' + last_id, function(data) {
                var $activities = $(data);

                if ($activities.length == 0) {
                    $('#loading').spin(false).hide();
                    all_content_loaded = true;
                    return;
                }

                $activities.imagesLoaded(function() {
                    $(el).append($activities).masonry('appended', $activities, false, function() {
                        fetching_content = false;
                        $('#loading').spin(false);
                    });
                });
            });
        }
    };

    return {
        init: init
    };
})();