# frozen_string_literal: true

class CreateQuizLearnObjs < ActiveRecord::Migration[6.0]
  def change
    create_table :quiz_learn_objs, &:timestamps
  end
end
