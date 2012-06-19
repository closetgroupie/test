ClosetGroupie.Views.Sizes = Support.CompositeView.extend({
    template: JST["filters/sizes"],
    className: "filterset-wrapper",

    initialize: function() {
        this.category = this.options.category;
        this.category.sizes = this.options.collection;
        this.category.sizes.reset(this.category.get("sizes"));
    },

    render: function() {
        this.renderLayout();
        this.renderSizes();
        return this;
    },

    renderLayout: function() {
        this.$el.html(this.template({ category: this.category }));
    },

    renderSizes: function() {
        var classes = _.cycle(["first", "second", "third", "fourth", "last"]);
        var self = this;
        this.category.sizes.each(function(size) {
            var li = new ClosetGroupie.Views.Size({ model: size, cssClass: classes() });
            self.renderChild(li);
            self.$('#item-sizes').append(li.el);
        });
    },
});
