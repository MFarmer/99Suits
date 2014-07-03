window.Suits.Routers.AppRouter = Backbone.Router.extend({

  routes: {
    "": "itemsIndex",
    "trade": "itemsTrade",
    "sale": "itemsSale",
    "items/new": "itemsNew",
    "items/:id": "itemShow"
  },

  itemsIndex: function() {

    var view = new Suits.Views.ItemsIndex({
      collection: Suits.Collections.items
    });

    Suits.Collections.items.fetch();
    $(".backbone-content").html(view.render().$el);
  },

  itemsTrade: function() {
    var view = new Suits.Views.ItemsTrade({
      collection: Suits.Collections.items_trade
    });

    Suits.Collections.items_trade.fetch();
    $(".backbone-content").html(view.render().$el);
  },

  itemsSale: function() {
    var view = new Suits.Views.ItemsSale({
      collection: Suits.Collections.items_sale
    });

    Suits.Collections.items_sale.fetch();
    $(".backbone-content").html(view.render().$el);
  },

  itemsNew: function() {
    var view = new Suits.Views.ItemsNew();
    $(".backbone-content").html(view.render().$el);
  },

  itemShow: function(id) {

    var item = Suits.Collections.items.getOrFetch(id);
    item.comments().fetch();

    var view = new Suits.Views.ItemShow({
      model: item
    });

    $(".backbone-content").html(view.render().$el);
  }

});