jQuery(document).ready(function($) {
    var search_field = $('#admin_item_owner');

    var delay = (function() {
        var timer = 0;
        return function(callback, ms) {
            clearTimeout(timer);
            timer = setTimeout(callback, ms);
        };
    })();

    var search_for_user = function () {
        $.get('/users/find_by_email', {'email': search_field.val()}, function(data) {
            if (data.response == "SUCCESS") {
                search_field.removeClass('failure loading').addClass('success');
                $('input[name=user_id_override]').val(data.user.id);
            } else {
                search_field.removeClass('success loading').addClass('failure');
            }
        }, 'json');
    };

    search_field.bind('keydown', function(e) {
        if (e.keyCode >= 9 && e.keyCode <= 45) {
            return;
        }
        search_field.removeClass('success failure').addClass('loading');
        delay(search_for_user, 750);
    });
});
