# frozen_string_literal: true

# == Schema Information
#
# Table name: quiz_learn_objs
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class QuizLearnObj < ApplicationRecord
    enum score_view_type: %i[numeric percentage]

    # Associations ...
    has_one :learning_object, as: :objectable
    has_one :learn_mod, through: :learning_objects
end
