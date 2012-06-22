ClosetGroupie.Views.Activity = Backbone.View.extend({
    template: JST['activities/activity'],
    tagName: 'li',
    className: 'activity_item',

    events: {
        "mouseenter": "mouseEnter",
        "mouseleave": "mouseLeave",
    },

    initialize: function (options) {
        _.bindAll(this, "mouseEnter", "mouseLeave");
        this.model = options.model;
        this.$el.attr('data-aid', this.model.id);
        this._sid = "share-" + this.model.id;
        this._parsed = false;
    },

    mouseEnter: function() {
        this.$el.addClass('hover');
        if (!this._parsed) {
            if (window.gapi) {
                gapi.plusone.go(this._sid);
            }
            FB.XFBML.parse(document.getElementById(this._sid));
            this._parsed = true;
        }
    },

    mouseLeave: function() {
        this.$el.removeClass('hover');
    },

    render: function() {
        this.$el.append(this.template({ activity: this.model }));
        return this;
    },
});
