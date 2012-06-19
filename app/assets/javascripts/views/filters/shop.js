ClosetGroupie.Views.Shop = Support.CompositeView.extend({
    initialize: function() {
        this.toolbar = new ClosetGroupie.Views.FilterToolbar({ collection: options.categories });
        this.toolbar.on("filtered", this.filterCollection);
        this.collectionToRender = this.collection;
        this.render();
    },

    render: function() {
        this.toolbar.render();
        this.renderItems();
        return this;
    },

    renderItems: function() {
        var self = this;
        this.$('#item-listing').empty();
        this.collectionToRender.each(function(item) {
            var li = new ClosetGroupie.Views.Item({ model: item });
            self.renderChild(li);
            self.$('#item-listing').append(li.el);
        });
    },

    filterCollection: function(filter) {
        // filter is an instance of ClosetGroupie.Models.Filter, either category or size
        this.collectionToRender = this.collection.filterBy(filter);
    },
});
