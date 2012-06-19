ClosetGroupie.Collections.Items = Backbone.Collection.extend({
    model: ClosetGroupie.Models.Item,
    url: function() {
        return '/' + this.segment;
    }
});
