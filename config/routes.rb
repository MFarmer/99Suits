Rails.application.routes.draw do
  root "sessions#home"

  resource :session, :only => [:new, :destroy, :create]

  shallow do
    resources :users do
      resources :items do
        resources :comments
      end
    end
  end

  resources :items, :only => [:index, :show]

  get '/feed', to: 'dashboard#feed_all', as: 'feed_all'
  get '/feed/sale', to: 'dashboard#feed_sale', as: 'feed_sale'
  get '/feed/trade', to: 'dashboard#feed_trade', as: 'feed_trade'

  get '/items/:id/like', to: 'items#like', as: 'item_like'
end
