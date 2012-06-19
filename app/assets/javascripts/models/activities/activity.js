ClosetGroupie.Models.Activity = Backbone.Model.extend({
    comments_url: function() {
        return this.get("entity_url") + "#comments";
    }
});
