Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # get "/users", to: "users#index"

  # get "/users/:id", to: "users#show"

  # post "/users", to: "users#create"

  # put "/users/:id", to: "users#update"

  # patch "/users/:id", to: "users#update"

  # delete "/users/:id", to: "users#destroy"

  # get "/users/new", to: "users#new", as: 'new_user'
  # # GET    /users/new(.:format)                                                                   users#new

  # get "/users/:id/edit", to: "users#edit", as: 'edit_user'
  # # GET    /users/:id/edit(.:format)                                                                users#edit

  resources :users, only: [:index, :show, :create, :update, :destroy]
  
  resources :artworks, only: [:show, :create, :update, :destroy]

  resources :artwork_shares, only: [:create, :destroy] do
    put 'favorite', on: :member
    put 'unfavorite', on: :member
  end

  resources :users do 
    resources :artworks, only: [:index]
    resources :comments, only: [:index]
    resources :likes, only: [:index]
    resources :collections, only: [:index]
    get 'favorites', on: :member
  end

  resources :comments, only: [:index, :create, :destroy] do
      resources :likes, only: [:index]
  end

  resources :artworks do 
    resources :comments, only: [:index]
    resources :likes, only: [:index]
    put 'favorite', on: :member
    put 'unfavorite', on: :member
  end

  resources :likes, only: [:create, :destroy]

  resources :collections, only: [:show, :create, :destroy]
  resources :artwork_collections, only: [:create, :destroy]
end

