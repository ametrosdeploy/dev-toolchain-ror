# frozen_string_literal: true

module EvaluationHandler
    module Chat
      # For evaluating chat interaction ...
      class Evaluator
        def initialize(chat_evaluation)
          @chat_evaluation = chat_evaluation
          @learn_obj = @chat_evaluation.user_chat.user_learn_obj.learning_object
          @responses = @chat_evaluation.user_chat.user_learn_obj.user_chat.user_chat_responses
          @chat_lo = @learn_obj.objectable
          @chat_pt = 0
          @assistant_dialog_skill = @learn_obj.assistant_dialog_skill
        end

  
        def evaluate  
            # iterate through user_chat_responses to get json skills and values
            @responses.each do |response| 
                skill_json_text = response.response_result_json['output']['generic'][1]['text']

                skill_name = skill_json_text.split("; skill_value").first.split("[skill_name: ").last
                skill_value = skill_json_text.split("skill_value:").last.strip.gsub("]","")
                i = 0

                if skill_name.include?(",")
                    skill_names = skill_name.split(',') 
                    skill_values = skill_value.split(',')
                    skill_names.each do |skill_name_multi|
                        skill_value_multi = skill_values[i].to_i
                        i += 1
                        create_chat_evaluation_skill_record(skill_name_multi, skill_value_multi, response.id)
                    end 

                else 
                    create_chat_evaluation_skill_record(skill_name, skill_value, response.id)
                end 
                
                
            end
            calculate_skill_assessments 
            calculate_missed_skill_assessments 

        end

        def create_chat_evaluation_skill_record(skill_name, skill_value, user_chat_response_id)
            ChatEvaluationSkill.create(skill_name: skill_name, skill_value: skill_value, user_chat_response_id: user_chat_response_id, chat_evaluation_id: @chat_evaluation.id) 
        end

        def calculate_skill_assessments 
            skills_hit = ChatEvaluationSkill.where(id: @chat_evaluation.id)
            
        end  



        def calculate_missed_skill_assessments  
            all_chat_skills = ChatSkill.where(assistant_dialog_skill_id: @assistant_dialog_skill.id).pluck(:name)
            #Rails.logger.debug "*** chat skills all -- #{all_chat_skills}"
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
  