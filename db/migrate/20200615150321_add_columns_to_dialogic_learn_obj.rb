class AddColumnsToDialogicLearnObj < ActiveRecord::Migration[6.0]
  def change
    add_column :dialogic_learn_objs, :title, :string
    add_column :dialogic_learn_objs, :character_id, :integer
    add_column :dialogic_learn_objs, :repeat_interaction, :boolean, default: false
    add_column :dialogic_learn_objs, :max_repeat_count, :integer
    add_column :dialogic_learn_objs, :unlimited_repeats, :boolean, default: false
  end
end
