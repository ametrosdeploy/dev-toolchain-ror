# frozen_string_literal: true

class Api::Admin::V1::ChatLearnObjsController < Api::Admin::V1::BaseController
    before_action :set_chat_learn_obj, only: %i[import_skills]
    before_action :set_dialog_skill_handler, only: %i[import_skills]
    CHAT_LO_ID = 'Chat Learn Obj ID'

    def import_skills 
      dialog_node_list = @dialog_skill_handler.list_dialog_nodes

      if @dialog_skill_handler.success?
        if @chat_lo.dialog_node_list.blank? 
          @chat_lo.dialog_node_list = dialog_node_list
          @chat_lo.last_skills_import_date = Time.now
          @chat_lo.save!

        else  
          if @chat_lo.dialog_node_list != dialog_node_list 
            @chat_lo.dialog_node_list = dialog_node_list
            @chat_lo.last_skills_import_date = Time.now
            @chat_lo.save!

            
          end
        end 

        extract_chat_skills

        render json: serialize_rec(@chat_lo), status: 200
      else
        render json: { error: errors }, status: :unprocessable_entity
      end
      
    end

    def show 
      render json: serialize_rec(@chat_lo)
    end

    swagger_controller :chat_learn_obj, 'Chat Learn Obj'
  
    swagger_api :import_skills do
        summary 'Import skills from Assistant'
        notes 'Should be used to import skills from an Assistant dialog skill dialog nodes'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :path, 'id', :integer,
              :required, CHAT_LO_ID
    end

    swagger_api :show do
      summary 'Show chat learning object'
      notes 'Should be used to show a chat learning object'
      param :header, :Authorization, :string, :required, 'Authorization'
      param :path, 'id', :integer, :required, CHAT_LO_ID
    end
    
  
    private
  
    def set_chat_learn_obj
      @chat_lo = ChatLearnObj.find(params[:id])
      @lo = @chat_lo.learning_object
      @assistant_dialog_skill = AssistantDialogSkill.find_by(learning_object_id: @lo.id)
    end

    def set_dialog_skill_handler
      @dialog_skill_handler = AsstElementHandler::DialogSkill.new(args)
    end

    def args
      {
        learning_object: @lo,
        assistant_dialog_skill_id: @assistant_dialog_skill.id,
        skill_id: @assistant_dialog_skill.skill_id
      }
    end

    def extract_chat_skills 
      node_list = @chat_lo.dialog_node_list 
      @skills_array = []

      iterate_node_list(node_list)

      @final_skills = []

      @skills_array.each do |skill|
        skill = skill.to_s
        skill = skill.split("; skill_value").first.split("[skill_name: ").last
        if skill.include?(",")
          skills = skill.split(',') 
          skills.each do |skill_multi|
            @final_skills << skill_multi.strip
          end 
        else 

          @final_skills << skill 
        end 
      end 

      @final_skills = @final_skills.uniq
      @final_skills = @final_skills.sort

      unless @final_skills.empty?
        create_chat_skills
      end
    end

    def create_chat_skills 
      @final_skills.each do |skill|
        existing_check = ChatSkill.where(name: skill, assistant_dialog_skill_id: @assistant_dialog_skill.id).first
        if existing_check.blank? 
          chat_skill = ChatSkill.new 
          chat_skill.name = skill 
          chat_skill.assistant_dialog_skill_id = @assistant_dialog_skill.id 
          chat_skill.save!
        end
      end
    end

    def iterate_node_list(h)
      #Rails.logger.debug "*** h value in iterate_node_list method: #{h}"
      h.each do |k,v|
        # If v is nil, an array is being iterated and the value is k. 
        # If v is not nil, a hash is being iterated and the value is v.
        # 
        value = v || k

        if value.is_a?(Hash) || value.is_a?(Array)
          iterate_node_list(value)
        else
          if k == "text" 
            if v.include?("skill_name")
                @skills_array << v 
            end 
          end
        end
      end
      
      
    end

    def serializer
      ChatLearnObjSerializer
    end
  
    
  end
  