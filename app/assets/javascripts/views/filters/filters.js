ClosetGroupie.Views.Filters = Backbone.View.extend({
    tagName: "ul",
    id: "active-filters",

    events: {

    },

    initialize: function() {
        this.collection.on("add", this.filterAdded, this);
        this.collection.on("remove", this.filterRemoved, this);
        this.collection.on("reset", this.reset, this);
    },

    render: function() {
        this.$el.html();
        return this;
    },

    filterAdded: function(model) {
        var view = new ClosetGroupie.Views.Filter({ model: model });
        this.$el.append(view.render().el);
    },

    filterRemoved: function(model) {
        model.parent.set({ active: false });
        if (model.get("isCategory")) {
            model.parent.sizes.reset();
            this.collection.reset();
        } else {
            this.$el.find('#' + model.cid).remove();
        }
    },

    reset: function() {
        // model.parent.sizes.reset();
        this.$el.empty();
    }
});
