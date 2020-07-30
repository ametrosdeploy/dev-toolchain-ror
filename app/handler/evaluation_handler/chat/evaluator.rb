# frozen_string_literal: true

module EvaluationHandler
    module Chat
      # For evaluating chat interaction ...
      class Evaluator
        def initialize(chat_evaluation)
          @chat_evaluation = chat_evaluation
          @learn_obj = @chat_evaluation.user_learn_obj.learning_object
          @responses = @chat_evaluation.user_learn_obj.user_chat.user_chat_responses
          @chat_lo = @learn_obj.objectable
          @chat_pt = 0
        end
  
        def iterate_through_response_json  
            @responses.each do |response| 
                response.response_result_json get skills from the json 
                push the skills into an array?
            end
        end

        def calculate_skill_assessment(skill_id) 

        end  

        def calculate_missed_skill_assessment(skill_id)  

        end
  
        def add_overall_assessment(hsh)
          if @learn_obj.overall_assessment_required
            hsh.merge!(overall_assmnt_item_id:
              assessment_item&.id)
          end
          hsh
        end
  
        def assessment_item
          @learn_obj.overall_assmnt_items.find_by(
            'min_score <= :score AND max_score >= :score', { score: @score }
          )
        end
  
        
  
        def chat_complete?
            @chat_evaluation.user_learn_obj.complete
        end
      end
    end
  end
  