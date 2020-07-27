# frozen_string_literal: true

module AsstElementHandler
  # Common code for all Asst Elements
  class Base
    # get the credentials and connect asst...
    def initialize(args)
      @learning_object = args[:learning_object]
      @learn_mod = args[:learn_mod] || @learning_object&.learn_mod
      guid = @learn_mod.asst_service_instance&.guid
      skill_id = @learning_object.assistant_dialog_skill&.skill_id
      unless @learning_object.assistant_dialog_skill.blank?
        unless @learning_object.assistant_dialog_skill.asst_assistant_shell.blank?
          assistant_api_key = @learning_object.assistant_dialog_skill.asst_assistant_shell.api_key
          assistant_id = @learning_object.assistant_dialog_skill.asst_assistant_shell.assistant_id
          @assistant_v2_service = AssistantV2Service.new(assistant_api_key, assistant_id)
        end
      end
      @assistant_service = AssistantService.new(guid, skill_id)
      @errors = []
      @response = nil
    end

    def success?
      return if @response.class != IBMCloudSdkCore::DetailedResponse

      success_status_code = [200, 201]
      success_status_code.include?(@response.status)
    end

    def errors(msg)
      @errors << msg
    end

    def full_messages
      @errors.join(', ')
    end
  end
end
