ClosetGroupie.Views.CategorySizePicker = Backbone.View.extend({
    template: JST["category_size_picker"],
    id: "button",

    initialize: function() {
        this.categories = this.options.categories;
    },

    events: {
        "click": "toggleFilterMenu"
    },

    render: function() {

    },

    toggleFilterMenu: function() {

    },
});
