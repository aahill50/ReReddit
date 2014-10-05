RedditClone::Application.routes.draw do
  root to: 'subs#all'
  resources :users do
    resources :subs, only: [:index, :new]
  end
  resource :session, only: [:new, :create, :destroy]
  resources :subs, except: [:index, :new]

  resources :subs, only: [:create, :show, :edit, :update]
  resources :posts, only: [:new, :create, :show, :edit, :update] do
    resources :comments, only: [:new] do
      resources :comments, only: [:new]
    end
  end

  post 'comments', to: 'comments#create'
  post 'comments/:id/upvote', to: 'comments#upvote', as: 'comment_up'
  post 'posts/:id/upvote', to: 'posts#upvote', as: 'post_up'
  post 'comments/:id/downvote', to: 'comments#downvote', as: 'comment_down'
  post 'posts/:id/downvote', to: 'posts#downvote', as: 'post_down'
end
