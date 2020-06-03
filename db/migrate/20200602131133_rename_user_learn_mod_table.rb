# frozen_string_literal: true

# Migration to rename column  user_learn_mods to user_sections
class RenameUserLearnModTable < ActiveRecord::Migration[6.0]
  def change
    rename_table :user_learn_mods, :user_sections
    add_column :slide_learn_objs, :has_caption, :boolean, default: true
    add_column :user_sections, :completed_count, :integer, default: 0
    rename_column :user_learn_objs, :user_learn_mod_id, :user_section_id
    change_column :user_learn_objs, :complete, :boolean, default: false
  end
end
