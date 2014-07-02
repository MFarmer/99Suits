window.Suits.Views.ItemsIndex = Backbone.View.extend({

  template: JST["items/index"],

  initialize: function(options) {
    this.items = options.items;
  },

  render: function() {

    // Give the template data to display. It's expecting something called items in this case.
    var renderedContent = this.template({
      items: this.items
    });

    this.$el.html(renderedContent);

    return this;
  }
});