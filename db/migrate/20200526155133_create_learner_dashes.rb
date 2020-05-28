# frozen_string_literal: true

# Migration to make Learner Dashboard text dynamic
class CreateLearnerDashes < ActiveRecord::Migration[6.0]
  def change
    create_table :learner_dashes do |t|
      t.string :title, null: false
      t.text :description
      t.string :welcome_text, null: false

      t.timestamps
    end
  end
end
