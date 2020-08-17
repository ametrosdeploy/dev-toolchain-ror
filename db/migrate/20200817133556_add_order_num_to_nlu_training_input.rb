class AddOrderNumToNluTrainingInput < ActiveRecord::Migration[6.0]
  def change
    add_column :nlu_training_inputs, :order_num, :integer
  end
end
