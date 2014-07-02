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

$(Suits.initialize);