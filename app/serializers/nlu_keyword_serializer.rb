# frozen_string_literal: true

# == Schema Information
#
# Table name: nlu_keywords
#
#  id                 :bigint           not null, primary key
#  learning_object_id :bigint           not null
#  keyword            :string
#  relevance          :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class NluKeywordSerializer
  include FastJsonapi::ObjectSerializer
  attributes :keyword, :relevance
end
