# == Schema Information
#
# Table name: learning_modules
#
#  id               :bigint           not null, primary key
#  name             :string
#  time_to_complete :integer
#  abstract         :text
#  world_id         :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class LearningModule < ApplicationRecord
  belongs_to :world
  has_many :learning_objects, dependent: :destroy
  has_many :email_interactions, through: :learning_objects, source: :objectable, source_type: 'EmailInteraction'
  has_many :dialogic_interactions, through: :learning_objects, source: :objectable, source_type: 'DialogicInteraction'
  has_many :chat_learn_objs, through: :learning_objects, source: :objectable, source_type: 'ChatLearnObj' 

  validates :name, presence: true
  validates_uniqueness_of :name, case_sensitive: false
  validates :time_to_complete, numericality: { only_integer: true }, presence: true

  accepts_nested_attributes_for :learning_objects
  accepts_nested_attributes_for :chat_learn_objs

end
