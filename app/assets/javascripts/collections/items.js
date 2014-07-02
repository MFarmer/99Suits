window.Suits.Collections.Items = Backbone.Collection.extend({
  url: "/api/items",
  model: Suits.Models.Item
});

window.Suits.Collections.items = new window.Suits.Collections.Items();