window.Suits.Models.Item = Backbone.Model.extend({
  urlRoot: "/api/items",

  comments: function() {
    if(!this._comments){
      this._comments = new Suits.Collections.ItemComments([], {
        item: this
      });
    }

    return this._comments;
  }
});