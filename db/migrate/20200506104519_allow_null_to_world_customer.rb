class AllowNullToWorldCustomer < ActiveRecord::Migration[6.0]
  def change
    change_column :worlds, :customer_id, :integer, null: true
  end
end
