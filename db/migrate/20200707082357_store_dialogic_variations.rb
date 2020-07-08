class StoreDialogicVariations < ActiveRecord::Migration[6.0]
  def change
    add_column :dialogic_evaluations, :variation_order_ids, :integer,
               array: true, default: []
    add_column :dialogic_evaluations, :user_variation_ids, :integer,
               array: true, default: []
    add_column :quiz_evaluations, :question_order_ids, :integer,
               array: true, default: []
  end
end
