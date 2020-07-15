class AddNameToNluTrainingInput < ActiveRecord::Migration[6.0]
  def change
    add_column :nlu_training_inputs, :name, :string
  end
end
