Rails.application.routes.draw do
  resources :dialogic_interactions
  resources :email_interactions
  resources :learning_objects
  resources :learning_modules
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
            delete :remove_photo
          end
        end
        resources :worlds do
          resources :world_organizations
        end
        resources :organizations do
          member do
            delete :remove_photo
          end
        end
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
        resources :global_videos
        resources :global_resources
      end
    end
  end
end
