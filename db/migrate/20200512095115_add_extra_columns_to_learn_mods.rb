class AddExtraColumnsToLearnMods < ActiveRecord::Migration[6.0]
  def change
    add_column :learn_mods, :unique_code, :integer, null: false
    add_index  :learn_mods, :unique_code, unique: true
    add_column :learn_mods, :learning_objects_count, :integer, default: 0
    add_column :learn_mods, :description, :text
    add_column :learn_mods, :lead_designer_id, :integer
    add_column :learn_mods, :sme_id, :integer
    add_column :learn_mods, :learning_objectives, :text
    add_column :learn_mods, :notes, :text
    add_column :learn_mods, :cached_skill_list, :string
  end
end
