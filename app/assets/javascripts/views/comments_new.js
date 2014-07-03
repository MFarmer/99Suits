window.Suits.Views.CommentsNew = Backbone.View.extend({
  template: JST["comments/new"],

  events: {
    "submit form": "submit",
    "keyup textarea": "handleKeyup"
  },

  initialize: function(options) {
    item = options.item;
  },

  render: function() {
    var renderedContent = this.template({
      item: item
    });

    this.$el.html(renderedContent);

    return this;
  },

  submit: function(event){
    event.preventDefault();

    var view = this;
    console.log(item);

    var params = $(event.currentTarget).serializeJSON()["comment"];

    var comment = new Suits.Models.Comment(params);

    comment.save({}, {
      success: function() {
        item.comments().add(comment)
      }
    });
  },

  renderPreview: function() {
    var content = this.$("textarea").val();
    this.$(".preview").html(marked(_.escape(content)));
  },

  handleKeyup: function(event) {
    this.renderPreview();
    console.log(this.$("textarea").val());
  }
});