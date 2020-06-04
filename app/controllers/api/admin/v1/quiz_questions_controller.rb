# frozen_string_literal: true

# Controller for Quiz question specific requests
class Api::Admin::V1::QuizQuestionsController < Api::Admin::V1::BaseController
  before_action :set_quiz_learn_obj
  before_action :set_quiz_question, only: %i[show update destroy]

  def index
    @quiz_questions = @quiz_learn_obj.quiz_questions
    render json: serialize_rec(@quiz_questions)
  end

  def show
    render json: serialize_rec(@quiz_question)
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
      render json: serialize_rec(@quiz_question)
    else
      render json: @quiz_question.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @quiz_question.destroy
  end

  swagger_controller :quiz_questions, 'Quiz Questions', resource_path:
     '/api/admin/v1/:quiz_learn_obj_id/quiz_questions'

  swagger_api :index do
    summary 'List all questions in a Quiz LO'
    notes 'Should be used to List questions in a Quiz LO'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'quiz_learn_obj_id', :integer, :required, 'Quiz LO ID'
  end

  swagger_api :create do
    summary 'Creates a Quiz Question'
    notes 'Should be used to create a quiz question'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'quiz_learn_obj_id', :integer, :required, 'Quiz LO ID'
    param :form, 'quiz_question[question]', :string, :required
    param :form, 'quiz_question[question_type]', :string, :required,
          'Options: "multiple_choice", "numeric", "range", "long_answer"'
    param :form, 'quiz_question[points]', :integer,
          :required, 'Right answer Points'
    param :form, 'quiz_question[feedback_from_watson]', :boolean,
          :optional, 'fetch feedback from watson'
    param :form, 'quiz_question[mcq_options_attributes][]',
          :mcq_option_attr, :optional, 'MCQ question options'
    param :form, 'quiz_question[numeric_answer_attributes][answer]',
          :number, :optional, 'Answer field for Numeric Qus Type'
    param :form, 'quiz_question[range_answer_attributes][low_range]',
          :number, :optional, 'Low Range for Range Question Type'
    param :form, 'quiz_question[range_answer_attributes][high_range]',
          :number, :optional, 'High Range for Range Question Type'
    param :form, 'quiz_question[quiz_feedback_attributes][right_ans_feedback]',
          :string, :optional, 'Feedback if user answer is Right'
    param :form, 'quiz_question[quiz_feedback_attributes][wrong_ans_feedback]',
          :string, :optional, 'Feedback if user answer is Wrong'

    response :unauthorized
  end

  swagger_model :mcq_option_attr do
    description 'Option attributes for MCQ Questions'
    property :order, :integer, :required, 'Option order'
    property :option, :string, :required, 'Name'
    property :is_correct, :boolean, :required, 'Is correct answer?'
  end

  swagger_api :show do
    summary 'Show Quiz Question'
    notes 'Should be used to show a quiz question'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'quiz_learn_obj_id', :integer, :required, 'Quiz LO ID'
    param :path, 'id', :integer, :required, 'Quiz Question ID'
  end

  swagger_api :update do
    summary 'Update Quiz Question'
    notes 'Should be used to update a quiz question'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'quiz_learn_obj_id', :integer, :required, 'Quiz LO ID'
    param :path, 'id', :integer, :required, 'Quiz Question ID'
    param :form, 'quiz_question[question]', :string, :required
    param :form, 'quiz_question[question_type]', :string, :required,
          'Options: "multiple_choice", "numeric", "range", "long_answer"'
    param :form, 'quiz_question[points]', :integer,
          :required, 'Right answer Points'
    param :form, 'quiz_question[feedback_from_watson]', :boolean,
          :optional, 'fetch feedback from watson'
    param :form, 'quiz_question[mcq_options_attributes][]',
          :mcq_option_attr, :optional, 'MCQ question options'
    param :form, 'quiz_question[numeric_answer_attributes][answer]',
          :number, :optional, 'Answer field for Numeric Qus Type'
    param :form, 'quiz_question[range_answer_attributes][low_range]',
          :number, :optional, 'Low Range for Range Question Type'
    param :form, 'quiz_question[range_answer_attributes][high_range]',
          :number, :optional, 'High Range for Range Question Type'
    param :form, 'quiz_question[quiz_feedback_attributes][right_ans_feedback]',
          :string, :optional, 'Feedback if user answer is Right'
    param :form, 'quiz_question[quiz_feedback_attributes][wrong_ans_feedback]',
          :string, :optional, 'Feedback if user answer is Wrong'
  end

  swagger_api :destroy do
    summary 'Destroy a quiz question'
    notes 'Should be used to destroy a quiz question'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'quiz_learn_obj_id', :integer, :required, 'Quiz LO ID'
    param :path, 'id', :integer, :required, 'Quiz Question ID'
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
    params.require(:quiz_question)
          .permit(:question_type, :question, :order, :points,
                  :feedback_from_watson,
                  mcq_options_attributes: %i[order option
                                             is_correct _destroy],
                  quiz_feedback_attributes: %i[right_ans_feedback
                                               wrong_ans_feedback
                                               _destroy],
                  numeric_answer_attributes: %i[answer _destroy],
                  range_answer_attributes: %i[low_range high_range _destroy])
  end

  def serializer
    QuizQuestionSerializer
  end
end
