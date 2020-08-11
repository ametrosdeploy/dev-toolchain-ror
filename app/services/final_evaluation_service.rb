class FinalEvaluationService < BaseService
  def initialize user_section
    @user_section = user_section
    @all_lo = @user_section.user_learn_objs
    interaction = LearningObject::learning_object_types[:interaction]
    @filtered_lo = @all_lo.joins(:learning_object)
                          .where('learning_objects.learning_object_type = ? and
                                  learning_objects.objectable_type != ?',
                                  interaction, 'SubmissionLearnObj')
  end

  def call
    filtered_lo = []
    @filtered_lo.each do |user_lo|
      lo_eval = self.public_send("#{user_lo.learning_object.card_type}", user_lo)
      filtered_lo << common_info(user_lo).merge(lo_eval)
    end
  end

  def dialogic
  end

  def email
  end

  def quiz
  end

  def chat
  end

  def common_info user_lo
    {
      order: @all_lo.find_index(user_lo),
      name: user_lo.name,
    }
  end
end
