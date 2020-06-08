# frozen_string_literal: true

module AsstElementHandler
  # Common code for all Asst Elements
  class Base
    attr_reader :learn_mod, :learning_object

    def initialize(args)
      @learn_mod = args[:learn_mod]
      @learning_object = args[:learning_object]
      # Below hardcodings will be removed (From @learn mod)
      asst_api_key = "rOPkiz1MjcKCU5QOaSm5cBj785zcSpaWQ_SN-6AqR1hr"
      asst_service_url = "https://api.us-south.assistant.watson.cloud.ibm.com/instances/d09c96a7-f96e-420f-97b8-f95ff58b1916"
      @skill_id = @learning_object.assistant_dialog_skill&.skill_id
      @assistant_service = AssistantService.new(asst_api_key,
                                                asst_service_url, @skill_id)
    end

    def success?(res)
      success_status_code = [200, 201]
      success_status_code.include?(res.status)
    end
  end
end
