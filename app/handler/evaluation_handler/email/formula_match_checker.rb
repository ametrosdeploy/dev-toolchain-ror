module EvaluationHandler
  module Email
    module FormulaMatchChecker
      
      def matching_formula?(formula)
        Rails.logger.info("** Checking formula (ID: #{formula.id})...")
        concepts_matched = check_for_concept_match(formula)
        keywords_matched = check_for_keyword_match(formula)
        nlu_entity_matched = check_for_nlu_entity_match(formula)
        sentiments_matched = check_for_sentiment_match(formula)
        emotions_matched = check_for_emotion_match(formula)
        intents_matched = check_for_intent_match(formula)
        asst_ev_matched = check_for_entity_value_match(formula)
        Rails.logger.info(
          "concepts: #{concepts_matched}, keywords: #{keywords_matched},
          entities: #{nlu_entity_matched},sentiments: #{sentiments_matched},
          emotions: #{emotions_matched}, intents: #{intents_matched},
          entity_value: #{asst_ev_matched}"
        )
        concepts_matched && keywords_matched && nlu_entity_matched &&
          sentiments_matched && emotions_matched && intents_matched &&
          asst_ev_matched
      end

      def check_for_concept_match(formula)
        concept_hits = @user_email_evaluation.concept_list
        to_be_present = formula.nlu_concepts_to_be_present&.pluck(:concept)
        to_be_absent = formula.nlu_concepts_to_be_absent&.pluck(:concept)
        Rails.logger.info("concept_hits : #{concept_hits},
                           to_be_present: #{to_be_present},
                           to_be_absent: #{to_be_absent}")
        all_items_hits?(concept_hits, to_be_present) &&
          !(to_be_absent &&
            to_be_absent.any? { |cpt| concept_hits.include? cpt })
      end

      def check_for_keyword_match(formula)
        present_min_count = formula.present_cond_keyword_min
        absent_min_count = formula.absent_cond_keyword_min
        keyword_hits = @user_email_evaluation.keyword_list
        to_be_present = formula.nlu_keywords_to_be_present&.pluck(:keyword)
        to_be_absent = formula.nlu_keywords_to_be_absent&.pluck(:keyword)
        Rails.logger.info("keyword_hits : #{keyword_hits},
                           to_be_present: #{to_be_present},
                           to_be_absent: #{to_be_absent}")
        hit_atleast_minimum?(keyword_hits, to_be_present, present_min_count) &&
          atleast_minimum_absence?(keyword_hits, to_be_absent, absent_min_count)
      end

      def check_for_nlu_entity_match(formula)
        entity_hits = @user_email_evaluation.nlu_entities_list
        to_be_present = formula.nlu_entities_to_be_present&.pluck(:entity)
        to_be_absent = formula.nlu_entities_to_be_absent&.pluck(:entity)
        Rails.logger.info("entity_hits : #{entity_hits},
                           to_be_present: #{to_be_present},
                           to_be_absent: #{to_be_absent}")
        all_items_hits?(entity_hits, to_be_present) &&
          !(to_be_absent.any? { |entity| entity_hits.include? entity })
      end

      def check_for_intent_match(formula)
        intent_hits = @user_email_evaluation.asst_intent_list
        to_be_present = formula.asst_intents_to_be_absent&.pluck(:name)
        to_be_absent = formula.asst_intents_to_be_absent&.pluck(:name)
        Rails.logger.info("intent_hits : #{intent_hits},
                           to_be_present: #{to_be_present},
                           to_be_absent: #{to_be_absent}")
        all_items_hits?(intent_hits, to_be_present) &&
          !(to_be_absent.any? { |intent| intent_hits.include? intent })
      end

      def check_for_entity_value_match(formula)
        ev_hits = @user_email_evaluation.asst_entity_value_list
        to_be_present = formula.asst_entity_values_to_be_present&.pluck(:id)
        to_be_absent = formula.asst_entity_values_to_be_absent&.pluck(:id)
        Rails.logger.info("ev_hits : #{ev_hits},
                           to_be_present: #{to_be_present},
                           to_be_absent: #{to_be_absent}")
        all_items_hits?(ev_hits, to_be_present) &&
          !(to_be_absent.any? { |ev| ev_hits.include? ev })
      end

      def check_for_sentiment_match(formula)
        sentiment_hit = @user_email_evaluation.sentiment
        hit_score = @user_email_evaluation.sentiment_score
        Rails.logger.info("sentiment_hit: #{sentiment_hit},
                           hit_score: #{hit_score}")
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
        Rails.logger.info("emotions : #{emotions}, to_be_pr: #{to_be_present}")
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

      def all_items_hits?(items_hit, formula_items = [])
        (formula_items - items_hit).empty?
      end

      def hit_atleast_minimum?(items_hit, formula_items = [], min = 0)
        Rails.logger.info("#{items_hit}::: #{formula_items} :::#{min}")
        (formula_items & items_hit).count >= min
      end

      def atleast_minimum_absence?(items_hit, formula_items = [], min = 0)
        Rails.logger.info("#{items_hit}::: #{formula_items} :::#{min}")
        (formula_items - items_hit).count >= min
      end
    end
  end
end