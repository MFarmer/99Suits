window.Suits.Collections.ItemsSale = Backbone.Collection.extend({
  url: "/api/items_sale",
  model: Suits.Models.Item
});

window.Suits.Collections.items_sale = new window.Suits.Collections.ItemsSale();