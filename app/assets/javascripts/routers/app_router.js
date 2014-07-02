window.Suits.Routers.AppRouter = Backbone.Router.extend({

  routes: {
    "": "itemsIndex",
    "items/new": "itemsNew"
  },

  itemsIndex: function() {

    var view = new Suits.Views.ItemsIndex({
      collection: Suits.Collections.items
    });

    Suits.Collections.items.fetch();
    $(".backbone-content").html(view.render().$el);
  },

  itemsNew: function() {
    var view = new Suits.Views.ItemsNew();
    $(".backbone-content").html(view.render().$el);
  }

});