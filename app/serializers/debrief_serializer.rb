# frozen_string_literal: true

# == Schema Information
#
# Table name: debriefs
#
#  id               :bigint           not null, primary key
#  content          :text
#  debriefable_type :string           not null
#  debriefable_id   :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  variation        :integer
#
class DebriefSerializer
  include FastJsonapi::ObjectSerializer
  attributes :content, :debriefable_type, :debriefable_id, :variation
end
