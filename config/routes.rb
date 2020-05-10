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
        
        resources :dialogic_interactions
        resources :email_interactions
        resources :learning_objects

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
        
        resources :learning_modules do
          resources :chat_learn_objs do
            # chat learn obj custom routes here ...
          end
        end
      end
    end
  end
end
