# frozen_string_literal: true

class CreateDialogicLearnObjs < ActiveRecord::Migration[6.0]
  def change
    create_table :dialogic_learn_objs, &:timestamps
  end
end
