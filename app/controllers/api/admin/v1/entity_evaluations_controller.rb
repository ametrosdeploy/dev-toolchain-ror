# frozen_string_literal: true

class Api::Admin::V1::EntityEvaluationsController < Api::Admin::V1::BaseController
  before_action :set_question, only: %i[index create]
  before_action :set_entity_evaluation, only: %i[show update destroy]
  before_action :set_learn_mod_and_obj, only: %i[create update destroy]

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
    @entity_evaluation = @quiz_question.entity_evaluations.new(entity_evaluation_params)
    if populate_condition_field_and_save
      handler.create_or_update_dialog_node
      render json: serialize_rec(@entity_evaluation), status: :created
    else
      render json: @entity_evaluation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /entity_evaluations/1
  def update
    if @entity_evaluation.update(entity_evaluation_params)
      populate_condition_field_and_save
      handler.create_or_update_dialog_node
      render json: serialize_rec(@entity_evaluation)
    else
      render json: @entity_evaluation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /entity_evaluations/1
  def destroy
    @entity_evaluation.destroy
    handler.create_or_update_dialog_node
  end

  swagger_controller :entity_evaluations, 'Entity Evaluations'

  swagger_api :index do
    summary 'List all entity_evaluations in a quiz question'
    notes 'Should be used to List questions in a quiz question'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'quiz_question_id', :integer, :required, 'Question ID'
  end

  swagger_api :create do
    summary 'Create an entity evaluation in a quiz question'
    notes 'Should be used to create an entity evaluation in a quiz question'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'quiz_question_id', :integer, :required, 'Question ID'
    param :form, 'entity_evaluation[entity_evaluation_items_attributes]
          [][asst_entity_value_id]', :integer, :optional, 'entity value ID'

    response :unauthorized
  end

  swagger_api :update do
    summary 'Update an entity evaluation in a quiz question'
    notes 'Should be used to update an entity evaluation in a quiz question'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'Entity Evaluation ID'
    param :form, 'entity_evaluation[entity_evaluation_items_attributes][][id]',
          :integer, :required, 'evaluation item ID'
    param :form, 'entity_evaluation[entity_evaluation_items_attributes]
          [][asst_entity_value_id]', :integer, :optional, 'entity value ID'
    param :form, 'entity_evaluation[entity_evaluation_items_attributes]
          [][_destroy]', :boolean, :required, 'Set true to destroy'
    response :unauthorized
  end

  swagger_api :show do
    summary 'Show an entity_evaluation in a quiz question'
    notes 'Should be used view an entity_evaluation in a quiz question'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'Entity Evaluation ID'
  end

  swagger_api :destroy do
    summary 'Destroys an entity_evaluation in a quiz question'
    notes 'Should be used destroy an entity_evaluation in a quiz question'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'Entity Evaluation ID'
  end

  private

  def handler
    AsstElementHandler::QuizDialogNode.new(node_args)
  end

  def node_args
    {
      learn_mod: @learn_mod,
      learning_object: @learning_object,
      question: @quiz_question,
      entity_eval: @entity_evaluation
    }
  end

  def set_question
    @quiz_question = QuizQuestion.find(params[:quiz_question_id])
  end

  def set_learn_mod_and_obj
    @quiz_question ||= @entity_evaluation.quiz_question
    @learning_object = @quiz_question.quiz_learn_obj.learning_object
    @learn_mod = @learning_object.learn_mod
  end

  def populate_condition_field_and_save
    conditions = @entity_evaluation.entity_evaluation_items.map do |item|
      value_record = item.asst_entity_value
      "@#{value_record.asst_entity.name}:(#{value_record.value})"
    end
    @entity_evaluation.condition = conditions.join(' && ')
    @entity_evaluation.save
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_entity_evaluation
    @entity_evaluation = EntityEvaluation.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def entity_evaluation_params
    params.require(:entity_evaluation).permit(
      :condition, :quiz_question_id,
      entity_evaluation_items_attributes: %i[id asst_entity_value_id _destroy]
    )
  end

  def serializer
    EntityEvaluationSerializer
  end
end
