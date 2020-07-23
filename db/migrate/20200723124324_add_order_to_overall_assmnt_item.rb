class AddOrderToOverallAssmntItem < ActiveRecord::Migration[6.0]
  def change
    add_column :overall_assmnt_items, :order, :integer
  end
end
