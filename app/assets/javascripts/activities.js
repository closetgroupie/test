//= require underscore-min
// require underscore
// require underscore-mixins
//= require json2
//= require backbone-min
// require backbone-support
//
//= require_self
//
//= require_directory ../templates/activities
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
        new ClosetGroupie.Routers.Activities({ activities: data.activities });
        Backbone.history.start();
    }
};
