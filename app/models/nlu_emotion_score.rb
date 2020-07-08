# frozen_string_literal: true

# == Schema Information
#
# Table name: nlu_emotion_scores
#
#  id                 :bigint           not null, primary key
#  learning_object_id :bigint           not null
#  sadness            :float
#  joy                :float
#  fear               :float
#  disgust            :float
#  anger              :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  from_ideal_input   :boolean
#
class NluEmotionScore < ApplicationRecord
  # Associations ...
  belongs_to :learning_object
  belongs_to :enrichment_item, polymorphic: true
end
