# frozen_string_literal: true

# == Schema Information
#
# Table name: dialogic_learn_objs
#
#  id                 :bigint           not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  title              :string
#  character_id       :integer
#  repeat_interaction :boolean          default(FALSE)
#  max_repeat_count   :integer
#  unlimited_repeats  :boolean          default(FALSE)
#  introduction       :text
#  conclusion         :text
#
class DialogicLearnObjSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :character_id, :repeat_interaction,
             :max_repeat_count, :unlimited_repeats,
             :introduction, :conclusion

  attribute :questions do |learn_obj|
    DialogicQuestionsSerializer.new(learn_obj.dialogic_questions).as_json['data']
  end
end
