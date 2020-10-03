Rails.application.routes.draw do
  devise_for :users


  get "rules/spatial_search/", to: "rules#spatial_search", as: :spatial_search

  resources :rules, only: [ :show, :index, :new, :create ]

  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "search_mine/", to: "rules#index_search", as: :index_search


end
