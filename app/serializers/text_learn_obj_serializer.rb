# frozen_string_literal: true

# == Schema Information
#
# Table name: text_learn_objs
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string
#
class TextLearnObjSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title
end
