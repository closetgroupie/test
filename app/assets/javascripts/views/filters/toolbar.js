ClosetGroupie.Views.FilterToolbar = Support.CompositeView.extend({
    id: "filter-inner",

    events: {
        "click #button": "toggleFlyout",
    },

    initialize: function (options) {
        _.bindAll(this, "filterChanged");
        this.categories = new ClosetGroupie.Collections.Categories();
        this.filters    = new ClosetGroupie.Collections.Filters();
        this.sizes      = new ClosetGroupie.Collections.Sizes();
        this.categories.reset(options.categories);
        this.categories.on("change:active", this.filterChanged);
        this.sizes.on("change:active", this.filterChanged);
        this.filters.on("remove", this.filterRemoved);
    },

    render: function() {
        this.renderLayout();
        this.renderFilters();
        this.renderFlyout();
        return this;
    },

    renderLayout: function() {
        this.$el.append(JST['filters/toolbar']());
    },

    renderFlyout: function() {
        var self = this;
        this.categories.each(function(category) {
            var li = new ClosetGroupie.Views.Category({ model: category });
            self.renderChild(li);
            self.$('#item-categories').append(li.el);
        });
    },

    renderFilters: function() {
        var filters = new ClosetGroupie.Views.Filters({ collection: this.filters });
        this.$el.find('#button').after(filters.render().el);
    },

    toggleFlyout: function() {
        this.$el.find('#filter-flyout').toggle();
        return false;
    },

    filterChanged: function(model, truthy_falsy) {
        if (truthy_falsy) {
            var filter = new ClosetGroupie.Models.Filter({
                pcid: model.cid,
                name: model.get("name"),
                isCategory: model.has("sizes")
            });
            filter.parent = model;
            this.filters.add(filter);

            // Trigger model specific behavior
            (model.has("sizes")) ? this.categoryAdded(model) : this.sizeAdded(model);
        } else {
            (model.has("sizes")) ? this.categoryRemoved(model) : this.sizeRemoved(model);
        }
    },

    filterRemoved: function(model) {
        console.log("filterRemoved");
        console.dir(arguments);
    },

    categoryAdded: function(model) {
        if (model.hasSizes()) {
            var sizes = new ClosetGroupie.Views.Sizes({ category: model, collection: this.sizes });
            this.$el.find('#filterset-sizes').empty().append(sizes.render().el);
            this.$el.find('#filterset-categories').hide();
            this.$el.find('#filterset-sizes').show();
        }
    },

    categoryRemoved: function(model) {
        if (model.hasSizes())
        {
            this.$el.find('#filterset-sizes').empty().hide();
            this.$el.find('#filterset-categories').show();
        }
    },

    sizeAdded: function(model) {
        // TODO: Filter results further by size?
    },

    sizeRemoved: function(model) {
        var filter = this.filters.findByCid(model.cid);
        this.filters.remove(filter);
    }
});
