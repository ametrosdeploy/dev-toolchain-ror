class AddWatsonResponseToQuizResponse < ActiveRecord::Migration[6.0]
  def change
    add_column :quiz_responses, :watson_response, :text
  end
end
