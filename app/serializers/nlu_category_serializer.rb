# frozen_string_literal: true

# == Schema Information
#
# Table name: nlu_categories
#
#  id                 :bigint           not null, primary key
#  learning_object_id :bigint           not null
#  hierarchy          :string
#  score              :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class NluCategorySerializer
  include FastJsonapi::ObjectSerializer
  attributes :hierarchy, :score
end
