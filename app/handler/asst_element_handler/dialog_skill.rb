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
      response = @assistant_service.create_dialog_skill(
        @name, @desc
      )
      # response err code handle ...
      return unless success?(response)

      skill_id = response.result['workspace_id']
      AssistantDialogSkill.create(skill_id: skill_id,
                                  name: @name,
                                  learning_object: @learning_object)
    end
  end
end
