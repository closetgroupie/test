ClosetGroupie.Models.Size = Backbone.Model.extend({
    slug: function() {
        return this.get('name').toLowerCase();
    },

    isActive: function() {
        return this.get('active');
    }
});
