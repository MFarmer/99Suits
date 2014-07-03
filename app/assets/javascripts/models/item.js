window.Suits.Models.Item = Backbone.Model.extend({
  urlRoot: "/api/items",

  comments: function() {
    if(!this._comments){
      this._comments = new Suits.Collections.ItemComments([], {
        item: this
      });
    }

    return this._comments;
  },

  parse: function(jsonResp) {
    if(jsonResp.comments){
      // We grabbed a regular array of objects that happened to be comments. Let's stuff them into our special Comments collections, then cut the regular array.
      this.comments().set(jsonResp.comments);
      delete jsonResp.comments;
    }

    return jsonResp;
  }
});