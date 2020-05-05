Rails.application.routes.draw do
  resources :examples
  resources :entities
  resources :keywords
  resources :concepts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
