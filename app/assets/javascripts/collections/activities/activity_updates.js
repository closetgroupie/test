ClosetGroupie.Collections.ActivityUpdates = Backbone.Collection.extend({
    model: ClosetGroupie.Models.Activity,
    url: "/activities",
    initialize: function(options) {
        _.bindAll(this, 'latest', 'processLatest', 'processNew', 'sinceLatest', 'refresh', 'checkForNew');
        this.collection = options.collection;
        this._previous_length = 0;
        this.bind('reset', this.checkForNew);
        this.bind('refresh', this.refresh);
        setInterval(this.latest, 30*1000);
        this.is_prepended = true;
    },

    checkForNew: function() {
        if (this.length > this._previous_length) {
            this.trigger('activity');
            this._previous_length = this.length;
        }
    },

    latest: function() {
        this.fetch({ data: { since: this.sinceLatest() } });
    },

    sinceLatest: function() {
        // TODO: Add "caching" here that circumvents this iteration if there
        // have been no updates since last fetch
        var latest = this.collection.max(function(activity) {
            return activity.timestamp();
        });
        return latest.timestamp();
    },

    refresh: function() {
        this.processLatest();
        this.trigger('refreshed', this);
        this._previous_length = 0;
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
