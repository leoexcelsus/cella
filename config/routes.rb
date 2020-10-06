Rails.application.routes.draw do
  root to: 'pages#home'

  get "rules/spatial_search/", to: "rules#spatial_search", as: :spatial_search

  # Leandro comments: the route below is now commented and seems to make no sense due to difficulties
  # it imposes in sending the results to route 'search_mine', which was originally
  # a GET route. 'search_mine', therefore, is now changed to a POST route.
  # post "rules/spatial_search", to: "rules#spatial_query", as: :spatial_query

  devise_for :users, :path => "accounts", :controllers => { registrations: "registrations" }
  devise_scope :user do
    get '/signout', to: 'devise/sessions#destroy', as: :signout
  end

  get "rules/users/:user_id", to: "rules#myrules", as: :myrules

  resources :rules, only: [ :show, :edit ]

  get "rules/:id/delete", to: "rules#destroy", as: :delete_rules

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # get "rules_mine/", to: "rules#show_rules", as: :rules_user

  # As noted above, this route was changed from a GET to a POST route.
  get "search_mine/", to: "rules#index_search", as: :index_search



end
