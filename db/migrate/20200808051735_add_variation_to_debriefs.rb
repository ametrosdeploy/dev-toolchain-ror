class AddVariationToDebriefs < ActiveRecord::Migration[6.0]
  def change
    add_column :debriefs, :variation, :integer
  end
end
