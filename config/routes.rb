Rails.application.routes.draw do
  resources :menus do
    resources :recipes,
    controller: 'menu_recipes',
    only: [:new, :create, :destroy],
    param: :recipe_id
  end
  resources :recipes
  resources :sessions, only: [:new, :create, :destroy]

  root 'pages#index'
end
