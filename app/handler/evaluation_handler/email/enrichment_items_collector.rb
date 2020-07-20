# frozen_string_literal: true

module EvaluationHandler
  module Email
    # Save enrichment items of email submission ...
    class EnrichmentItemsCollector
      def initialize(user_email, user_email_evaluation, learn_obj)
        @user_email = user_email
        @user_email_evaluation = user_email_evaluation
        @nlu_service = NluService.new(@user_email)
        @learn_obj = learn_obj
        @asst_result = send_email_to_assistant
        @enrichment_args = {}
      end

      def collect
        return unless @nlu_service.success? && @asst_result.present?

        add_emotion_and_sentiment
        add_concept_keyword_entities
        @enrichment_args.merge!(asst_intent_list: asst_intents,
                                asst_entity_value_list: asst_entity_values)
        @user_email_evaluation.update(@enrichment_args)
      end

      # NLU Items ...
      def add_emotion_and_sentiment
        emotions = @nlu_service.emotion
        sentiment = @nlu_service.sentiment
        @enrichment_args.merge!(joy_score: emotions[:joy],
                                anger_score: emotions[:anger],
                                disgust_score: emotions[:fear],
                                sadness_score: emotions[:sadness],
                                fear_score: emotions[:disgust],
                                sentiment: sentiment[:sentiment],
                                sentiment_score: sentiment[:score])
      end

      def add_concept_keyword_entities
        concepts = @nlu_service.concepts&.pluck(:concept)
        keywords = @nlu_service.keywords&.pluck(:keyword)
        nlu_entities = @nlu_service.entities&.pluck(:entity)
        @enrichment_args.merge!(concept_list: concepts,
                                keyword_list: keywords,
                                nlu_entities_list: nlu_entities)
      end

      # Assisstant processing ...
      def send_email_to_assistant
        learn_mod = @learn_obj.learn_mod
        guid = learn_mod.asst_service_instance&.guid
        skill_id = @learn_obj.assistant_dialog_skill&.skill_id
        @assistant_service = AssistantService.new(guid, skill_id)
        response = @assistant_service.get_response(@user_email)
        response.result
      end

      def asst_intents
        @asst_result['intents']&.pluck('intent')
      end

      def asst_entity_values
        entities = @asst_result['entities']
        entity_value_ids = []
        entities.each do |entity_hsh|
          entity = entity_hsh['entity']
          val = entity_hsh['value']
          lo_entity = learn_obj_asst_entities.find_by(name: entity)
          entity_val = lo_entity.asst_entity_values.find_by(value: val)
          entity_value_ids << entity_val&.id
        end
        entity_value_ids.compact
      end

      def learn_obj_asst_entities
        @learn_obj.asst_entities.includes(:asst_entity_values)
      end
    end
  end
end
