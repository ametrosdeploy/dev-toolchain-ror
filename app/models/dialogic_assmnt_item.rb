# frozen_string_literal: true

# == Schema Information
#
# Table name: dialogic_assmnt_items
#
#  id                      :bigint           not null, primary key
#  key_topic_id            :bigint           not null
#  assessment_label_id     :bigint           not null
#  value_count_min         :integer
#  value_count_max         :integer
#  points                  :float
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  have_follow_up_question :boolean          default(FALSE)
#
class DialogicAssmntItem < ApplicationRecord
  # Associations ...
  belongs_to :key_topic
  belongs_to :assessment_label
  has_one :follow_up_question, as: :follow_up_able, dependent: :destroy
  has_many :required_key_topic_values, dependent: :destroy
  has_many :dialogic_responses, dependent: :destroy
  has_many :debriefs, as: :debriefable

  # Nested Attributes ...
  accepts_nested_attributes_for :follow_up_question, allow_destroy: true
  accepts_nested_attributes_for :required_key_topic_values, allow_destroy: true
  accepts_nested_attributes_for :dialogic_responses, allow_destroy: true
  accepts_nested_attributes_for :debriefs, allow_destroy: true
end
