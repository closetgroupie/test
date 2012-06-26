ClosetGroupie.Models.Activity = Backbone.Model.extend({
    entity_comments_url: function() {
        return this.get("entity_url") + "#comments";
    },

    entity_favorite_url: function() {
        return this.get('entity_url') + "/favorite";
    },

    entity_full_url: function() {
        return this.escaped_full_url(this.get('entity_url'));
    },

    escaped_hero_image: function() {
        return this.escaped_full_url(this.get('hero_image'));
    },

    escaped_full_url: function(url) {
        return this.escape_url("https://closetgroupie.com" + url);
    },

    escape_url: function(url) {
        return escape(url);
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
