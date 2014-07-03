window.Suits.Views.ItemShow = Backbone.View.extend({

  template: JST["items/show"],

  initialize: function(options) {
    // this.collection = options.items;
    this.listenTo(this.model, "sync", this.render); //"sync" is fired with fetched automatically
    this.listenTo(this.model.comments(), "sync", this.render);
  },

  render: function() {

    // Give the template data to display. It's expecting something called items in this case.
    var renderedContent = this.template({
      item: this.model
    });

    this.$el.html(renderedContent);

    return this;
  }
});