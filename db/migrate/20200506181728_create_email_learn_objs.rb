# frozen_string_literal: true

class CreateEmailLearnObjs < ActiveRecord::Migration[6.0]
  def change
    create_table :email_learn_objs, &:timestamps
  end
end
