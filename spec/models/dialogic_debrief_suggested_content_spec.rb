# == Schema Information
#
# Table name: dialogic_debrief_suggested_contents
#
#  id                             :bigint           not null, primary key
#  dialogic_debrief_evaluation_id :bigint           not null
#  adaptive_content_id            :bigint           not null
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#
require 'rails_helper'

RSpec.describe DialogicDebriefSuggestedContent, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
