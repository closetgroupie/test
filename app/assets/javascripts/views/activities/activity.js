ClosetGroupie.Views.Activity = Backbone.View.extend({
    template: JST['activities/activity'],
    tagName: 'li',
    className: 'activity_item',

    initialize: function (options) {
        this.model = options.model;
        this.$el.attr('data-aid', this.model.get('id'));
    },

    render: function() {
        this.$el.append(this.template({ activity: this.model }));
        return this;
    }
});
