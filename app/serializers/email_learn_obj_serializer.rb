# frozen_string_literal: true

class EmailLearnObjSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description, :to_character_ids, :cc_character_ids

  attribute :to_characters do |email_learn_obj|
    CharacterSerializer.new(email_learn_obj.to_characters).as_json['data']
  end

  attribute :cc_characters do |email_learn_obj|
    CharacterSerializer.new(email_learn_obj.cc_characters).as_json['data']
  end
end
