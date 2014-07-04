window.Suits = {
  Models: {},
  Collections: {},
  Routers: {},
  Views: {},

  initialize: function() {
    // just sets up the routes
    new Suits.Routers.AppRouter();
    // start listening to changes to the location
    Backbone.history.start();
  }
};

Backbone.CompositeView = Backbone.View.extend({
  // map of subviews
  addSubView: function(selector, view){
    var selectorSubviews = this.subviews()[selector] || (this.subviews()[selector] = []);
    selectorSubviews.push(view);
  },

  renderSubviews: function() {
    var view = this;

    _(this.subviews()).each(function(selectorSubviews, selector){
      var $selectorEl = view.$(selector).empty();
      $selectorEl.empty();

      _(selectorSubviews).each(function(subview) {
        $selectorEl.append(subview.render().$el);
        subview.delegateEvents();
      });
    });
  },

  subviews: function() {
    if(!this._subviews) {
      this._subviews = {};
    }
    return this._subviews;
  }
});

$(Suits.initialize);