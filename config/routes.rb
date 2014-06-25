Rails.application.routes.draw do
  root "sessions#home"

  resource :session, :only => [:new, :destroy, :create]

  resources :users, :only => [:new, :show, :edit, :update, :create] do
    resources :items, :only => [:new, :create, :edit, :update]
  end

  resources :items, :only => [:index, :show]

  get '/feed', to: 'dashboard#feed_all', as: 'feed_all'
  get '/feed/sale', to: 'dashboard#feed_sale', as: 'feed_sale'
  get '/feed/trade', to: 'dashboard#feed_trade', as: 'feed_trade'
end
