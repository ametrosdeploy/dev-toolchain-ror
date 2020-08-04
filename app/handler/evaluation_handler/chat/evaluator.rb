# frozen_string_literal: true

module EvaluationHandler
    module Chat
      # For evaluating chat interaction ...
      class Evaluator
        def initialize(user_chat)
            #Rails.logger.debug "*** id -- #{id}"
            @user_chat = user_chat
            @learn_obj = @user_chat.user_learn_obj.learning_object
            @responses = user_chat.user_chat_responses
            @chat_lo = @learn_obj.objectable
            @chat_pt = 0
            @assistant_dialog_skill = @learn_obj.assistant_dialog_skill
        end

  
        def evaluate  
            # clear any existing
            ChatEvaluationSkill.where(user_chat_id: @user_chat.id).destroy_all
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
                        skill_name_multi = skill_name_multi.strip
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
            create_learner_debrief
        end

        def create_chat_evaluation_skill_record(skill_name, skill_value, user_chat_response_id)
            ChatEvaluationSkill.create(skill_name: skill_name, skill_value: skill_value, user_chat_response_id: user_chat_response_id, user_chat_id: @user_chat.id) 
        end

        def calculate_skill_assessments 
            skills_score_hash = Hash.new
            skills_hit = ChatEvaluationSkill.where(user_chat_id: @user_chat.id).order(:skill_name)
            skills_hit.each do |skill|
                all_skill_values = skills_hit.where(skill_name: skill.skill_name).pluck(:skill_value).sum
                # This is suboptimal; rewrite
                if skills_score_hash.key?(skill.skill_name) == false
                    skills_score_hash[skill.skill_name] = all_skill_values
                end
            end
            @user_chat.skills_score_hash = skills_score_hash
            @user_chat.complete = true
            @user_chat.save!

        end  

        def calculate_missed_skill_assessments  
            all_chat_skills = ChatSkill.where(assistant_dialog_skill_id: @assistant_dialog_skill.id).pluck(:name)
            skills_hit = ChatEvaluationSkill.where(user_chat_id: @user_chat.id).pluck(:skill_name).uniq 
            missed_skills = all_chat_skills - skills_hit
            @user_chat.skills_missed = missed_skills
            @user_chat.save! 
        end

        def create_learner_debrief 
            @chat_skills = @assistant_dialog_skill.chat_skills
            @chat_skills.each do |chat_skill| 

                if @user_chat.skills_score_hash.key?(chat_skill.name) == true

                    learner_skill_eval = @user_chat.skills_score_hash[chat_skill.name]
                    chat_skill_assmnt_item = ChatSkillAssmntItem.where(chat_skill_id: chat_skill.id).where( "value_count_min <= ?", learner_skill_eval).where( "value_count_max >= ?", learner_skill_eval).last 

                    unless chat_skill_assmnt_item.blank?
                        @chat_evaluation.chat_debrief_evaluation.create(
                            user_chat_id: @user_chat.id,
                            assessment_label_id: chat_skill_assmnt_item.assessment_label.id,
                            chat_skill_assmnt_item_id: chat_skill_assmnt_item.id, 
                            assmnt_item_points: chat_skill_assmnt_item.points,
                            debrief_received: pick_debrief(chat_skill_assmnt_item)
                        )
                    end

                else  
                    # missed logic 
                    chat_skill_assmnt_missed = ChatSkillAssmntMissed.find_by(chat_skill_id: chat_skill.id)
                    @user_chat.chat_debrief_evaluations.create(
                        user_chat_id: @user_chat.id,
                        chat_skill_assmnt_missed_id: chat_skill_assmnt_missed.id, 
                        assmnt_item_points: chat_skill_assmnt_missed.points,
                        debrief_received: pick_debrief(chat_skill_assmnt_missed)
                    )
                end
            end 
        end

        def pick_debrief(chat_skill_assmnt_item)
            debriefs = chat_skill_assmnt_item.debriefs
            random_index = rand(debriefs.count)
            debrief_record = debriefs[random_index]
            debrief_record&.content
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
            @user_chat.complete
        end
      end
    end
  end
  