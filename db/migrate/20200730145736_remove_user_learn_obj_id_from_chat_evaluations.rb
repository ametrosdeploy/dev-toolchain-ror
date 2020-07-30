class RemoveUserLearnObjIdFromChatEvaluations < ActiveRecord::Migration[6.0]
  def change

    remove_column :chat_evaluations, :user_learn_obj_id, :bigint
  end
end
