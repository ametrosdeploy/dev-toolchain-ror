class AddFromIdealInputToNluSentiment < ActiveRecord::Migration[6.0]
  def change
    add_column :nlu_sentiments, :from_ideal_input, :boolean
  end
end
