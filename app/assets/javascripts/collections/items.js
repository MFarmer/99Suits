window.Suits.Collections.Items = Backbone.Collection.extend({
  url: "/api/items",
  model: Suits.Models.Item,

  getOrFetch: function (id) {
    var model;
    var items = this;
    if (model = this.get(id)) {
      model.fetch();
      return model;
    } else {
      model = new Suits.Models.Item({ id: id });

      // if you're fetching a new model, put it in the collection while you're at it.
      model.fetch({
        success: function() {
          items.add(model);
        }
      });
      return model;
    }
  }
});

window.Suits.Collections.items = new window.Suits.Collections.Items();