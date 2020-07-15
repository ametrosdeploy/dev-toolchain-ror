# frozen_string_literal: true

# Controller for creating assistant entities ...
class Api::Admin::V1::ChatSkillAssmntItemsController < Api::Admin::V1::BaseController
    before_action :set_chat_skill_assmnt_item, only: %i[show create update destroy ]
    before_action :set_chat_skill, only: %i[index]
    
    LEARN_OBJ_ID = 'learning object ID'
  
    def index
        @chat_skill_assmnt_items = @chat_skill.chat_skill_assmnt_items
        render json: serialize_rec(@chat_skill_assmnt_items)
    end

    def show
        render json: serialize_rec(@chat_skill_assmnt_item)
    end

    def create
        @chat_skill_assmnt_item = ChatSkillAssmntItem.new(chat_skill_assmnt_item_params)

        if @chat_skill_assmnt_item.save
            render json: serialize_rec(@chat_skill_assmnt_item), status: :created
        else
            render json: @chat_skill_assmnt_item.errors, status: :unprocessable_entity
        end
    end

    def update
        if @chat_skill_assmnt_item.update(chat_skill_assmnt_item_params)
            render json: serialize_rec(@chat_skill_assmnt_item)
        else
            render json: @chat_skill_assmnt_item.errors, status: :unprocessable_entity
        end
    end

    def destroy
     @chat_skill_assmnt_item.destroy
    end
  
  
    swagger_controller :chat_skill_assmnt_items, 'Chat Skill Assessment Items', resource_path:
      '/api/admin/v1/chat_skill_assmnt_items'

    swagger_api :index do
        summary 'List Chat Skill Assessment Items'
        notes 'Should be used to list chat skill assessment items for a given chat skill'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :path, 'chat_skill_id', :integer, :required, 'Chat skill ID'
    end

    swagger_api :create do
        summary 'Creates a new chat skill assessment item'
        notes 'Should be used to create a new chat skill assessment item'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :form, 'chat_skill_assmnt_item[assessment_label_id]', :string, :required, 'Assessment label ID'
        param :form, 'chat_skill_assmnt_item[value_count_min]', :integer, :required, 'Value count min'
        param :form, 'chat_skill_assmnt_item[value_count_max]', :integer, :required, 'Value count max'
        param :form, 'chat_skill_assmnt_item[points]', :integer, :required, 'Points'
        param :form, 'chat_skill_assmnt_item[chat_skill_id]', :integer, :required, 'Chat skill ID'
        response :unauthorized
    end

    swagger_api :update do
        summary 'Updates a chat skill assessment item'
        notes 'Should be used to update a chat skill assessment item record'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :form, 'chat_skill_assmnt_item[assessment_label_id]', :string, :required, 'Assessment label ID'
        param :form, 'chat_skill_assmnt_item[value_count_min]', :integer, :required, 'Value count min'
        param :form, 'chat_skill_assmnt_item[value_count_max]', :integer, :required, 'Value count max'
        param :form, 'chat_skill_assmnt_item[points]', :integer, :required, 'Points'
        param :form, 'chat_skill_assmnt_item[chat_skill_id]', :integer, :required, 'Chat skill ID'
        response :unauthorized
    end

    swagger_api :show do
        summary 'Show chat skill assessment item'
        notes 'Should be used to show a chat skill assessment item'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :path, 'id', :string, :required, 'chat skill assmnt item ID'
    end

    swagger_api :destroy do
        summary 'Destroy chat skill assessment item'
        notes 'Should be used to destroy a chat skill assessment item'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :path, 'id', :string, :required, 'chat skill assmnt item ID'
    end

    
  
    private
  
    # Use callbacks to share common setup or constraints between actions.

    def set_chat_skill  
        @chat_skill = ChatSkill.find(params[:chat_skill_id])
    end
  
    def set_chat_skill_assmnt_item
      @chat_skill_assmnt_item = ChatSkillAssmntItem.find(params[:id])
    end
  
    # Only allow a trusted parameter "white list" through.
    def chat_skill_assmnt_item_params
        params.require(:chat_skill_assmnt_item).permit(:assessment_label_id, :value_count_min, :value_count_max, :points, :chat_skill_id)
      end
    
    def serializer
        ChatSkillAssmntItemSerializer
    end
  end
  