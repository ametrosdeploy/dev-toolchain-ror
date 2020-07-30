class CreateChatEvaluations < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_evaluations do |t|
      t.bigint :user_learn_obj_id
      t.bigint :overall_assmnt_item_id
      t.boolean :complete, default: false, null: false

      t.timestamps
    end
  end
end
