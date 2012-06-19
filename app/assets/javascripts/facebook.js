window.fbAsyncInit = function () {
    FB.init({
        appId      : '195906460469934', // App ID
        cookie     : true, // enable cookies to allow the server to access the session
        xfbml      : false  // parse XFBML
    });

    var body = document.getElementsByTagName('body')[0];

    if (!(body.className.match(/unregistered/g))) {
        FB.Event.subscribe('edge.create', function(response) {
            jQuery.post('/activity/facebook/edge/create', { data: { 'href': response } });
        });

        FB.Event.subscribe('edge.remove', function(response) {
            jQuery.post('/activity/facebook/edge/remove', { data: { 'href': response } });
        });

        FB.Event.subscribe('comment.create', function(response) {
            jQuery.post('/activity/facebook/comment/create', { data: response });
        });

        FB.Event.subscribe('comment.remove', function(response) {
            jQuery.post('/activity/facebook/comment/remove', { data: response });
        });
    }
};
