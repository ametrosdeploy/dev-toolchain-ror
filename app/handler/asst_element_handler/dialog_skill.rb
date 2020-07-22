# frozen_string_literal: true

module AsstElementHandler
  # Quiz Learn Object
  class DialogSkill < AsstElementHandler::Base
    def initialize(args)
      super
      interaction_obj = @learning_object.objectable
      @name = interaction_obj[:title]
      @desc = interaction_obj[:description]
    end

    def create_dialog_skill
      @response = @assistant_service.create_dialog_skill(
        @name, @desc
      )
      # response err code handle ...
      return unless success?

      skill_id = @response.result['workspace_id']
      @dialog_skill = AssistantDialogSkill.create(skill_id: skill_id,
                                  name: @name,
                                  learning_object: @learning_object)

      
      if @learning_object.card_type == "chat" 
        create_assistant_shell
      end
      
    end

    def create_assistant_shell  
      AsstAssistantShell.create(
        assistant_dialog_skill_id: @dialog_skill.id
      )
    end

    def list_dialog_nodes
      @response = @assistant_service.list_dialog_nodes
      unless success?
        errors(@response)
        nil
      end
      @result = @response.result
      #save_entity_from_result
    rescue StandardError => e
      errors(e.message)
    end

    

   

  end
end
