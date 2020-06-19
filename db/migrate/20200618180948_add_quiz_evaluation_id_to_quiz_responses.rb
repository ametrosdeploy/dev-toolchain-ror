class AddQuizEvaluationIdToQuizResponses < ActiveRecord::Migration[6.0]
  def change
    add_reference :quiz_responses, :quiz_evaluation, null: false, foreign_key: true
  end
end
