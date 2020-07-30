# == Schema Information
#
# Table name: chat_evaluations
#
#  id                     :bigint           not null, primary key
#  user_learn_obj_id      :bigint
#  overall_assmnt_item_id :bigint
#  complete               :boolean          default(FALSE), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
require 'rails_helper'

RSpec.describe ChatEvaluation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
