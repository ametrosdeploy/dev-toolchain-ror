# frozen_string_literal: true

class Api::Admin::V1::EntityEvaluationsController < Api::Admin::V1::BaseController
  before_action :set_quiz_question
  before_action :set_entity_evaluation, only: %i[show update destroy]

  # GET /entity_evaluations
  def index
    @entity_evaluations = @quiz_question.entity_evaluations
    render json: serialize_rec(@entity_evaluations)
  end

  # GET /entity_evaluations/1
  def show
    render json: serialize_rec(@entity_evaluation)
  end

  # POST /entity_evaluations
  def create
    @entity_evaluation = @quiz_question.entity_evaluations.create(entity_evaluation_params)
    if @entity_evaluation.save
      render json: serialize_rec(@entity_evaluation), status: :created
    else
      render json: @entity_evaluation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /entity_evaluations/1
  def update
    if @entity_evaluation.update(entity_evaluation_params)
      render json: serialize_rec(@entity_evaluation)
    else
      render json: @entity_evaluation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /entity_evaluations/1
  def destroy
    @entity_evaluation.destroy
  end

  swagger_controller :quiz_questions, 'Entity Evaluations', resource_path:
     '/api/admin/v1/quiz_learn_objs/:quiz_learn_obj_id/quiz_questions/:quiz_question_id/entity_evaluations'

  swagger_api :index do
    summary 'List all entity_evaluations in a quiz question'
    notes 'Should be used to List questions in a quiz question'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'quiz_learn_obj_id', :integer, :required, 'Quiz LO ID'
    param :path, 'quiz_question_id', :integer, :required, 'Question ID'
  end

  swagger_api :create do
    summary 'Create an entity evaluation in a quiz question'
    notes 'Should be used to create an entity evaluation in a quiz question'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'quiz_learn_obj_id', :integer, :required, 'Quiz LO ID'
    param :path, 'quiz_question_id', :integer, :required, 'Question ID'
    param :form, 'entity_evaluation[condition]',
          :string, :required, 'Evaluation condition'

    response :unauthorized
  end

  swagger_api :update do
    summary 'Update an entity evaluation in a quiz question'
    notes 'Should be used to update an entity evaluation in a quiz question'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'quiz_learn_obj_id', :integer, :required, 'Quiz LO ID'
    param :path, 'quiz_question_id', :integer, :required, 'Question ID'
    param :path, 'id', :integer, :required, 'Entity Evaluation ID'
    param :form, 'entity_evaluation[condition]',
          :string, :required, 'Evaluation condition'

    response :unauthorized
  end

  swagger_api :show do
    summary 'Show an entity_evaluation in a quiz question'
    notes 'Should be used view an entity_evaluation in a quiz question'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'quiz_learn_obj_id', :integer, :required, 'Quiz LO ID'
    param :path, 'quiz_question_id', :integer, :required, 'Question ID'
    param :path, 'id', :integer, :required, 'Entity Evaluation ID'
  end

  swagger_api :destroy do
    summary 'Destroys an entity_evaluation in a quiz question'
    notes 'Should be used destroy an entity_evaluation in a quiz question'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'quiz_learn_obj_id', :integer, :required, 'Quiz LO ID'
    param :path, 'quiz_question_id', :integer, :required, 'Question ID'
    param :path, 'id', :integer, :required, 'Entity Evaluation ID'
  end

  private

  def set_quiz_question
    @quiz_question = QuizQuestion.find(params[:quiz_question_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_entity_evaluation
    @entity_evaluation = EntityEvaluation.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def entity_evaluation_params
    params.require(:entity_evaluation).permit(:condition, :quiz_question_id)
  end

  def serializer
    EntityEvaluationSerializer
  end
end
