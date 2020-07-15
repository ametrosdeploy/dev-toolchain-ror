class AddInWatsonToAsstIntent < ActiveRecord::Migration[6.0]
  def change
    add_column :asst_intents, :in_watson, :boolean, default: false
    add_column :asst_intent_examples, :in_watson, :boolean, default: false
  end
end
