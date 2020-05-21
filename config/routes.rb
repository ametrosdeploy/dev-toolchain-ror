# frozen_string_literal: true

Rails.application.routes.draw do
  resources :learning_objects
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
          member do
            get :elm_lists
            get :world_orgs
            get :characters
          end
        end
        resources :organizations do
          member do
            delete :remove_photo
          end
          collection do
            get :assign_org_list
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
        resources :learn_mods do
          resources :learning_objects
          member do
            delete :remove_photo
          end
        end
        resources :users do
          collection do
            get :users_list
          end
        end
        resources :global_skills
      end
    end
  end
end
