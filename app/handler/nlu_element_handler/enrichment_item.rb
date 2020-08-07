# frozen_string_literal: true

module NluElementHandler
  # Common code for all Asst Elements
  class EnrichmentItem
    # get the credentials and connect asst...
    def initialize(args)
      @lo = args[:learning_object]
      ideal_inputs = @lo.nlu_training_inputs
      inputs_arr = ideal_inputs&.pluck(:message)
      input = inputs_arr.join(',')
      @nlu_service = NluService.new(input)
      @errors = []
      @response = nil
    end

    def errors(msg)
      @errors << msg
    end

    def full_messages
      @errors.join(', ')
    end

    def save_enrichment_items
      if @nlu_service.success?
        clear_existing_nlu_data
        save_concepts
        save_keywords
        save_entities
        save_sentiment
        save_emotion
        save_categories
        save_semantic_roles
        # save_syntaxes
      else
        errors(@nlu_service.response)
      end
    end

    def clear_existing_nlu_data
      @lo.nlu_concepts&.destroy_all
      @lo.nlu_entities&.destroy_all
      @lo.nlu_keywords&.destroy_all
      @lo.nlu_emotion_score&.destroy
      @lo.nlu_sentiment&.destroy
    end

    def save_concepts
      concepts = @nlu_service.concepts
      return unless concepts.present?

      NluConcept.insert_all(attr_hsh(concepts))
    end

    def save_keywords
      keywords = @nlu_service.keywords
      return unless keywords.present?

      NluKeyword.insert_all(attr_hsh(keywords))
    end

    def save_entities
      entities = @nlu_service.entities
      return unless entities.present?

      NluEntity.insert_all(attr_hsh(entities))
    end

    def save_sentiment
      sentiment = @nlu_service.sentiment
      return unless sentiment.present?

      sentiment.merge!(learning_object_id: @lo.id)
      NluSentiment.create(sentiment)
    end

    def save_emotion
      emotion = @nlu_service.emotion
      return unless emotion.present?

      emotion.merge!(learning_object_id: @lo.id)
      NluEmotionScore.create(emotion)
    end

    def save_categories
      categories = @nlu_service.nlu_categories
      return unless categories.present?

      NluCategory.insert_all(attr_hsh(categories))
    end

    def save_semantic_roles
      semantic_roles = @nlu_service.semantic_roles
      return unless semantic_roles.present?

      NluSemanticRole.insert_all(attr_hsh(semantic_roles))
    end

    def save_syntaxes
      syntaxes = @nlu_service.nlu_syntaxes
      return unless syntaxes.present?

      NluSyntax.insert_all(attr_hsh(syntaxes))
    end

    def attr_hsh(arr)
      arr.map do |hsh|
        hsh.merge!(learning_object_id: @lo.id,
                   created_at: DateTime.now,
                   updated_at: DateTime.now)
      end
    end
  end
end
