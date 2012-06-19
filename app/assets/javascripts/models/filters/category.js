ClosetGroupie.Models.Category = Backbone.Model.extend({
    hasSizes: function() {
        return (this.get("sizes") && this.get("sizes").length > 0);
    }
});
