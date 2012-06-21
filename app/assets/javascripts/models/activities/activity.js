ClosetGroupie.Models.Activity = Backbone.Model.extend({
    comments_url: function() {
        return this.get("entity_url") + "#comments";
    },

    timestamp: function() {
        if (this._timestamp) {
            return this._timestamp;
        } else {
            this._timestamp = +new Date(this.get('updated_at')) / 1000;
            return this._timestamp;
        }
    }
});
