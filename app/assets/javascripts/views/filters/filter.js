ClosetGroupie.Views.Filter = Backbone.View.extend({
    className: 'active-filter',
    tagName: 'li',
    template: JST['filters/filter'],

    events: {
        "click a" : "removeFilter",
    },

    initialize: function() {
        this.$el.attr('id', this.model.cid);
        if (!(this.model.has("sizes"))) {
            this.model.on("change:active", this.removeFilter, this);
        }
    },

    render: function() {
        this.$el.html(this.template({ model: this.model }));
        return this;
    },

    removeFilter: function(event) {
        event.preventDefault();
        this.model.collection.remove(this.model);
    }
});
