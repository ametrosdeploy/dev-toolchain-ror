class CreateDialogicDebriefSuggestedContents < ActiveRecord::Migration[6.0]
  def change
    create_table :dialogic_debrief_suggested_contents do |t|
      t.references :dialogic_debrief_evaluation, null: false, foreign_key: true, index: { name: :dialogic_debrief_evaluation_index }
      t.references :adaptive_content, null: false, foreign_key: true, index: { name: :adaptive_content_index }

      t.timestamps
    end
  end
end
