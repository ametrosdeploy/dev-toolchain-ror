# frozen_string_literal: true

# Controller for creating assistant entities ...
class Api::Admin::V1::ChatSkillAssmntMissedsController < Api::Admin::V1::BaseController
    before_action :set_chat_skill_assmnt_item_missed, only: %i[ show create update destroy ]
    before_action :set_chat_skill, only: %i[index]
    
    LEARN_OBJ_ID = 'learning object ID'
  
    def index
        @chat_skill_assmnt_misseds = @chat_skill.chat_skill_assmnt_misseds
        render json: serialize_rec(@chat_skill_assmnt_misseds)
    end

    def show
        render json: serialize_rec(@chat_skill_assmnt_missed)
    end

    def create
        @chat_skill_assmnt_missed = ChatSkillAssmntMissed.new(chat_skill_assmnt_item_missed_params)

        if @chat_skill_assmnt_missed.save
            render json: serialize_rec(@chat_skill_assmnt_missed), status: :created
        else
            render json: @chat_skill_assmnt_missed.errors, status: :unprocessable_entity
        end
    end

    def update
        if @chat_skill_assmnt_missed.update(chat_skill_assmnt_item_missed_params)
            render json: serialize_rec(@chat_skill_assmnt_missed)
        else
            render json: @chat_skill_assmnt_missed.errors, status: :unprocessable_entity
        end
    end

    def destroy
     @chat_skill_assmnt_missed.destroy
    end
  
  
    swagger_controller :chat_skill_assmnt_item_misseds, 'Chat Skill Assessment Misseds', resource_path:
      '/api/admin/v1/chat_skill_assmnt_misseds'
      
    swagger_api :index do
        summary 'List Chat Skill Assessment Misseds'
        notes 'Should be used to list the chat skill assessment missed record for a given chat skill'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :path, 'chat_skill_id', :integer, :required, 'Chat skill ID'
    end

  
    swagger_api :create do
        summary 'Creates a new chat skill assessment missed'
        notes 'Should be used to create a new chat skill assessment missed'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :form, 'chat_skill_assmnt_missed[points]', :integer, :required, 'Points'
        param :form, 'chat_skill_assmnt_missed[chat_skill_id]', :integer, :required, 'Chat skill ID'
        response :unauthorized
    end

    swagger_api :update do
        summary 'Updates a chat skill assessment missed'
        notes 'Should be used to update a chat skill assessment missed record'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :form, 'chat_skill_assmnt_missed[points]', :integer, :required, 'Points'
        param :form, 'chat_skill_assmnt_missed[chat_skill_id]', :integer, :required, 'Chat skill ID'
        response :unauthorized
    end

    swagger_api :show do
        summary 'Show chat skill assessment missed'
        notes 'Should be used to show a chat skill assessment missed'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :path, 'id', :string, :required, 'chat skill assmnt missed ID'
    end

    swagger_api :destroy do
        summary 'Destroy chat skill assessment missed'
        notes 'Should be used to destroy a chat skill assessment missed'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :path, 'id', :string, :required, 'chat skill assmnt missed ID'
    end
    

    private
  
    # Use callbacks to share common setup or constraints between actions.

  
    def set_chat_skill_assmnt_missed
      @chat_skill_assmnt_missed = ChatSkillAssmntMissed.find(params[:id])
    end

    def set_chat_skill  
        @chat_skill = ChatSkill.find(params[:chat_skill_id])
    end
  
    # Only allow a trusted parameter "white list" through.
    def chat_skill_assmnt_missed_params
        params.require(:chat_skill_assmnt_missed).permit(:points, :chat_skill_id)
    end
    
    def serializer
        ChatSkillAssmntMissedSerializer
    end
  end
  