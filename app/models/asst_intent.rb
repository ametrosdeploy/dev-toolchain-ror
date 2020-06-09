# frozen_string_literal: true

# == Schema Information
#
# Table name: asst_intents
#
#  id                 :bigint           not null, primary key
#  name               :string
#  description        :text
#  learning_object_id :bigint           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class AsstIntent < ApplicationRecord
  # Associations ...
  belongs_to :learning_object

  # Callbacks ...
  after_destroy :destroy_intent_from_watson

  def destroy_intent_from_watson
    learn_obj = learning_object
    intent_hsh = { learning_object: learn_obj,
                   learn_mod: learn_obj.learn_mod,
                   intent_name: name }
    handler = AsstElementHandler::Intent.new(intent_hsh)
    handler.remove_intent
  end
end
