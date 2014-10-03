RedditClone::Application.routes.draw do
  root to: 'subs#all'
  resources :users do
    resources :subs, only: [:index, :new]
  end
  resource :session, only: [:new, :create, :destroy]
  resources :subs, except: [:index, :new] do
    resources :posts, only: [:new, :create]
  end

  resources :subs, only: [:create, :show, :edit, :update]
  resources :posts, only: [:show, :edit, :update]
end
