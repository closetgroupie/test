ClosetGroupie.Views.Flyout = Support.CompositeView.extend({
    template: JST['filters/flyout'],
    id: 'filter-flyout',
    className: 'filter-menu popup',

    initialize: function() {
        this.categories = this.options.categories;
    },

    render: function() {
        this.renderLayout();
        this.renderCategories();
        // this.$el.append(this.template({ categories: this.categories }));
        return this;
    },

    renderLayout: function() {
        this.$el.html(this.template())
    },

    renderCategories: function() {
    },

    // CategoryRow views call this when they are clicked on
    categorySelected: function(model) {
        if (model.get("sizes") && model.get("sizes").length) {
            var sizes = new ClosetGroupie.Views.Sizes({ category: model });
            this.$el.find('#filterset-sizes').empty().append(sizes.render().el);
            this.$el.find('#filterset-categories').hide();
            this.$el.find('#filterset-sizes').show();
        }
        // this.$el.find('.filterset').hide();
        // alert(model.get('name'));
    },

    categoryUnselected: function(model) {

    }
});
