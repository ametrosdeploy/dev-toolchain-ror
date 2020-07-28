class AddIterationsToFollowUpQuestion < ActiveRecord::Migration[6.0]
  def change
    add_column :follow_up_questions, :iteration, :integer
  end
end
