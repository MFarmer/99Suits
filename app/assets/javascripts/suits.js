window.Suits = {
  Models: {},
  Collections: {},
  Views: {},

  initialize: function() {

    // Tell the view what data it will have to render from
    var view = new Suits.Views.ItemsIndex({
      collection: Suits.Collections.items
    });

    Suits.Collections.items.fetch();
    $(".main-col").append(view.render().$el);

    var view = new Suits.Views.ItemsNew();
    $(".main-col").append(view.render().$el);
  }
};

$(Suits.initialize);