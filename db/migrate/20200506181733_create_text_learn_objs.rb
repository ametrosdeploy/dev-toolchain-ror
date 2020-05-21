# frozen_string_literal: true

class CreateTextLearnObjs < ActiveRecord::Migration[6.0]
  def change
    create_table :text_learn_objs, &:timestamps
  end
end
