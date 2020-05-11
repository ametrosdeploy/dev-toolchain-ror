# == Schema Information
#
# Table name: learning_objects
#
#  id                   :bigint           not null, primary key
#  learning_module_id   :bigint           not null
#  objectable_type      :string
#  objectable_id        :bigint
#  learning_object_type :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  card_order           :integer
#
class LearningObject < ApplicationRecord
  belongs_to :learning_module
  belongs_to :objectable, polymorphic: true
  # enum learning_object_type [:email_interaction, :dialogic_interaction, :chat_learn_obj]
  # validates :learning_object_type, inclusion: { in: learning_object_types.keys }
  validates :card_order, numericality: { only_integer: true }, presence: true

end
