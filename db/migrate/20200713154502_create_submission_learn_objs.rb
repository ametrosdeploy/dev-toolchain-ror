class CreateSubmissionLearnObjs < ActiveRecord::Migration[6.0]
  def change
    create_table :submission_learn_objs do |t|
      t.boolean :has_text, default: false
      t.boolean :has_file_upload, default: false

      t.timestamps
    end
  end
end
