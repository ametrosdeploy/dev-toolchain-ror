# frozen_string_literal: true

# == Schema Information
#
# Table name: qa_conditions
#
#  id                 :bigint           not null, primary key
#  email_learn_obj_id :bigint           not null
#  character_id       :integer
#  ooto_response      :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class QaCondition < ApplicationRecord
   # Associations ...
  belongs_to :email_learn_obj
  has_many :qa_formulas, dependent: :destroy
end
