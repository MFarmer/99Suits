window.Suits.Views.ItemShow = Backbone.CompositeView.extend({

  template: JST["items/show"],

  initialize: function(options) {
    // this.collection = options.items;
    this.listenTo(this.model, "sync", this.render); //"sync" is fired with fetched automatically
    this.listenTo(this.model.comments(), "sync add remove", this.render);

    // Build a comment view. Put it inside a div I placed in my item_show template
    var commentNewView = new Suits.Views.CommentsNew({
      item: this.model
    });

    this.addSubView(".comment-new", commentNewView);
  },

  events: {

  },

  render: function() {

    // Give the template data to display. It's expecting something called items in this case.
    var renderedContent = this.template({
      item: this.model
    });

    this.$el.html(renderedContent);
    this.renderSubviews();

    return this;
  }
});