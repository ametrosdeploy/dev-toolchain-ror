# frozen_string_literal: true

require 'json'
require 'ibm_watson/authenticators'
require 'ibm_watson/natural_language_understanding_v1'

# Watson NLU Service ...
class NluService < BaseService
  include IBMWatson

  def initialize(msg)
    super()
    connect_nlu
    @response = analyze_text(msg)
    @result = @response.result
  end

  def success?
    success_status_code = [200, 201]
    success_status_code.include?(@response.status)
  end

  def connect_nlu
    authenticator = Authenticators::IamAuthenticator.new(
      apikey: ENV['NLU_API_KEY']
    )

    @nlu = NaturalLanguageUnderstandingV1.new(
      version: '2019-07-12',
      authenticator: authenticator
    )
    @nlu.service_url = ENV['NLU_URL']
  end

  def analyze_text(msg)
    @nlu.analyze(
      text: msg,
      features: {
        entities: {
          limit: 20
        },
        keywords: {
          limit: 20
        },
        concepts: {
          limit: 20
        },
        sentiment: {},
        emotion: {},
        semantic_roles: {},
        categories: {}
      }
    )
  end

  def entities
    entities_arr = []
    hsh = @result['entities']
    hsh.each do |entity|
      entities_arr << {
        entity: entity['text'],
        entity_type: entity['type'],
        score: entity['relevance']
      }
    end
    entities_arr
  end

  def keywords
    keywords_arr = []
    hsh = @result['keywords']
    hsh.each do |keyword|
      keywords_arr << {
        keyword: keyword['text'],
        relevance: keyword['relevance']
      }
    end
    keywords_arr
  end

  def concepts
    concepts_arr = []
    hsh = @result['concepts']
    hsh.each do |concept|
      concepts_arr << {
        concept: concept['text'],
        score: concept['relevance']
      }
    end
    concepts_arr
  end

  def sentiment
    hsh = @result['sentiment']['document']
    { sentiment: hsh['label'], score: hsh['score'] }
  end

  def emotion
    hsh = @result['emotion']['document']['emotion']
    { sadness: hsh['sadness'], joy: hsh['joy'], fear: hsh['fear'],
      disgust: hsh['disgust'], anger: hsh['anger'] }
  end

  def semantic_roles
    arr = []
    roles = @result['semantic_roles']
    roles.each do |role|
      hsh = { sentence: role['sentence'],
              object: role['object']&.[](:text),
              subject: role['subject']['text'] }
      hsh = add_action(hsh, role)
      arr << hsh
    end
    arr
  end

  def add_action(hsh, role)
    action = role['action']
    verb = action['verb']
    hsh.merge(action_verb_txt: verb['text'],
              action_verb_tense: verb['tense'],
              action_txt: action['text'],
              action_txt_normalized: action['normalized'])
  end

  def nlu_categories
    categories_arr = []
    hsh = @result['categories']
    hsh.each do |category|
      categories_arr << {
        hierarchy: category['label'],
        score: category['score']
      }
    end
    categories_arr
  end

  def nlu_syntaxes
    syntax_arr = []
    tokens = @result['syntax']['tokens']
    tokens.each do |token|
      syntax_arr << {
        token: token['text'],
        part_of_speech: token['part_of_speech'],
        lemma: token['lemma']
      }
    end
    syntax_arr
  end
end
