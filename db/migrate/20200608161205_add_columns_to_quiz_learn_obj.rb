# frozen_string_literal: true

# Migration to assement related columns to Quiz LO ...
class AddColumnsToQuizLearnObj < ActiveRecord::Migration[6.0]
  def change
    add_column :quiz_learn_objs, :overall_assessment_required,
               :boolean, default: false
    add_column :quiz_learn_objs, :overall_module_assessment_inclusion,
               :boolean, default: false
  end
end
