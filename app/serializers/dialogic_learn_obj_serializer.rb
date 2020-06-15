# frozen_string_literal: true

# Serializer for Dialogic LearnObj
class DialogicLearnObjSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :character_id, :repeat_interaction,
             :max_repeat_count, :unlimited_repeats
end
