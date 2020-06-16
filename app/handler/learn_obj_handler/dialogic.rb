# frozen_string_literal: true

module LearnObjHandler
  # Needed to create Email Learn Object
  class Dialogic < LearnObjHandler::Base
    def initialize(args)
      super
    end

    def build_record
      @learning_object.objectable ||= DialogicLearnObj.new
      @learning_object.objectable.assign_attributes(dialogic_params)
    end

    def dialogic_params
      return {} unless card?

      card_param = params[:card]
      {
        title: card_param[:title],
        character_id: card_param[:character_id],
        repeat_interaction: card_param[:repeat_interaction],
        max_repeat_count: card_param[:max_repeat_count],
        unlimited_repeats: card_param[:unlimited_repeats]
      }
    end
  end
end
