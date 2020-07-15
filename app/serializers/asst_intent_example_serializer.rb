# frozen_string_literal: true

# == Schema Information
#
# Table name: asst_intent_examples
#
#  id             :bigint           not null, primary key
#  example        :text
#  asst_intent_id :bigint           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  in_watson      :boolean          default(FALSE)
#
class AsstIntentExampleSerializer
  include FastJsonapi::ObjectSerializer
  attributes :example, :in_watson
end
