class AddExtraColumnForQuiz < ActiveRecord::Migration[6.0]
  def change
    add_column :quiz_evaluations, :quiz_complete, :boolean, default: false
    # add_column :quiz_learn_objs, :quiz_questions_count, :integer, default: 0
  end
end
