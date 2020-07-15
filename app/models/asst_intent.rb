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
#  in_watson          :boolean          default(FALSE)
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
    intents_list = []
    CSV.foreach(file.path, headers: false) do |row|
      example = row[0]
      intent = row[1]
      rec = find_or_create_by(name: intent, learning_object_id: obj_id)
      intents_list << rec
      rec.asst_intent_examples.find_or_create_by(example: example)
    end
    intents_list.uniq!
    intents_list.each do |intent_rec|
      intent_handler = intent_rec.intent_handler_obj
      unless intent_rec.in_watson             
        intent_handler.create_intent
        intent_rec.update(in_watson: true) if intent_handler.success?
      end
      examples = intent_rec.asst_intent_examples.where(in_watson: false)
      if examples
        ex_to_add = examples.map {|ex| { text: ex.example}}
        intent_handler.add_examples(ex_to_add) 
        examples.update_all(in_watson: true) if intent_handler.success?
      end
    end
  end

  def intent_handler_obj
    args = { learning_object: learning_object,
             learn_mod: learning_object.learn_mod,
             intent_name: name }
    AsstElementHandler::Intent.new(args)
  end

  def self.generate(intent, examples, obj_id)
    intent = find_or_create_by(name: intent, learning_object_id: obj_id)
    examples.each do |example|
      intent.asst_intent_examples.find_or_create_by(
        example: example
      )
    end
  end

  def record_examples_in_watson
    asst_intent_examples&.update_all(in_watson: true)
  end
end
