class RenameCharacterResponseToCharResponseVariations < ActiveRecord::Migration[6.0]
  def change
    rename_table :character_responses, :char_response_variations
  end
end
