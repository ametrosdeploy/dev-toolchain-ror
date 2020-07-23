class AddVariationToDialogicResponse < ActiveRecord::Migration[6.0]
  def change
    add_column :dialogic_responses, :variation, :integer
  end
end
