# frozen_string_literal: true

# Remove retry fields ...
class RemoveRetryFieldsFromDialogicLearnObj < ActiveRecord::Migration[6.0]
  def change
    remove_column :dialogic_learn_objs, :repeat_interaction, :boolean
    remove_column :dialogic_learn_objs, :max_repeat_count, :integer
    remove_column :dialogic_learn_objs, :unlimited_repeats, :boolean
  end
end
