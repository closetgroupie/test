ClosetGroupie.Models.Activity = Backbone.Model.extend({
    entity_comments_url: function() {
        return this.get("entity_url") + "#comments";
    },

    entity_favorite_url: function() {
        return this.get('entity_url') + "/favorite";
    },

    entity_full_url: function() {
        return "http://closetgroupie.com" + this.get('entity_url');
    },

    escaped_url: function() {
        return escape(this.entity_full_url());
    },

    is_favorite: function() {
        return this.get('is_favorite');
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
