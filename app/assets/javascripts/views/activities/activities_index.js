ClosetGroupie.Views.ActivitiesIndex = Backbone.View.extend({
    template: JST['activities/activities_index'],
    id: 'feed-wrapper',
    
    initialize: function(options) {
        _.bindAll(this, 'renderActivity', 'waypointReached', 'addWaypoint', 'removeWaypoint', 'addActivity', 'showRefresh', 'hideRefresh', 'triggerRefresh');
        this.collection = new ClosetGroupie.Collections.Activities();
        this.collection.reset(options.collection);
        this.feed = new ClosetGroupie.Collections.ActivityFeed({ collection: this.collection });
        this.updates = new ClosetGroupie.Collections.ActivityUpdates({ collection: this.collection });
        // Handle a fetch, may need to bind to something else to determine between scroll and "refresh"
        this.feed.on('reset', this.addActivity);
        this.updates.on('activity', this.showRefresh);
        this.updates.on('refreshed', this.addActivity);
        this._fetching = false;
    },

    events: {
        "click #refresh-btn": "triggerRefresh"
    },

    render: function() {
        this.renderLayout();
        this.renderActivities();
        this.addWaypoint();
        // Trigger masonry
        this.initializeMasonry();
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
        this.$el.find('#activity_list').append(view.render().el);
    },

    triggerRefresh: function() {
        this.hideRefresh();
        this.updates.trigger('refresh');
    },

    showRefresh: function() {
        this.$el.find('#refresh').removeClass('inactive')
                .find('#refresh-btn').html('refresh activity <span>' + this.updates.length + '</span>');
    },

    hideRefresh: function() {
        this.$el.find('#refresh').addClass('inactive')
                .find('#refresh-btn').text('refresh activity');
    },

    addActivity: function(collection) {
        var $activity = this.$el.find('#activity_list'),
            activities = "",
            self = this;
        collection.each(function(activity) {
            var view = new ClosetGroupie.Views.Activity({ model: activity });
            // $activity.append(view.render().el);
            // TODO: Replace this with something Firefox friendly
            activities += view.render().el.outerHTML;
        });
        var $activities = $(activities);
        // this.$el.find('#refresh').after($activity);
        $activities.imagesLoaded(function() {
            // TODO: This shouldn't be done this way, but oh well...
            if (collection.is_prepended) {
                // Prepend the activities on to the feed
                $activity.prepend($activities).masonry('reload');
                // Set the ActivityUpdates collection to empty
                collection.reset([], {silent: true});
            } else {
                $activity.append($activities).masonry('appended', $activities, false, function() {
                    self._fetching = false;
                    self.addWaypoint();
                });
            }
        });
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
        if (!this._fetching) {
            // Fetch content
            this.feed.fetchMore();
            this._fetching = true;
        }
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
