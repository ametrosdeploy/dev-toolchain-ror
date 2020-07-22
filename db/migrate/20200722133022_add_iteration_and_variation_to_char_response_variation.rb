class AddIterationAndVariationToCharResponseVariation < ActiveRecord::Migration[6.0]
  def change
    add_column :char_response_variations, :iteration, :integer
    add_column :char_response_variations, :variation, :integer
  end
end
