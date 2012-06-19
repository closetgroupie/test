(function(){
  cg = {}
  cg.models = {};
  cg.views = {};
  cg.collections = {}
  
  cg.models.App = Backbone.Model.extend({
    start: function() {
      this.activeFilters = new cg.collections.Filters();
      this.activeFiltersView = new cg.views.ActiveFiltersView({model: new Backbone.Model(), collection: this.activeFilters, el: $('#active-filters')});
      this.activeFiltersView.render();
      
      
      filterView = new cg.views.FilterPopupView({
        model: new Backbone.Model(),
        collection: this.activeFilters, 
        template: JST['shop/filter-popup'],
        trigger: $('#filter #button')
      });
    }
  });


  cg.views.PopupView = Backbone.View.extend({
    initialize: function(options) {
      this.$trigger = options.trigger;
      this.callback = options.callback;
      this.template = options.template;

      _.bindAll(this);
      $('body').click(this.bodyClick);
    },

    template: 'Give me a template, please.',

    className: 'popup',

    bodyClick: function(e) {
      $target = $(e.target);
      if ($target.is(this.$trigger)) {
        this.toggle(e);
      } else if (!$target.closest(this.$el).length) {
        this.remove();
      }
    },

    toggle: function(e) {
      if (this.$el.is(':visible')) {
        this.remove();
      } else {
        this.render(e);
      }
    },

    render: function(e) {
      this.$el.html(this.template());
      $('body').append(this.$el);
      return this;
    }
  });

  cg.models.Filter = Backbone.Model.extend({
  });

  cg.views.FilterView = Backbone.View.extend({
    initialize: function() {
      _.bindAll(this);
      this.model.bind('remove', this.remove);
    },
    
    template: JST['shop/filter'],

    events: {
      'click a': 'removeFilter'    
    },

    removeFilter: function() {
      this.model.collection.remove(this.model)
    },

    render: function() {
      this.$el.html(this.template(this.model.toJSON()));
      return this;
    }
  });

  cg.collections.Filters = Backbone.Collection.extend({
    model: cg.models.Filter,
    
    filtersets: {
      'dresses and rompers': [1,2,3,4,5],
      'shirts and tops': ['S', 'M', 'L'],
      'sweaters': [26,27,28,30,31,32,33,34,35,36],
      // 'shorts': [26,27,28,30,31,32,33,34,35,36],
      'bottoms': ['XXS','XS', 'S', 'M', 'L', 'XL', 0, 2, 4, 6, 8, 10, 12, 14, 25,26,27,28,30,31,32,33],
      // 'pants': [26,27,28,30,31,32,33,34,35,36],
      // 'jeans': [26,27,28,30,31,32,33,34,35,36],
      // 'skirts': [6,7,8,9,10],
      'maternity': [26,27,28,30,31,32,33,34,35,36],
      'shoes': [6,7,8,9,10],
      'handbags': ['one', 'two', 'three', 'four'], 
      'jewelry': ['one', 'two', 'three', 'four'],
      'accessories': ['one', 'two', 'three', 'four'],
      'other': ['one', 'two', 'three', 'four']
    }

    // filtersets: {
    //   {name: 'Dresses and Rompers', meta: [1,2,3,4,5]},
    //   {name: 'Shirts and Tops', meta: ['S', 'M', 'L']},
    //   {name: 'Sweaters', meta: [26,27,28,30,31,32,33,34,35,36]},
    //   {name: 'Shorts', meta: [26,27,28,30,31,32,33,34,35,36]},
    //   {name: 'Pants', meta: [26,27,28,30,31,32,33,34,35,36]},
    //   {name: 'Jeans', meta: [26,27,28,30,31,32,33,34,35,36]},
    //   {name: 'Skirts',meta: [6,7,8,9,10]},
    //   {name: 'Maternity', meta: [26,27,28,30,31,32,33,34,35,36]},
    //   {name: 'Shoes', meta: [6,7,8,9,10]},
    //   {name: 'Handbags', meta: ['one', 'two', 'three', 'four']},
    //   {name: 'Jewelry', meta: ['one', 'two', 'three', 'four']},
    //   {name: 'Accessories', meta: ['one', 'two', 'three', 'four']},
    //   {name: 'Other', meta: ['one', 'two', 'three', 'four']}
    // }
  });

  cg.views.ActiveFiltersView = Backbone.View.extend({
    initialize: function(options) {
      _.bindAll(this);
      this.collection.bind('add', this.insertFilter);
      this.collection.bind('remove', this.removeFilter);
    },

    model: cg.models.Filter,

    template: JST['shop/active-filters'],

    insertFilter: function(filter) {
      var filterView = new cg.views.FilterView({model: filter});
      this.$el.append(filterView.render().el);
    },

    render: function() {
      var view = this;
      this.$el.html(this.template(this.model.toJSON()));
      
      this.collection.each(function(filter){
        this.insertFilter(filter);
      });
      
      return this;
    }
  });
  
  cg.views.FilterPopupView = cg.views.PopupView.extend({
    initialize: function(options) {
      cg.views.PopupView.prototype.initialize.call(this, options)
      _.bindAll(this);
      this.model.bind('change:filterset', this.filtersetChange)
    },
    
    filtersetTemplate: JST['shop/filterset-meta'],
    
    className: 'filter-menu popup',

    events: {
      'click .filterset li': 'filtersetSelect',
      'click .filterset-meta li': 'filtersetMetaSelect'
    },

    filtersetSelect: function(e) {
      var filterset = $(e.target).data('filterset');
      this.model.set({filterset: filterset})
      this.collection.add({name: filterset});
    },

    filtersetMetaSelect: function(e) {
      var filter = $(e.target).data('filter');
      this.collection.add({name: filter})
    },

    filtersetChange: function(model, filterset) {
      var view = this;
      if (this.$filterset) {
        this.hideFilterset(this.$filterset);
      }
      this.$filterset = $(this.filtersetTemplate({filterset: this.collection.filtersets[filterset]}));
      this.showFilterset(this.$filterset);
    },

    showFilterset: function($filterset) {
      this.$filtersetMeta.append($filterset);
      $ul = $filterset.find('ul');
      var width = $ul.outerWidth();
      var height = $ul.outerHeight();
      // $filterset.css({'width': 0});
      $filterset.css({height: height});
      $filterset.animate({'width': width}, 'fast', function() {
        $ul.animate({'opacity': 1}, 'fast');
      });
      
      $filterset.fadeIn('fast');
    },

    hideFilterset: function($filterset) {
      var view = this;
      $filterset.fadeOut('fast', function() {
        $filterset.remove();
      });
    },

    render: function(e) {
      $target = $(e.target);
      this.$el.html(this.template(this.model.toJSON()));
      this.delegateEvents();
      $('#filter-inner').append(this.el);
      this.$filtersetMeta = this.$('.filterset-meta');
      return this;
    }
  });
  
})()

var app = new cg.models.App();
app.start();
