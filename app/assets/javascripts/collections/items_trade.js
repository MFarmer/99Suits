window.Suits.Collections.ItemsTrade = Backbone.Collection.extend({
  url: "/api/items_trade",
  model: Suits.Models.Item
});

window.Suits.Collections.items_trade = new window.Suits.Collections.ItemsTrade();