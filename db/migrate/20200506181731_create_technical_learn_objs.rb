# frozen_string_literal: true

class CreateTechnicalLearnObjs < ActiveRecord::Migration[6.0]
  def change
    create_table :technical_learn_objs, &:timestamps
  end
end
