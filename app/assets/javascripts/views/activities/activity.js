ClosetGroupie.Views.Activity = Backbone.View.extend({
    template: JST['activities/activity'],
    tagName: 'li',
    className: 'activity_item',

    events: {
        "mouseenter": "mouseEnter",
        "mouseleave": "mouseLeave",
        "click .add_favorite": "favorite",
    },

    initialize: function (options) {
        _.bindAll(this, "mouseEnter", "mouseLeave", "favorite");
        this.model = options.model;
        this.$el.attr('data-aid', this.model.id);
        this._sid = "share-" + this.model.id;
        this._parsed = false;
    },

    favorite: function(event) {
        event.preventDefault();
        var url = this.$('.add_favorite').attr('href'),
            self = this;
        $.post(url, function(data, textStatus) {
            // Perhaps we should add a flash message or something here?
            self.$('.add_favorite').tooltip('hide').replaceWith('<span class="favorite">Favorite</span>');
        });
    },

    mouseEnter: function() {
        this.$el.addClass('hover');
        if (!this._parsed) {
            // if (window.gapi) {
            //     gapi.plusone.go(this._sid);
            // }
            if (window.PinterestPlus) {
                PinterestPlus.pinit(this.$('#'+this._sid)[0]);
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
