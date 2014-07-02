window.Suits.Views.ItemsNew = Backbone.View.extend({

  template: JST["items/new"],

  events: {
    "submit form": "submit"
  },

  submit: function(event) {
    event.preventDefault();

    var newItem = new Suits.Models.Item();
    //var params = $(event.currentTarget).seralizeJSON()["item"];
    //var newItem = new Suits.Models.Item(params);

    newItem.set("title", $("#title").val());
    newItem.set("category", $("#category").val());
    newItem.set("brand", $("#brand").val());
    newItem.set("condition", $("#condition").val());
    newItem.set("original_price", $("#original_price").val());
    newItem.set("description", $("#description").val());
    newItem.set("sale_price", $("#sale_price").val());
    newItem.set("trade_price", $("#trade_price").val());
    newItem.set("allow_pickup", $("#allow_pickup").val());
    newItem.set("weight", $("#weight").val());
    newItem.set("size", $("#size").val());

    newItem.save({}, {
      success: function() {
        Suits.Collections.items.add(newItem);
        Backbone.history.navigate("", { trigger: true });
      }
    });
  },

  render: function() {
    var renderedContent = this.template();

    this.$el.html(renderedContent);

    return this;
  }
});