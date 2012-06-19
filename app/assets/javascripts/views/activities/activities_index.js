ClosetGroupie.Views.ActivitiesIndex = Backbone.View.extend({
    template: JST['activities/activities_index'],
    id: 'feed-wrapper',
    
    initialize: function(options) {
        _.bindAll(this, 'renderActivity');
        this.collection = new ClosetGroupie.Collections.Activities();
        this.collection.reset(options.collection);
        this.changes = new ClosetGroupie.Collections.ActivityChanges({ collection: this.collection });
    },

    render: function() {
        this.renderLayout();
        this.renderActivities();
        return this;
    },

    renderLayout: function() {
        this.$el.append(this.template());
    },

    renderActivities: function() {
        this.collection.each(this.renderActivity);
    },

    renderActivity: function(model) {
        var view = new ClosetGroupie.Views.Activity({ model: model });
        // TODO: Signal new items to be prepended, not appended
        this.$el.find('#activity_list').append(view.render().el);
        // model.bind('remove', view.remove/leave);
    }
});
