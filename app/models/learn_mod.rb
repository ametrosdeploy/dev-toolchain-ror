class LearnMod < ApplicationRecord
  belongs_to :world
  has_many :learning_objects
  has_many :chat_learn_objs, through: :learning_objects, source: :objectable, source_type: 'ChatLearnObj'
end