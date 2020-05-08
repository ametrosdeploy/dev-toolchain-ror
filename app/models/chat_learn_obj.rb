class ChatLearnObj < ApplicationRecord
    # Associations ...
    #    has_one :learn_obj, :as =>:object
    #    has_one :learn_mod, :through => :learn_obj
    belongs_to :chat_character, class_name: 'WorldOrgCharacter'
    belongs_to :mentor_character, class_name: 'WorldOrgCharacter', optional: true
end
