class ChangeQuizEvalTable < ActiveRecord::Migration[6.0]
  def change
    change_column :quiz_evaluations, :user_learn_obj_id, :bigint, null: true
    if foreign_key_exists?(:quiz_evaluations, :user_learn_objs)
      remove_foreign_key :quiz_evaluations, :user_learn_objs
    end
    add_column :quiz_evaluations, :learning_object_id, :bigint
  end
end
