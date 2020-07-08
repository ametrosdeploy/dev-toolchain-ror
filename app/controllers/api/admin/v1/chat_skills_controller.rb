# frozen_string_literal: true

# Controller for creating assistant entities ...
class Api::Admin::V1::ChatSkillsController < Api::Admin::V1::BaseController
    before_action :set_chat_skill, only: %i[index show create update destroy ]
    
    LEARN_OBJ_ID = 'learning object ID'
  
    def index
        @chat_skills = ChatSkill.all
        render json: @chat_skills
    end

    def show
        render json: serialize_rec(@chat_skill)
    end

    def create
        @chat_skill = ChatSkill.new(chat_skill_params)

        if @chat_skill.save
            render json: serialize_rec(@chat_skill), status: :created
        else
            render json: @chat_skill.errors, status: :unprocessable_entity
        end
    end

    def update
        if @chat_skill.update(chat_skill_params)
            render json: serialize_rec(@chat_skill)
        else
            render json: @chat_skill.errors, status: :unprocessable_entity
        end
    end

    def destroy
     @chat_skill.destroy
    end
  
  
    swagger_controller :chat_skills, 'Chat Skills', resource_path:
      '/api/admin/v1/chat_skills'

    swagger_api :index do
        summary 'List Chat Skills'
        notes 'Should be used to list chat skills'
        param :header, :Authorization, :string, :required, 'Authorization'
    end

    swagger_api :create do
        summary 'Creates a new chat skill'
        notes 'Should be used to create a new chat skill'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :form, 'chat_skill[assistant_dialog_skill_id]', :string, :required, 'Assistant dialog skill ID'
        param :form, 'chat_skill[skill_name]', :integer, :required, 'Skill name'
        response :unauthorized
    end

    swagger_api :update do
        summary 'Updates a chat skill'
        notes 'Should be used to update a chat skill record'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :form, 'chat_skill[assistant_dialog_skill_id]', :string, :required, 'Assistant dialog skill ID'
        param :form, 'chat_skill[skill_name]', :integer, :required, 'Skill name'
        response :unauthorized
    end

    swagger_api :show do
        summary 'Show chat skill'
        notes 'Should be used to show a chat skill'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :path, 'id', :string, :required, 'chat skill ID'
    end

    swagger_api :destroy do
        summary 'Destroy chat skill'
        notes 'Should be used to destroy a chat skill'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :path, 'id', :string, :required, 'chat skill ID'
    end

    
  
    private
  
    # Use callbacks to share common setup or constraints between actions.

    def set_assistant_dialog_skill
        @assistant_dialog_skill = AssistantDialogSkill.find(
          params[:assistant_dialog_skill_id]
        )
    end

    def set_learning_object
        @learning_object = LearningObject.find(
          @assistant_dialog_skill.learning_object_id
        )
    end
  
    def set_chat_skill
      @chat_skill = ChatSkill.find(params[:id])
    end
  
    # Only allow a trusted parameter "white list" through.
    def chat_skill_params
        params.require(:chat_skill).permit(:assistant_dialog_skill_id, :skill_name)
      end
    
    def serializer
        ChatSkillSerializer
    end
  end
  