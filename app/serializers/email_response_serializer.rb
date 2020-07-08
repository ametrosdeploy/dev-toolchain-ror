# frozen_string_literal: true

# == Schema Information
#
# Table name: email_responses
#
#  id                 :bigint           not null, primary key
#  name               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  email_learn_obj_id :bigint           not null
#
class EmailResponseSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name
end
