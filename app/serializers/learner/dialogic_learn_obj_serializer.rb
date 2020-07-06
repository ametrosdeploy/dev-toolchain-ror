module Learner
  # Custom serializer for learner
  class DialogicLearnObjSerializer
    include FastJsonapi::ObjectSerializer
    attributes :title, :introduction, :conclusion

    attribute :question do |learn_obj|
      questions = learn_obj.dialogic_questions.ordered
      DialogicQuestionsSerializer.new(questions).as_json['data']
    end
    attribute :character do |learn_obj|
      WorldOrgCharacterTrimmedSerializer.new(learn_obj.character)
                                        .as_json['data']
    end
  end
end
