class AddColumnStatueToUserSections < ActiveRecord::Migration[6.0]
  def change
    add_column :user_sections, :status, :integer, default: 0
  end
end
