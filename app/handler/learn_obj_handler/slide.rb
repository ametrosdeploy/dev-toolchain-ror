# frozen_string_literal: true

module LearnObjHandler
  # Needed to create Email Learn Object
  class Slide < LearnObjHandler::Base
    def initialize(args)
      super
    end

    def build_record
      @learning_object.objectable ||= SlideLearnObj.new
      @learning_object.objectable.assign_attributes(slide_params)
    end

    def slide_params
      return {} unless card?

      slider_data = params[:card].permit![:slider_images_attributes]
      {
        slider_images_attributes: slider_data
      }
    end
  end
end
