# == Schema Information
#
# Table name: chat_learn_objs
#
#  id                   :bigint           not null, primary key
#  administrative_notes :text
#  chat_character_id    :integer
#  mentor_character_id  :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class ChatLearnObjSerializer
  include FastJsonapi::ObjectSerializer
  attributes :administrative_notes
end
