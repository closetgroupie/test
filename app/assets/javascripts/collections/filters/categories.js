ClosetGroupie.Collections.Categories = Backbone.Collection.extend({
    model: ClosetGroupie.Models.Category,
    url: "/",

    findById: function(id) {
        return this.find(function(category) {
            return category.get('id') == id
        });
    }
});
