# == Schema Information
#
# Table name: learning_objects
#
#  id                   :bigint           not null, primary key
#  learning_module_id   :bigint           not null
#  objectable_type      :string
#  objectable_id        :bigint
#  learning_object_type :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class LearningObject < ApplicationRecord
  belongs_to :learn_mod
  belongs_to :objectable
end
