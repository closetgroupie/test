ClosetGroupie.Views.ActivitiesIndex = Backbone.View.extend({
    template: JST['activities/activities_index'],
    id: 'feed-wrapper',
    
    initialize: function(options) {
        _.bindAll(this, 'renderActivity', 'waypointReached', 'addWaypoint', 'removeWaypoint', 'addActivity');
        this.collection = new ClosetGroupie.Collections.Activities();
        this.collection.reset(options.collection);
        this.changes = new ClosetGroupie.Collections.ActivityChanges({ collection: this.collection });
        // Handle a fetch, may need to bind to something else to determine between scroll and "refresh"
        this.changes.on('reset', this.addActivity);
    },

    render: function() {
        this.renderLayout();
        this.$list = this.$el.find('#activity_list');
        this.renderActivities();
        this.addWaypoint();
        // Trigger masonry
        // this.initializeMasonry();
        return this;
    },

    renderLayout: function() {
        this.$el.append(this.template());
    },

    renderActivities: function() {
        var $activity = this.$el.find('#activity_list').detach();
        this.collection.each(function(activity) {
            var view = new ClosetGroupie.Views.Activity({ model: activity });
            $activity.append(view.render().el);
        });
        this.$el.find('#refresh').after($activity);
    },

    renderActivity: function(model) {
        var view = new ClosetGroupie.Views.Activity({ model: model });
        // TODO: Signal new items to be prepended, not appended
        this.$el.find('#activity_list').append(view.render().el);
        // model.bind('remove', view.remove/leave);
    },

    addActivity: function() {
        var $activity = this.$el.find('#activity_list').detach();
        this.changes.each(function(activity) {
            var view = new ClosetGroupie.Views.Activity({ model: activity });
            $activity.append(view.render().el);
        });
        this.$el.find('#refresh').after($activity);
        // $(el).append($activities).masonry('appended', $activities, false, function() {
        // Disable spinner, add waypoint, etc.
        // });
        this.addWaypoint();
    },

    addWaypoint: function() {
        this.$el.find('#loading').waypoint({
            handler: this.waypointReached,
            offset: '300%',
            onlyOnScroll: true,
            triggerOnce: true
        });
    },

    loading: function() {
        var opts = {
                lines: 11,
                length: 5,
                width: 4,
                radius: 6,
                color: '#444',
                speed: 1.1
            },
            target = document.getElementById('loading');
        this.spinner = new Spinner(opts).spin(target);
    },

    removeWaypoint: function() {
        $('#loading').waypoint('destroy');
    },

    waypointReached: function(e, direction) {
        this.removeWaypoint();
        // Fetch content
        this.changes.fetchMore();
    },

    initializeMasonry: function() {
        if ($.browser.firefox) {
            this.$el.find('#activity_list').masonry({
                itemSelector: '.activity_item',
                columnWidth: 220,
                isAnimated: !Modernizr.csstransitions
            });
        } else {
            var $activities = this.$el.find('#activity_list');
            $activities.imagesLoaded(function() {
                $activities.masonry({
                    itemSelector: '.activity_item',
                    columnWidth: 220,
                    isAnimated: !Modernizr.csstransitions
                });
            });
        }
    }

});
