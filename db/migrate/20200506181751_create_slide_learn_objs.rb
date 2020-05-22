# frozen_string_literal: true

class CreateSlideLearnObjs < ActiveRecord::Migration[6.0]
  def change
    create_table :slide_learn_objs, &:timestamps
  end
end
