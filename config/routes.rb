# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1, defaults: { format: 'json' } do
      devise_for :users, singular: :user, path_names: {
        sign_in: 'login'
      },
                         controllers: {
                           sessions: 'api/v1/sessions'
                         }
      resources :learner_dashboards, only: [:index]
      resources :modules do
        resources :module_details
      end
      resources :quiz_responses, only: %i[create]
    end
    namespace :admin do
      namespace :v1, defaults: { format: 'json' } do
        resources :assessment_schemes do
          # resources :assessment_label
        end
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
        resources :global_videos do
          collection do
            get :video_detail
          end
        end
        resources :global_resources
        resources :learn_mods do
          member do
            delete :remove_photo
            post :reorder_cards
            post :update_status
          end
          resources :learning_objects do
            member do
              post :update_status
              delete :remove_slider_image
              # Watson related routes ...
              post :import_csv
              post :sync_with_assistant
              post :link_to_asst_dialog_skill
            end
            resources :asst_entities do
              member do
                post :add_value_and_synonyms
                post :add_synonym_to_value
                post :update_value_and_synonyms
              end
            end
            resources :overall_assmnt_items
          end
        end
        resources :users do
          collection do
            get :users_list
          end
        end
        resources :global_skills
        resources :learner_dashboards
        resources :sections
        resources :user_sections
        resources :quiz_learn_objs do
          resources :quiz_questions do
            resources :entity_evaluations
            # resources :mcq_options
            resources :quiz_feedbacks, only: %i[index update create]
          end
        end
      end
    end
  end
end
