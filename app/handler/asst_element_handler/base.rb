# frozen_string_literal: true

module AsstElementHandler
  # Common code for all Asst Elements
  class Base
    attr_reader :learn_mod, :learning_object

    def initialize(args)
      @learn_mod = args[:learn_mod]
      @learning_object = args[:learning_object]
      guid = @learn_mod.asst_service_instance&.guid
      skill_id = @learning_object.assistant_dialog_skill&.skill_id
      @assistant_service = AssistantService.new(guid, skill_id)
    end

    def success?(res)
      success_status_code = [200, 201]
      success_status_code.include?(res.status)
    end
  end
end
