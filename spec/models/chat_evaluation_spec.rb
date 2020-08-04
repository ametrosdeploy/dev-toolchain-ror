# == Schema Information
#
# Table name: chat_evaluations
#
#  id                     :bigint           not null, primary key
#  overall_assmnt_item_id :bigint
#  complete               :boolean          default(FALSE), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_chat_id           :bigint
#  skills_score_hash      :text
#  skills_missed          :text
#
require 'rails_helper'

RSpec.describe ChatEvaluation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
