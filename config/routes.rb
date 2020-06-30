Rails.application.routes.draw do
  resources :tweets
  resources :relationships, only: [:create, :destroy]
  post '/users/:id/follow', to: "users#follow", as: "follow_user"
  post '/users/:id/unfollow', to: "users#unfollow", as: "unfollow_user"
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }

  devise_scope :user do
    authenticated :user do
   
       get '/users/sign_out' => 'devise/sessions#destroy'
       root 'tweets#index', as: :authenticated_root
       # root 'devise/registrations#edit', as: :authenticated_root
    end
    unauthenticated do
      # root to: "home#index", as: :unauthenticated_root
      root 'users/sessions#new', as: :unauthenticated_root
    end
  end
end
