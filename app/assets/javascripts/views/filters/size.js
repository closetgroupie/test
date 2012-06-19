ClosetGroupie.Views.Size = Backbone.View.extend({
    tagName: 'li',
    template: JST['filters/size_row'],

    events: {
        "click a": "sizeSelected",
    },

    initialize: function() {
        _.bindAll(this, "render");
        this.model = this.options.model;
        this.model.on('change:active', this.render);
        this.$el.addClass(this.options.cssClass);
    },

    render: function() {
        this.$el.html(this.template({ model: this.model }));
        (this.model.isActive()) ? this.$el.addClass('active') : this.$el.removeClass('active');
        return this;
    },

    sizeSelected: function(event) {
        event.preventDefault();
        this.model.set({ 'active': !this.model.get('active') });
        // TODO: Propagate up
    }
});
