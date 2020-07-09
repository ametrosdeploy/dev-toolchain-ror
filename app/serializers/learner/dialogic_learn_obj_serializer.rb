# frozen_string_literal: true

module Learner
  # Custom serializer for learner
  class DialogicLearnObjSerializer
    include FastJsonapi::ObjectSerializer
    attributes :title, :introduction, :conclusion

    attribute :character do |learn_obj|
      WorldOrgCharacterTrimmedSerializer.new(learn_obj.character)
                                        .as_json['data']
    end
  end
end
