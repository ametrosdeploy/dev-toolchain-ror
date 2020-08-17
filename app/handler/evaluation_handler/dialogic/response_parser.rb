# frozen_string_literal: true

module EvaluationHandler
  module Dialogic
    # Sent response to Watson and parse entities ...
    class ResponseParser
      def initialize(args)
        @learn_obj = args[:learn_obj]
        @key_topics = args[:qstn_key_topics]
        @answer = args[:answer]
        @entity_details = []
        @result = nil
      end

      def parse
        prepare_for_assisstant_connection
        @result = sent_response_to_watson
        collect_entity_details
      end

      def prepare_for_assisstant_connection
        learn_mod = @learn_obj.learn_mod
        @guid = learn_mod.asst_service_instance&.guid
        @skill_id = @learn_obj.assistant_dialog_skill&.skill_id
      end

      def sent_response_to_watson
        @assistant_service = AssistantService.new(@guid, @skill_id)
        response = @assistant_service.get_response(@answer&.squish)
        response.result
      end

      def collect_entity_details
        entity_result.each do |key, value_arr|
          entity_name = key
          values = []
          value_arr.each do |value_info|
            values << value_info['value']
          end
          values.uniq!
          key_topic_id = find_key_topic_id(entity_name)
          @entity_details << { entity: entity_name, values: values,
                               key_topic_id: key_topic_id }
        end
        @entity_details
      end

      def entity_result
        entity_info = @result['entities']
        entity_info.group_by { |h| h['entity'] }
      end

      def find_key_topic_id(entity)
        @key_topics.joins(:asst_entity)
                   .find_by('asst_entities.name = ?', entity)&.id
      end
    end
  end
end
