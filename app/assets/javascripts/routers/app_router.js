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
    this._swapView(view);
  },

  itemsTrade: function() {
    var view = new Suits.Views.ItemsTrade({
      collection: Suits.Collections.items_trade
    });

    Suits.Collections.items_trade.fetch();
    this._swapView(view);
  },

  itemsSale: function() {
    var view = new Suits.Views.ItemsSale({
      collection: Suits.Collections.items_sale
    });

    Suits.Collections.items_sale.fetch();
    this._swapView(view);
  },

  itemsNew: function() {
    var view = new Suits.Views.ItemsNew();
    this._swapView(view);
  },

  itemShow: function(id) {

    var item = Suits.Collections.items.getOrFetch(id);

    var view = new Suits.Views.ItemShow({
      model: item
    });

    this._swapView(view);
  },

  _swapView: function(view) {
    if(this.currentView){
      this.currentView.remove();
    }

    this.currentView = view;

    $(".backbone-content").html(this.currentView.render().$el);
  }

});