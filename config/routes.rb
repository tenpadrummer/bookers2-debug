Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  root :to => "homes#top"
  get "home/about" => "homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
    collection do
      get "search", to: "books#search"
      get 'tag_search', to: 'tags#search'
    end
  end
  resources :users, only: [:index,:show,:edit,:update] do
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'

  end
  resources :relationships
  resources :rooms, only: [:create, :show] do
    resources :messages, only: [:create]
  end

  resources :groups, only: [:index,:show,:new,:create,:edit,:update] do
    member do
      get "join", to: "groups#join"
      delete "leave", to: "groups#leave"
      get "new/mail", to: "groups#new_mail"
      post "mail", to: "groups#create_mail"
    end
  end

  get 'search' => "searches#search"

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
