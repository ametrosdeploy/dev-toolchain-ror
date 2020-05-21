# frozen_string_literal: true

class CreateFileLearnObjs < ActiveRecord::Migration[6.0]
  def change
    create_table :file_learn_objs, &:timestamps
  end
end
