window.Suits.Views.ItemsIndex = Backbone.View.extend({

  template: JST["items/index"],

  // Events can only manage elements inside itself ($el)
  events: {
    "click button#refresh": "refresh"
  },

  initialize: function(options) {
    // this.collection = options.items;
    this.listenTo(this.collection, "sync add", this.render); //"sync" is fired with fetched automatically
  },

  refresh: function() {
    this.collection.fetch();
  },

  render: function() {

    // Give the template data to display. It's expecting something called items in this case.
    var renderedContent = this.template({
      items: this.collection
    });

    this.$el.html(renderedContent);

    return this;
  }
});