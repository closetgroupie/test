ClosetGroupie.Routers.Activities = Backbone.Router.extend({
    initialize: function (options) {
        this.el = $('#content');
        this.collection = options.activities;
        ClosetGroupie.currentUser = new ClosetGroupie.Models.User(options.user);
    },

    routes: {
        "":     "index",
        "_=_": "index",
    },

    index: function() {
        var view = new ClosetGroupie.Views.ActivitiesIndex({ collection: this.collection });
        $(this.el).empty().append(view.render().el);
        view.addWaypoint();
    }
});
