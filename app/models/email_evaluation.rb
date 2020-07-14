# == Schema Information
#
# Table name: email_evaluations
#
#  id                :bigint           not null, primary key
#  user_learn_obj_id :bigint           not null
#  email             :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class EmailEvaluation < ApplicationRecord
  belongs_to :user_learn_obj
end
