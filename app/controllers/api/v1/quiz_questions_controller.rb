# frozen_string_literal: true

# Controller for quiz questions
class Api::V1::QuizQuestionsController < Api::V1::BaseController
  def index
    quiz_evl = QuizEvaluation.where('quiz_evaluations.user_learn_obj_id = ?',
                                    params[:user_lo_id]).first
    @quiz_ques = QuizQuestion.find(quiz_evl.question_orders(params[:id]))
    render json: { questions: serialize_rec(@quiz_ques),
                   responses: resp_serializer.new(quiz_evl).serializable_hash }
  end

  swagger_controller :quiz_questions, 'QuizQuestion', resource_path:
    '/api/v1/quiz_questions'

  swagger_api :index do
    summary 'Get Quiz questions'
    notes 'Should be used for Quiz Questions'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :query, 'id', :integer, :required, 'quiz_learn_obj_id'
    param :query, 'user_lo_id', :integer, :required, 'User LO ID'
  end

  private

  def serializer
    Learner::QuizQuestionSerializer
  end

  def resp_serializer
    Learner::QuizEvaluationTrimmedSerializer
  end
end
