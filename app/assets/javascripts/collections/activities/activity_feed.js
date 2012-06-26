ClosetGroupie.Collections.ActivityFeed = Backbone.Collection.extend({
    model: ClosetGroupie.Models.Activity,
    url: "/activities",
    initialize: function(options) {
        _.bindAll(this, 'processLatest', 'processNew', 'fetchMore');
        this.collection = options.collection;
        this.bind('reset', this.processLatest);
        this.is_prepended = false;
    },

    sinceOldest: function() {
        var oldest = this.collection.min(function(activity) {
            return activity.timestamp();
        });
        return oldest.timestamp();
    },

    fetchMore: function() {
        this.fetch({ data: { before: this.sinceOldest() } });
    },

    oldest: function() {
        this.fetch({ data: { before: this.sinceOldest() } });
    },

    processLatest: function() {
        this.each(this.processNew);
    },

    processNew: function(activity) {
        var existing = this.collection.get(activity.id);
        if (existing) {
            existing.set(activity.attributes);
        } else {
            this.collection.add(activity);
        }
    }
});
