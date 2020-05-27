# frozen_string_literal: true

# Migration to add column archived_on on learning_objects
class ArchivedOnOnLearningObjects < ActiveRecord::Migration[6.0]
  def change
    add_column :learning_objects, :archived_on, :datetime
  end
end
