# frozen_string_literal: true

# == Schema Information
#
# Table name: user_learn_objs
#
#  id                 :bigint           not null, primary key
#  user_learn_mod_id  :bigint           not null
#  complete           :boolean
#  learning_object_id :bigint           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class UserLearnObj < ApplicationRecord
  belongs_to :user_learn_mod
  belongs_to :learning_object
end
