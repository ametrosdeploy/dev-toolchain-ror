class AddInWatsonToAsstEntity < ActiveRecord::Migration[6.0]
  def change
    add_column :asst_entities, :in_watson, :boolean, default: false
    add_column :asst_entity_values, :in_watson, :boolean, default: false
    add_column :asst_entity_val_synonyms, :in_watson, :boolean, default: false
  end
end
