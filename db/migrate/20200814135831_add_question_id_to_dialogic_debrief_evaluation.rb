class AddQuestionIdToDialogicDebriefEvaluation < ActiveRecord::Migration[6.0]
  def change
    add_reference :dialogic_debrief_evaluations, :dialogic_question, foreign_key: true
  end
end
