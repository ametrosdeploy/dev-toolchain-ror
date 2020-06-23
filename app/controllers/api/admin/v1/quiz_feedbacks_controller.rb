# frozen_string_literal: true

# Controller for Quiz feedback specific requests
class Api::Admin::V1::QuizFeedbacksController < Api::Admin::V1::BaseController
  before_action :set_quiz_question, only: %i[index create]
  before_action :set_quiz_feedback, only: [:update]

  def index
    @quiz_feedback = @quiz_question.quiz_feedback
    render json: serialize_rec(@quiz_feedback)
  end

  def create
    @quiz_feedback = QuizFeedback.new(quiz_feedback_params)
    @quiz_feedback.quiz_question = @quiz_question
    if @quiz_feedback.save
      render json: serialize_rec(@quiz_feedback), status: :created
    else
      render json: @quiz_feedback.errors, status: :unprocessable_entity
    end
  end

  def update
    if @quiz_feedback.update(quiz_feedback_params)
      render json: serialize_rec(@quiz_feedback)
    else
      render json: @quiz_feedback.errors, status: :unprocessable_entity
    end
  end

  swagger_controller :quiz_feedbacks, 'Quiz Feedbacks'

  swagger_api :index do
    summary 'View feedback of a Quiz question'
    notes 'Should be used to view feedback of a Quiz question'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'quiz_question_id', :integer, :required, 'Quiz Question Id'
  end

  swagger_api :create do
    summary 'Create feedback for a Quiz question'
    notes 'Should be used to create feedback for a Quiz question'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'quiz_question_id', :integer, :required, 'Quiz Question Id'
    param :form, 'quiz_feedback[right_ans_feedback]', :string, :required
    param :form, 'quiz_feedback[wrong_ans_feedback]', :string, :required
  end

  swagger_api :update do
    summary 'Update feedback of a Quiz question'
    notes 'Should be used to update feedback of a Quiz question'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'Quiz Feedback Id'
    param :form, 'quiz_feedback[right_ans_feedback]', :string, :required
    param :form, 'quiz_feedback[wrong_ans_feedback]', :string, :required
  end

  private

  def set_quiz_question
    @quiz_question = QuizQuestion.find(params[:quiz_question_id])
  end

  def set_quiz_feedback
    @quiz_feedback = QuizFeedback.find(params[:id])
  end

  def quiz_feedback_params
    params.require(:quiz_feedback).permit(:right_ans_feedback,
                                          :wrong_ans_feedback)
  end

  def serializer
    QuizFeedbackSerializer
  end
end
