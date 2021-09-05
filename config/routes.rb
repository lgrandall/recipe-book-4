Rails.application.routes.draw do
  resources :instructions
  resources :recipes
  resources :ingredients
  resources :quantities
  resources :measurements
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
