Rails.application.routes.draw do
<<<<<<< HEAD
  namespace :api do
    namespace :v1, defaults: { format: 'json' } do
      devise_for :users, singular: :user, path_names: {
        sign_in: 'login'
      },
      controllers: {
        sessions: 'api/v1/sessions'
      }
    end
    namespace :admin do
      namespace :v1, defaults: { format: 'json' } do
        resources :characters do
          member do 
            post :assign_organization_role
          end
        end
        resources :worlds do
          resources :world_organizations
        end
        resources :organizations
        resources :world_roles do
          collection do
            get :auto_comp_data
          end
        end
        resources :customers do
          collection do
            get :auto_comp_data
          end
        end
        resources :industries do
          collection do
            get :auto_comp_data
          end
        end
        resources :examples do
          collection do
          end
        end
        resources :concepts do
          collection do
          end
        end
        resources :entities do
          collection do
          end
        end
        resources :keywords do
          collection do
          end
        end
      end
    end
  end
=======
  resources :examples
  resources :entities
  resources :keywords
  resources :concepts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
>>>>>>> 3751264de7b89eec3f74f3ddcfb4536efa4a1171
end
