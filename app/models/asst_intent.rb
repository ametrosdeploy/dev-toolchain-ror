# frozen_string_literal: true

# == Schema Information
#
# Table name: asst_intents
#
#  id                 :bigint           not null, primary key
#  name               :string
#  description        :text
#  learning_object_id :bigint           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class AsstIntent < ApplicationRecord
  # Associations ...
  belongs_to :learning_object
  has_many :asst_intent_examples, dependent: :destroy

  # Validations ...
  validates :name, presence: true
  validates_uniqueness_of :name, scope: :learning_object_id

  # Nested Attributes ...
  accepts_nested_attributes_for :asst_intent_examples, allow_destroy: true

  # Callbacks ...
  after_destroy :destroy_intent_from_watson

  def destroy_intent_from_watson
    learn_obj = learning_object
    intent_hsh = { learning_object: learn_obj,
                   learn_mod: learn_obj.learn_mod,
                   intent_name: name }
    handler = AsstElementHandler::Intent.new(intent_hsh)
    handler.remove_intent
  end

  # Methods ...
  def self.import(file, obj_id)
    CSV.foreach(file.path, headers: false) do |row|
      example = row[0]
      intent = row[1]
      # Have to find a way to add/ update intent & examples
      intent = find_or_create_by(name: intent, learning_object_id: obj_id)
      intent.asst_intent_examples.find_or_create_by(example: example)
    end
  end

  def self.generate(intent, examples, obj_id)
    intent = find_or_create_by(name: intent, learning_object_id: obj_id)
    examples.each do |example|
      intent.asst_intent_examples.find_or_create_by(
        example: example
      )
    end
  end
end
