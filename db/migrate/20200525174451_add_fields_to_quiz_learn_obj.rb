# frozen_string_literal: true

# Migration to add fields to quiz_learn_obj table ...
class AddFieldsToQuizLearnObj < ActiveRecord::Migration[6.0]
  def change
    add_column :quiz_learn_objs, :title, :string
    add_column :quiz_learn_objs, :description, :text
    add_column :quiz_learn_objs, :score_view_type, :integer, default: 0
  end
end
