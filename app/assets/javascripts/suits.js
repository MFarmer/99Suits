window.Suits = {
  Models: {},
  Collections: {},
  Views: {},
  initialize: function() {

    // Tell the view what data it will have to render from
    var view = new Suits.Views.ItemsIndex({
      items: Suits.Collections.items
    });

    Suits.Collections.items.fetch({
      success: function() {
        view.render();
        $(".main-col").append(view.render().$el);
      }
    });
  }
};

$(Suits.initialize);