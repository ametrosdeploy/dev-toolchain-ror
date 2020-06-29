class AddFollowUpableInFollowUpQuestion < ActiveRecord::Migration[6.0]
  def change
    add_reference :follow_up_questions, :follow_up_able, polymorphic: true, index: { name: :follow_up_able_index }
    remove_reference :follow_up_questions, :dialogic_assmnt_item, index: true
  end
end
