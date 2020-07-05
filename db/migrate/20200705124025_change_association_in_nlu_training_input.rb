class ChangeAssociationInNluTrainingInput < ActiveRecord::Migration[6.0]
  def change
    remove_reference :nlu_training_inputs, :email_learn_obj, null: false, foreign_key: true
    add_reference :nlu_training_inputs, :learning_object, foreign_key: true, index: true, null: false
  end
end
