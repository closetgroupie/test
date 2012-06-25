ClosetGroupie.Models.User = Backbone.Model.extend({
    is_authenticated: function() {
        return !this.isNew();
    },
});
