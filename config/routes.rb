# frozen_string_literal: true

Rails.application.routes.draw do
  resources :email_responses
  namespace :api do
    namespace :v1, defaults: { format: 'json' } do
      devise_for :users, singular: :user, path_names: {
        sign_in: 'login',
        sign_out: 'logout'
      },
        controllers: {
          sessions: 'api/v1/sessions'
        }
      resources :learner_dashboards, only: [:index]
      resources :modules do
        resources :module_details
      end
      resources :quiz_responses, only: %i[create] do
        get 'quiz_final_resp'
      end
      resources :quiz_questions, only: %i[index]
      resources :quiz_evaluations, only: %i[create update show]
      resources :dialogic_evaluations, only: %i[show], shallow: true do
        resources :dialogic_answers
      end
      resources :user_chats
      resources :user_chat_messages
      resources :dialogic_questions, only: %i[index]
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
            end
          end
          resources :learning_objects, only: [], shallow: true do
            resources :nlu_training_inputs
            resources :asst_intents do
              collection do
                post :upload_csv
                post :sync_with_assistant
                get :link_to_dialog_skill
              end
            end
            resources :asst_entities do
              collection do
                post :upload_csv
                post :sync_with_assistant
                get :link_to_dialog_skill
              end
              resources :asst_entity_values
            end
            resources :asst_assistant_shells do
              collection do
                get :link_to_dialog_skill
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
        resources :genders
        resources :email_learn_objs, shallow: true do
          member do
            post :nlu_analysis
            get :nlu_enrichment_items
          end
        end
        resources :chat_learn_objs, shallow: true do
          member do
            get :import_skills
          end
          resources :chat_skills
          resources :chat_skill_assmnt_items
          resources :chat_skill_assmnt_misseds
        end
        resources :quiz_learn_objs, shallow: true do
          resources :quiz_questions do
            resources :entity_evaluations
            resources :quiz_feedbacks, only: %i[index update create]
          end
        end
        resources :dialogic_learn_objs, only: %i[show], shallow: true do
          member do
            post :reorder_questions
            post :add_introduction
            post :add_conclusion
          end
          resources :dialogic_questions,
                    only: %i[index show create update] do
            resources :key_topics do
              resources :dialogic_assmnt_items
              resources :missed_assmnt_items
            end
          end
        end
      end
    end
  end
end
