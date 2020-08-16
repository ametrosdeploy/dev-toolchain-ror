class FinalEvaluationService < BaseService
  def initialize user_section
    @user_section = user_section
    @all_lo = @user_section.user_learn_objs
    interaction = LearningObject::learning_object_types[:interaction]
    @filtered_lo = @all_lo.joins(:learning_object).includes([:learning_object])
                          .where('learning_objects.learning_object_type = ? and
                                  learning_objects.objectable_type != ?',
                                  interaction, 'SubmissionLearnObj')
  end

  def call
    filtered_lo = []
    @filtered_lo.each do |user_lo|
      lo_eval = public_send("#{user_lo.learning_object.card_type}", user_lo)
      filtered_lo << common_info(user_lo).merge(lo_eval)
    end
    filtered_lo
  end

  def dialogic user_lo
    evaluation = user_lo.dialogic_evaluations.first
    if evaluation&.overall_assmnt_item
      overall_assesement(evaluation.overall_assmnt_item)
    else
      {
        data: serialize_rec(Learner::DialogicEvaluationSerializer, evaluation)
      }
    end
  end

  def email user_lo
    evaluation = user_lo.user_email_evaluation
    if evaluation&.overall_assmnt_item
      overall_assesement(evaluation.overall_assmnt_item)
    else
      {
        data: serialize_rec(Learner::UserEmailEvaluationSerializer, evaluation)
      }
    end
  end

  def quiz user_lo
    evaluation =  user_lo.quiz_evaluation
    {
      feedback: evaluation.overall_score,
      assesement: overall_assesement(evaluation.overall_assmnt_item)
    }
  end

  def chat user_lo
    evaluation = user_lo.user_chat
    if evaluation&.overall_assmnt_item
      overall_assesement(evaluation.overall_assmnt_item)
    else
      {
        data: serialize_rec(Learner::UserChatSerializer, evaluation)
      }
    end
  end

  def common_info user_lo
    {
      order: (@all_lo.find_index(user_lo).to_i + 1),
      name: user_lo.learning_object.name,
      card_type: user_lo.learning_object.card_type
    }
  end

  def overall_assesement overall
    {
      assesement: serialize_rec(Learner::OverallAssmntItemSerializer, overall)
    }
  end

  def serialize_rec serializer, data
    serializer.new(data).as_json['data']
  end
end
