# frozen_string_literal: true

# Migration to create table for Quiz MCQ options...
class CreateMcqOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :mcq_options do |t|
      t.integer :order
      t.text :option
      t.boolean :is_correct, default: false
      t.references :quiz_question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
