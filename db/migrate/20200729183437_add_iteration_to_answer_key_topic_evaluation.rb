class AddIterationToAnswerKeyTopicEvaluation < ActiveRecord::Migration[6.0]
  def change
    add_column :answer_key_topic_evaluations, :iteration_delivered, :integer
  end
end
