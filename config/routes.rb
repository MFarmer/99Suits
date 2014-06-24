Rails.application.routes.draw do
  root "sessions#home"

  resource :session, :only => [:new, :destroy, :create]

  resources :users, :only => [:new, :show, :edit, :update, :create] do
    resources :items, :only => [:new, :create, :edit, :update]
  end

  resources :items, :only => [:index, :show]
end
