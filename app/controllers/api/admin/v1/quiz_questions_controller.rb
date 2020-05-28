# frozen_string_literal: true

# Controller for Quiz question specific requests
class Api::Admin::V1::QuizQuestionsController < Api::Admin::V1::BaseController
  before_action :authenticate_user!
  before_action :set_quiz_learn_obj
  before_action :set_quiz_question, only: [:show, :update, :destroy]

  def index
    @quiz_questions = QuizQuestion.all

    render json: @quiz_questions
  end

  def show
    render json: @quiz_question
  end

  def create
    @quiz_question = @quiz_learn_obj.quiz_questions.build(quiz_question_params)

    if @quiz_question.save
      render json: serialize_rec(@quiz_question), status: :created
    else
      render json: @quiz_question.errors, status: :unprocessable_entity
    end
  end

  def update
    if @quiz_question.update(quiz_question_params)
      render json: @quiz_question
    else
      render json: @quiz_question.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @quiz_question.destroy
  end

  swagger_controller :quiz_questions, 'Quiz Questions', resource_path:
     '/api/admin/v1/:quiz_learn_obj_id/quiz_questions'
     
  swagger_api :create do
    summary 'Creates a Quiz Question'
    notes 'Should be used to create a quiz question'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'quiz_learn_obj_id', :integer, :required, 'Quiz LO ID'
    param :form, 'quiz_question[question]', :string, :required
    param :form, 'quiz_question[question_type]', :string, :required,
          'Options: "multiple_choice", "numeric", "range", "long_answer"'
    param :form, 'quiz_question[points]', :integer, :required, 'Right answer Points'
    param :form, 'quiz_question[feedback_from_watson]', :boolean, :optional, 'fetch feedback from watson'

    response :unauthorized
    response :not_acceptable
  end
   

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quiz_learn_obj
      @quiz_learn_obj = QuizLearnObj.find(params[:quiz_learn_obj_id])
    end

    def set_quiz_question
      @quiz_question = QuizQuestion.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def quiz_question_params
      params.require(:quiz_question).permit(:question, :question_type, :points, :order, :feedback_from_watson)
    end

    def serializer
      QuizQuestionSerializer
    end
end
