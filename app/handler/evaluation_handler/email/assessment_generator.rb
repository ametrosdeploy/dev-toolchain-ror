# frozen_string_literal: true

module EvaluationHandler
  module Email
    # For evaluating learner email submission ...
    class AssessmentGenerator
      def initialize(args)
        @user_email_iteration = args[:email_iteration]
        @user_email_evaluation = args[:email_evaluation]
        @learn_obj = args[:learn_obj]
        @email_lo = @learn_obj.objectable
        @usr_iteration = @user_email_iteration.iteration
        @learner_email_txt = @user_email_iteration.email
        append_previous_emails
      end

      def append_previous_emails
        return unless iterations? && @usr_iteration > 1

        @learner_email_txt = learner_emails.join('. ')
      end

      def iterations?
        @email_lo.iteration_enabled &&
          @email_lo.iteration_level.present?
      end

      def learner_emails
        @user_email_evaluation.user_email_iterations.map(&:email)
      end

      def generate
        find_matching_assessment_formula
        generate_assessment
        generate_overall_assessment
      end

      def find_matching_assessment_formula
        @user_email_evaluation.assessment_formula_hits&.destroy_all
        email_skills = @email_lo.email_skills
        email_skills.each do |email_skill|

          email_assessments = email_skill.email_assessment_items

          email_assessments.each do |email_assessment|
            email_assessment.assessment_formulas.each do |formula|
              next unless matching_formula?(formula)

              track_assessment_formula_hits(formula)
            end
          end
        end
      end

      def track_assessment_formula_hits(formula)
        @user_email_evaluation.assessment_formula_hits.create(
          assessment_formula_id: formula.id
        )
      end

      def assessments_to_trigger
        formula_hits = @user_email_evaluation.assessment_formula_hits
        assessment_item_ids = formula_hits.map do |f|
          f.assessment_formula.email_assessment_item.id
        end
        assessment_item_ids.uniq!
        EmailAssessmentItem.where(id: assessment_item_ids)
      end

      def generate_assessment
          assessments = assessments_to_trigger
          return if assessments.blank?

          assessment.each do |assessment|
            debrief = assessment.debriefs.sample
            UserEmailAssessmentItem.create(
                email_assessment_item_id: assessment.id,
                user_email_evaluation_id: @user_email_evaluation.id,
                debrief_id: debrief.id,
                debrief_content: debrief.content,
                debrief_variation: debrief.variation
              )
          end 
      end

      def generate_overall_assessment  
        highest_score = @user_email_evaluation&.highest_possible_score.to_i
        learner_points = assessments_to_trigger.pluck(:points).sum
        learner_score = (learner_points.to_f / highest_score.to_f) * 100
        overall_items = @learn_obj&.overall_assmnt_items.order(order: :asc)
        overall_items.each do |item|
          if ((item.min_score..item.max_score) === learner_score)
            @user_email_iteration.overall_assmnt_item_id = item 
            @user_email_iteration.save!
          end
        end
      end

      def matching_formula?(formula)
        check_for_concept_match(formula) && check_for_keyword_match(formula) &&
        check_for_nlu_entity_match(formula) &&
        check_for_sentiment_match(formula) &&
        check_for_emotion_match(formula) &&
        check_for_intent_match(formula) &&
        check_for_entity_value_match(formula)
      end

      def all_items_hits?(items_hit, formula_items)
        (formula_items - items_hit).empty?
      end

      def hit_atleast_minimum?(items_hit, formula_items, min)
        (formula_items & items_hit).count >= min
      end

      def atleast_minimum_absence?(items_hit, formula_items, min)
        (formula_items - items_hit).count >= min
      end

      def check_for_concept_match(formula)
        concept_hits = @user_email_evaluation.concept_list
        to_be_present = formula.nlu_concepts_to_be_present&.pluck(:concept)
        to_be_absent = formula.nlu_concepts_to_be_absent&.pluck(:concept)
        all_items_hits?(concept_hits, to_be_present) &&
          !(to_be_absent.any? { |concept| concept_hits.include? concept })
      end

      def check_for_keyword_match(formula)
        present_min_count = formula.present_cond_keyword_min
        absent_min_count = formula.absent_cond_keyword_min
        keyword_hits = @user_email_evaluation.keyword_list
        to_be_present = formula.nlu_keywords_to_be_present&.pluck(:keyword)
        to_be_absent = formula.nlu_keywords_to_be_absent&.pluck(:keyword)
        hit_atleast_minimum?(keyword_hits, to_be_present, present_min_count) &&
          atleast_minimum_absence?(keyword_hits, to_be_absent, absent_min_count)
      end

      def check_for_nlu_entity_match(formula)
        entity_hits = @user_email_evaluation.nlu_entities_list
        to_be_present = formula.nlu_entities_to_be_present&.pluck(:entity)
        to_be_absent = formula.nlu_entities_to_be_absent&.pluck(:entity)
        all_items_hits?(entity_hits, to_be_present) &&
          !(to_be_absent.any? { |entity| entity_hits.include? entity })
      end

      def check_for_intent_match(formula)
        intent_hits = @user_email_evaluation.asst_intent_list
        to_be_present = formula.asst_intents_to_be_absent&.pluck(:name)
        to_be_absent = formula.asst_intents_to_be_absent&.pluck(:name)
        all_items_hits?(intent_hits, to_be_present) &&
          !(to_be_absent.any? { |intent| intent_hits.include? intent })
      end

      def check_for_entity_value_match(formula)
        ev_hits = @user_email_evaluation.asst_entity_value_list
        to_be_present = formula.asst_entity_values_to_be_present&.pluck(:id)
        to_be_absent = formula.asst_entity_values_to_be_absent&.pluck(:id)
        all_items_hits?(ev_hits, to_be_present) &&
          !(to_be_absent.any? { |ev| ev_hits.include? ev })
      end

      def check_for_sentiment_match(formula)
        sentiment_hit = @user_email_evaluation.sentiment
        hit_score = @user_email_evaluation.sentiment_score
        satisfy_sentiment_present_cond?(formula, sentiment_hit, hit_score)
      end

      def satisfy_sentiment_present_cond?(formula, sentiment_hit, hit_score)
        to_be_present = formula.formula_sentiments.to_be_present&.first
        cond_satisfied = true
        if to_be_present
          cond_satisfied = sentiment_matches(to_be_present, sentiment_hit,
                                             hit_score)
        end
        cond_satisfied
      end

      def sentiment_matches(formula, sentiment_hit, hit_score)
        sentiment = formula.sentiment
        comparator = formula.comparator
        score = formula.score
        range_value = formula.range_value
        sentiment_hit == sentiment &&
          check_score(hit_score, score, comparator, range_value)
      end

      def check_score(score_hit, formula_score, operator, range_value = nil)
        case operator
        when 'lt'
          score_hit < formula_score
        when 'gt'
          score_hit > formula_score
        when 'lt_eq'
          score_hit <= formula_score
        when 'gt_eq'
          score_hit >= formula_score
        when 'range'
          low = formula_score - range_value
          high = formula_score + range_value
          (low..high).include? score_hit
        end
      end

      def check_for_emotion_match(formula)
        emotions = formula.formula_emotions
        to_be_present = emotions.to_be_present
        satisfy_emotion_presence_cond?(to_be_present)
      end

      def satisfy_emotion_presence_cond?(to_be_present)
        all_emotions_match = true
        to_be_present.each do |emotion_rec|
          matches = check_emotion(emotion_rec)
          unless matches
            all_emotions_match = false
            break
          end
        end
        all_emotions_match
      end

      def check_emotion(emotion_rec)
        operator = emotion_rec.comparator
        score = emotion_rec.score
        range = emotion_rec.range_value
        case emotion_rec.emotion
        when 'sadness'
          check_score(@user_email_evaluation.sadness_score,
                      score, operator, range)
        when 'joy'
          check_score(@user_email_evaluation.joy_score,
                      score, operator, range)
        when 'fear'
          check_score(@user_email_evaluation.fear_score,
                      score, operator, range)
        when 'disgust'
          check_score(@user_email_evaluation.disgust_score,
                      score, operator, range)
        when 'anger'
          check_score(@user_email_evaluation.anger_score,
                      score, operator, range)
        end
      end
    end
  end
end
