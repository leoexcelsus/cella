Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :rules

  get "search_mine/", to: "rules#index_search", as: :index_search
  get "spatial_search/", to: "rules#spatial_search", as: :spatial_search

end
