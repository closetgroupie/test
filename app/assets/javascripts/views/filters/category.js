ClosetGroupie.Views.Category = Backbone.View.extend({
    template: JST["filters/category"],
    tagName: "li",
    className: "filter",

    events: {
        "click a": "categorySelected"
    },

    render: function() {
        this.$el.html(this.template({ slug: this.slug(), model: this.model }));
        return this;
    },

    slug: function() {
        return window.location.pathname + "/" + this.model.get('slug');
    },

    categorySelected: function(event) {
        event.preventDefault();
        this.model.set({ active: true });
    }
});
