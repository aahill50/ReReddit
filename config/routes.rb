RedditClone::Application.routes.draw do
  root to: 'subs#all'
  resources :users do
    resources :subs, only: [:index, :new]
  end
  resource :session, only: [:new, :create, :destroy]
  resources :subs, except: [:index, :new]

  resources :subs, only: [:create, :show, :edit, :update]
  resources :posts, only: [:new, :create, :show, :edit, :update]

end
