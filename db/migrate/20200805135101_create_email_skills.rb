class CreateEmailSkills < ActiveRecord::Migration[6.0]
  def change
    create_table :email_skills do |t|
      t.bigint :email_learn_obj_id
      t.bigint :global_skill_id
      t.text :eval_explanation

      t.timestamps
    end
  end
end
