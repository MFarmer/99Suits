Rails.application.routes.draw do

  ### Backbone ###
  namespace :api do

    shallow do
      resources :users do
        resources :items do
          resources :orders do
            resources :feedbacks
          end
          resources :comments
        end
      end
    end

    get '/feed', to: 'dashboard#feed_all', as: 'feed_all'
    get '/feed/sale', to: 'dashboard#feed_sale', as: 'feed_sale'
    get '/feed/trade', to: 'dashboard#feed_trade', as: 'feed_trade'
    get '/feed/staff_picks', to: 'dashboard#featured_staff_picks', as: 'staff_picks'
    get '/feed/most_liked', to: 'dashboard#featured_most_liked', as: 'most_liked'
    get '/feed/most_commented', to: 'dashboard#featured_most_commented', as: 'most_commented'
    get '/feed/most_active_users', to: 'dashboard#featured_most_active', as: 'most_active'
    get '/feed/newest_users', to: 'dashboard#featured_newest_users', as: 'newest_users'
  end


  ### Original Rails app ###
  root "sessions#home"
  resource :session, :only => [:new, :destroy, :create]

  shallow do
    resources :users do
      resources :items do
        resources :orders do
          resources :feedbacks
        end
        resources :comments
      end
    end
  end

  resources :items, :only => [:show]

  get '/feed', to: 'dashboard#feed_all', as: 'feed_all'
  get '/feed/sale', to: 'dashboard#feed_sale', as: 'feed_sale'
  get '/feed/trade', to: 'dashboard#feed_trade', as: 'feed_trade'
  get '/feed/staff_picks', to: 'dashboard#featured_staff_picks', as: 'staff_picks'
  get '/feed/most_liked', to: 'dashboard#featured_most_liked', as: 'most_liked'
  get '/feed/most_commented', to: 'dashboard#featured_most_commented', as: 'most_commented'
  get '/feed/most_active_users', to: 'dashboard#featured_most_active', as: 'most_active'
  get '/feed/newest_users', to: 'dashboard#featured_newest_users', as: 'newest_users'

  get '/users/:id/feedback', to: 'users#feedback', as: 'user_feedback'
  get '/users/:id/followers', to: 'users#followers', as: 'user_followers'
  get '/users/:id/following', to: 'users#following', as: 'user_following'

  get '/account', to: 'dashboard#account_profile', as: 'account_profile'
  get '/account/reports', to: 'dashboard#account_reports', as: 'account_reports'
  get '/account/feedbacks', to: 'dashboard#account_feedback', as: 'account_feedback'

  get '/account/available', to: 'dashboard#account_available', as: 'account_available'
  get '/account/received', to: 'dashboard#account_received', as: 'account_received'
  get '/account/gone', to: 'dashboard#account_gone', as: 'account_gone'
  get '/account/hidden', to: 'dashboard#account_hidden', as: 'account_hidden'

  get '/account/ship', to: 'dashboard#account_ship', as: 'account_ship'
  get '/account/pickup', to: 'dashboard#account_pickup', as: 'account_pickup'
  get '/account/pending_feedback', to: 'dashboard#account_pending_feedback', as: 'account_pending_feedback'
  get '/account/on_the_way', to: 'dashboard#account_on_the_way', as: 'account_on_the_way'
  get '/account/leave_feedback', to: 'dashboard#account_leave_feedback', as: 'account_leave_feedback'

  get '/discover', to: 'dashboard#discover', as: 'discover'
  get '/activity', to: 'dashboard#activity', as: 'activity'
  post '/follow/:id', to: 'users#follow', as: 'follow'

  get '/orders/:id/mark_as_shipped', to: 'orders#mark_as_shipped', as: 'mark_as_shipped'
  get '/orders/:id/invoice', to: 'orders#invoice', as: 'invoice'
  get '/orders/:id/confirmation', to: 'orders#confirmation', as: 'order_confirmation'

  get '/items/:id/like', to: 'items#like', as: 'item_like'
  get '/items/:id/relist', to: 'items#relist', as: 'item_relist'
  get '/items/:id/staff_pick', to: 'items#staff_pick', as: 'item_staff_pick'
end
