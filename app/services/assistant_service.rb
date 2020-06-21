# frozen_string_literal: true

require 'json'
require 'ibm_watson/authenticators'
require 'ibm_watson/assistant_v1'
# Watson Assistant related requests
class AssistantService < BaseService
  include IBMWatson

  def initialize(instance_guid, skill_id = nil)
    super()
    instance_url = ENV['ASST_SERVICE_BASE_URL'] + instance_guid
    @assistant = connect_assistant(instance_url)
    @skill_id = skill_id
  end

  def connect_assistant(instance_url)
    authenticator = Authenticators::IamAuthenticator.new(
      apikey: ENV['SERVICE_ID_API_KEY']
    )
    @assistant = AssistantV1.new(
      version: '2020-02-05',
      authenticator: authenticator
    )
    @assistant.service_url = instance_url
    @assistant
  end

  def create_dialog_skill(name, desc = nil)
    @assistant.create_workspace(
      name: name,
      description: desc
    )
  end

  def delete_dialog_skill
    @assistant.delete_workspace(
      workspace_id: @skill_id
    )
  end

  def create_entity(name)
    @assistant.create_entity(
      workspace_id: @skill_id,
      entity: name
    )
  end

  def create_entity_synonym(entity, entity_val, synonym)
    @assistant.create_synonym(
      workspace_id: @skill_id,
      entity: entity,
      value: entity_val,
      synonym: synonym
    )
  end

  def create_entity_value(entity, entity_val, synonym_arr)
    @assistant.create_value(
      workspace_id: @skill_id,
      entity: entity,
      value: entity_val,
      synonyms: synonym_arr
    )
  end

  def update_entity_value(entity, entity_val,
                          entity_val_new, new_synonyms = nil)
    value_hsh = { workspace_id: @skill_id,
                  entity: entity,
                  value: entity_val,
                  new_value: entity_val_new }
    value_hsh.merge!(new_synonyms: new_synonyms) if new_synonyms
    @assistant.update_value(value_hsh)
  end

  def create_entity_value_synonyms(entity, entity_val, synonyms)
    synonyms.each do |synonym|
      synonym_hsh = { workspace_id: @skill_id,
                      entity: entity,
                      value: entity_val,
                      synonym: synonym }
      @assistant.create_synonym(synonym_hsh)
    end
  end

  def remove_entity_value_synonyms(entity, entity_val, synonyms)
    synonyms.each do |synonym|
      @assistant.delete_synonym(
        workspace_id: @skill_id,
        entity: entity,
        value: entity_val,
        synonym: synonym
      )
      @assistant.delete_synonym(synonym_hsh)
    end
  end

  def create_intent(intent_name, examples = nil)
    intent_examples = examples&.map { |example| { text: example } }
    @assistant.create_intent(
      workspace_id: @skill_id,
      intent: intent_name,
      examples: intent_examples
    )
  end

  def delete_intent(intent_name)
    @assistant.delete_intent(
      workspace_id: @skill_id,
      intent: intent_name
    )
  end

  # Dialog Node Section ...
  def create_dialog_node(name, condition, title, responses)
    hsh = {
      workspace_id: @skill_id,
      dialog_node: name,
      conditions: condition,
      title: title
    }
    hsh.merge!({ output: { generic: responses } }) if responses
    @assistant.create_dialog_node(hsh)
  end

  def update_dialog_node(name, condition)
    @assistant.update_dialog_node(
      workspace_id: @skill_id,
      dialog_node: name,
      new_conditions: condition
    )
  end

  def delete_dialog_node(name)
    @assistant.delete_dialog_node(
      workspace_id: @skill_id,
      dialog_node: name
    )
  end

  def get_dialog_node(name)
    @assistant.get_dialog_node(
      workspace_id: @skill_id,
      dialog_node: name
    )
  end

  # Response ...
  def get_response(user_input)
    @assistant.message(
      workspace_id: @skill_id,
      input: {
        text: user_input
      }
    )
  end
end
