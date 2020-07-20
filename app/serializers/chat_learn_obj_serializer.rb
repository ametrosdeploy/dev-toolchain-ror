# frozen_string_literal: true

# == Schema Information
#
# Table name: chat_learn_objs
#
#  id                      :bigint           not null, primary key
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  title                   :string
#  mentor_character_id     :integer
#  dialog_node_list        :json
#  last_skills_import_date :datetime
#  chat_character_id       :integer
#

class ChatLearnObjSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :chat_character_id, :mentor_character_id, :last_skills_import_date, :dialog_node_list

  attribute :chat_character do |chat_learn_obj|
    WorldOrgCharacterTrimmedSerializer.new(chat_learn_obj.chat_character)
                                      .as_json['data']
  end

  attribute :mentor_character do |chat_learn_obj|
    WorldOrgCharacterTrimmedSerializer.new(chat_learn_obj.mentor_character)
                                      .as_json['data']
  end

  attribute :assistant_dialog_skill
end
