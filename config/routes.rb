Rails.application.routes.draw do
  root to: 'pages#home'

  get "pages/about", to: "pages#about", as: :about

  get "rules/spatial_search/", to: "rules#spatial_search", as: :spatial_search

  get '/polygons', to: 'polygons#index'

  get '/polygons/:id', to: 'polygons#show'

  get '/rules/:id/polygons', to: 'rules#polygons', as: :rule_polygons

  # Leandro comments: the route below is now commented and seems to make no sense due to difficulties
  # it imposes in sending the results to route 'search_mine', which was originally
  # a GET route. 'search_mine', therefore, is now changed to a POST route.
  # post "rules/spatial_search", to: "rules#spatial_query", as: :spatial_query




  devise_for :users


  get "rules/users/:user_id", to: "rules#myrules", as: :myrules


  post "rules/:rule_id/rating", to: "ratings#create", as: :rule_ratings


  resources :rules, only: [ :show, :index, :edit, :update, :new, :create ]


  get "rules/:id/delete", to: "rules#destroy", as: :delete_rules

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # get "rules_mine/", to: "rules#show_rules", as: :rules_user

  # As noted above, this route was changed from a GET to a POST route.
  post "search_mine/", to: "rules#index_search", as: :index_search



end
