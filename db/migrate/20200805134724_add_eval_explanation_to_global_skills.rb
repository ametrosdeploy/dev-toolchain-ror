class AddEvalExplanationToGlobalSkills < ActiveRecord::Migration[6.0]
  def change
    add_column :global_skills, :eval_explanation, :text
  end
end
