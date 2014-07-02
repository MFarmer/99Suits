window.Suits.Collections.ItemComments = Backbone.Collection.extend({

  url: function() {
    return "/api/items/" + this.item.get("id") + "/comments";
  },

  initialize: function(models, options) {
    this.item = options.item;
  },

  model: Suits.Models.Comment

});