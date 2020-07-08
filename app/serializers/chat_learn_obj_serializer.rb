# frozen_string_literal: true

# == Schema Information
#
# Table name: chat_learn_objs
#
#  id                  :bigint           not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  title               :string
#  chat_character_id   :integer          is an Array
#  mentor_character_id :integer
#  dialog_node_list    :json
#

class ChatLearnObjSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :chat_character_id, :mentor_character_id, :dialog_node_list

  attribute :chat_character do |chat_learn_obj|
    WorldOrgCharacterTrimmedSerializer.new(chat_learn_obj.to_characters)
                                      .as_json['data']
  end

  attribute :mentor_character do |chat_learn_obj|
    WorldOrgCharacterTrimmedSerializer.new(chat_learn_obj.mentor_character)
                                      .as_json['data']
  end
end
