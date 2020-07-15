class ChangePointsToFloatInQuizQuestion < ActiveRecord::Migration[6.0]
  def change
    change_column :quiz_questions, :points, :float
  end
end
