class RemoveUserLearnObjIdFromQuizResponse < ActiveRecord::Migration[6.0]
  def change
    remove_reference :quiz_responses, :user_learn_obj, null: false, foreign_key: true
  end
end
