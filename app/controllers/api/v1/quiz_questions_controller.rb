# frozen_string_literal: true

# Controller for quiz questions
class Api::V1::QuizQuestionsController < Api::V1::BaseController
  before_action :set_quiz_learn_obj, only: %i[index]

  def index
    @quiz_questions = QuizLearnObj.find(params[:quiz_learn_obj_id])
                                  .quiz_questions
    render json: serialize_rec(@quiz_questions)
  end

  swagger_controller :quiz_questions, 'QuizQuestion', resource_path:
    '/api/v1/quiz_questions'

  swagger_api :index do
    summary 'Get Quiz questions'
    notes 'Should be used for Quiz Questions'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :query, 'id', :integer, :required, 'quiz_learn_obj_id'
  end

  private

  def serializer
    Learner::QuizQuestionSerializer
  end
end
