# frozen_string_literal: true

# == Schema Information
#
# Table name: email_learn_objs
#
#  id               :bigint           not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  title            :string
#  description      :text
#  to_character_ids :integer          default([]), is an Array
#  cc_character_ids :integer          default([]), is an Array
#
class EmailLearnObjSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :to_character_ids, :cc_character_ids

  attribute :to_characters do |email_learn_obj|
    CharacterSerializer.new(email_learn_obj.to_characters).as_json['data']
  end

  attribute :cc_characters do |email_learn_obj|
    CharacterSerializer.new(email_learn_obj.cc_characters).as_json['data']
  end
end
