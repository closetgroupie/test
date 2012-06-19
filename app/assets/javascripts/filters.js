//= require underscore-min
//= require underscore-mixins
//= require json2
//= require backbone-min
//= require backbone-support
//
//= require_self
//
//= require_directory ../templates/filters
//= require_directory ./models/filters
//= require_directory ./collections/filters
//= require_directory ./views/filters
//= require ./routers/filters
window.ClosetGroupie = {
    Models: {},
    Collections: {},
    Routers: {},
    Views: {},
    initialize: function(data) {
        new ClosetGroupie.Routers.Filters({ categories: data.categories });
        Backbone.history.start();
    }
};
