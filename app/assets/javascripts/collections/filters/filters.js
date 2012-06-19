ClosetGroupie.Collections.Filters = Backbone.Collection.extend({
    model: ClosetGroupie.Models.Filter,
    url: "/",

    findByCid: function(cid) {
        return this.find(function(filter) {
            return filter.get("pcid") == cid;
        });
    }
});
