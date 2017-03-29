Rails.application.routes.draw do
  get '/about' => 'pages#about'
  get '/contact' => 'pages#contact'

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
