ClosetGroupie.Models.Filter = Backbone.Model.extend({
    isCategory: function() {
        return this.has("sizes");
    }
});
