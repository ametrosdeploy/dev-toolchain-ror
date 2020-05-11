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
class ChatLearnObj < ApplicationRecord
    # Associations ...
    has_one :learning_object, as: :objectable
    has_one :learning_module, through: :learning_objects
    belongs_to :chat_character, class_name: 'WorldOrgCharacter'
    belongs_to :mentor_character, class_name: 'WorldOrgCharacter', optional: true
end
