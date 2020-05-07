Rails.application.routes.draw do
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
end
