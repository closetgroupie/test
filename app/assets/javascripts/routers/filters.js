ClosetGroupie.Routers.Filters = Support.SwappingRouter.extend({
    initialize: function (options) {
        this.el = $('#content');
        this.nav = $('#filter');
        this.items = $('#item-listing');
        this.categories = options.categories;
        this.collection = options.collection;
        this.renderFilterToolbar();
    },

    routes : {
        "" : "index",
    },

    renderFilterToolbar: function() {
        // TODO: Active stuff needs to be here too
        var toolbar = new ClosetGroupie.Views.FilterToolbar({ categories: this.categories });
        this.nav.empty().append(toolbar.render().el);
    },

    index: function() {
        var view = ClosetGroupie.Views.Shop({ collection: this.collection });
        $(this.el).empty().append(view.render().el);
    },

    // showCategory: function(segment_slug) {
    //     var selector = '.' + segment_slug;
    //     // Show only items in the segment
    //     this.items.children().not(selector).hide();
    //     this.items.children(selector).show();
    //     // Scope infinitescroll by the segment only
    //     // var view = new ClosetGroupie.Views.SegmentShow({ categories: this.categories });
    //     // this.swap(view);
    // },
});
