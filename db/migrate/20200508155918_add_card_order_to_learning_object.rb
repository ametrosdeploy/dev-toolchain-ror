class AddCardOrderToLearningObject < ActiveRecord::Migration[6.0]
  def change
    add_column :learning_objects, :card_order, :integer
  end
end
