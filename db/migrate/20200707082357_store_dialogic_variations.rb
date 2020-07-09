class StoreDialogicVariations < ActiveRecord::Migration[6.0]
  def change
    add_column :dialogic_evaluations, :variation_order_ids, :integer,
               array: true, default: []
    add_column :quiz_evaluations, :question_order_ids, :integer,
               array: true, default: []
    add_column :user_learn_objs, :used_variation_ids, :integer,
               array: true, default: []
    add_column :dialogic_answers, :question_variation_id, :integer
  end
end
