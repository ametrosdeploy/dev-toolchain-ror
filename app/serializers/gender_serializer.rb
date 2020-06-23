# frozen_string_literal: true

# == Schema Information
#
# Table name: genders
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class GenderSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name
end
