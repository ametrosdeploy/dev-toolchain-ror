# frozen_string_literal: true

# Migration to move description to learning_object table
class MoveDescriptionToLearningObj < ActiveRecord::Migration[6.0]
  def change
    remove_column :email_learn_objs, :description
    remove_column :text_learn_objs, :description
    remove_column :video_learn_objs, :description
    add_column :learning_objects, :description, :text
  end
end
