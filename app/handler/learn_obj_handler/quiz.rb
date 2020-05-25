module LearnObjHandler
    #Quiz Learn Object
  class Quiz < LearnObjHandler::Base
    def initialize(args)
        super
    end

    def build_record
        @learning_object.objectable ||= QuizLearnObj.new
        @learning_object.objectable.assign_attributes(quiz_params)
    end
  
    def quiz_params
        return {} unless card?
  
        {
          title: params[:card][:title],
          description: params[:card][:description],
          score_view_type: params[:card][:score_view_type]
        }
    end

  end
end