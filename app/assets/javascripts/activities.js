//= require underscore-min
// require underscore
// require underscore-mixins
//= require json2
//= require backbone-min
// require backbone-support
//= require jquery.imagesloaded
//= require jquery.masonry
//= require pinterest-plus-html5.min
//= require waypoints.min
//= require spin.min
//= require scroll-to-top
//
//= require_self
//
//= require_directory ../templates/activities
//= require ./models/user
//= require_directory ./models/activities
//= require_directory ./collections/activities
//= require_directory ./views/activities
//= require ./routers/activities
window.ClosetGroupie = {
    Models: {},
    Collections: {},
    Routers: {},
    Views: {},
    initialize: function(data) {
        new ClosetGroupie.Routers.Activities({ activities: data.activities, user: data.user });
        Backbone.history.start();
        jQuery('body').tooltip({
            selector: 'a[rel="tooltip"]'
        });
    }
};
