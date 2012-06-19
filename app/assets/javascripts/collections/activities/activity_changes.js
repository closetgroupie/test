ClosetGroupie.Collections.ActivityChanges = Backbone.Collection.extend({
    model: ClosetGroupie.Models.Activity,
    url: "/activities",
    initialize: function(options) {
        _.bindAll(this, 'latest', 'processLatest', 'processNew', 'sinceLatest');
        this.collection = options.collection;
        this.bind('reset', this.processLatest);
        // TODO: This should be inside the refresh button view, it should trigger this
        setInterval(this.latest, 30*1000);
    },

    sinceLatest: function() {
        // TODO: Add "caching" here that circumvents this iteration if there
        // have been no updates since last fetch
        return this.collection.max(function(activity) {
            return activity.get('updated_at');
        });
    },

    sinceOldest: function() {
        return this.collection.min(function(activity) {
            return activity.get('updated_at');
        });
    },

    latest: function() {
        this.fetch({ data: { since: this.sinceLatest() } });
    },

    oldest: function() {
        this.fetch({ data: { since: this.sinceOldest() } });
    },

    processLatest: function() {
        this.each(this.processNew);
    },

    processNew: function(activity) {
        var existing = this.collection.get(activity.id);
        if (existing) {
            existing.set(activity.attributes);
        } else {
            this.collection.unshift(activity);
        }
    }
});
