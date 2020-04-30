Rails.application.routes.draw do
  namespace :api do
    namespace :admin do
      namespace :v1 do
        resources :organizations
      end
    end
  end
  namespace :api do
    namespace :v1, defaults: { format: 'json' } do
      devise_for :users, singular: :user, path_names: {
        sign_in: 'login',
        sign_out: 'logout'
      },
                         controllers: {
                           sessions: 'api/v1/sessions'
                         }
    end
    namespace :admin do
      namespace :v1, defaults: { format: 'json' } do
        resources :characters
        resources :worlds
        resources :organizations
      end
    end
  end
end
