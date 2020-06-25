# frozen_string_literal: true

# This is the controller for Dialogic Questions ...
class Api::Admin::V1::DialogicQuestionsController < Api::Admin::V1::BaseController
  before_action :set_dialogic_lo, only: %i[create index]
  before_action :set_dialogic_question, only: %i[show update destroy]
  DIALOGIC_LO_ID = 'Dialogic learning object ID'

  # GET /dialogic_questions
  def index
    @questions = @dialogic_lo.dialogic_questions
                             .includes(:question_variations)
    render json: serialize_rec(@questions)
  end

  # GET /dialogic_questions/1
  def show
    render json: serialize_rec(@question)
  end

  # POST /dialogic_questions
  def create
    @question = @dialogic_lo.dialogic_questions
                            .build(dialogic_question_params)
    if @question.save
      render json: serialize_rec(@question), status: :created
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /dialogic_questions/1
  def update
    if @question.update(dialogic_question_params)
      render json: serialize_rec(@question)
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /dialogic_questions/1
  def destroy
    @question.destroy
  end

  def reorder_questions
    if @dialogic_lo.update(dialogic_lo_params)
      render json: {}, status: 200
    else
      render json: @dialogic_lo.errors, status: :unprocessable_entity
    end
  end

  swagger_controller :dialogic_questions, 'Dialogic Question'
  swagger_api :index do
    summary 'List all questions in a dialogic LO'
    notes 'Should be used to list all questions in a dialogic LO'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'dialogic_learn_obj_id', :integer, :required, DIALOGIC_LO_ID
  end

  swagger_api :create do
    summary 'Creates a question in a dialogic LO'
    notes 'Should be used to create a question in a dialogic LO'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'dialogic_learn_obj_id', :integer, :required, DIALOGIC_LO_ID
    param :form, 'dialogic_question[concept]', :string, :required, 'concept'
    param :form, 'dialogic_question[question]', :string, :required, 'question'
    param :form, 'dialogic_question[order]', :integer, :required, 'order'
    param :form, 'dialogic_question[question_variations_attributes][][id]',
          :integer, :optional, 'question variation id'
    param :form, 'dialogic_question[question_variations_attributes]
          [][question]', :string, :optional, 'Question variations Array'
    param :form, 'dialogic_question[question_variations_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to remove'
    param :form, 'dialogic_question[key_topics_attributes][][id]',
          :integer, :optional, 'Key topic id'
    param :form, 'dialogic_question[key_topics_attributes]
          [][asst_entity_id]', :string, :optional, 'Asst Entity Id'
    param :form, 'dialogic_question[key_topics_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to remove'
    response :unauthorized
  end

  swagger_api :update do
    summary 'Updates a question in a dialogic LO'
    notes 'Should be used to update a dialogic question'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'dialogic_learn_obj_id', :integer, :required, DIALOGIC_LO_ID
    param :path, 'id', :integer, :required, 'ID'
    param :form, 'dialogic_question[concept]', :string, :required, 'concept'
    param :form, 'dialogic_question[question]', :string, :required, 'question'
    param :form, 'dialogic_question[order]', :integer, :required, 'order'
    param :form, 'dialogic_question[question_variations_attributes][][id]',
          :integer, :optional, 'question variation id'
    param :form, 'dialogic_question[question_variations_attributes]
          [][question]', :string, :optional, 'Question variations Array'
    param :form, 'dialogic_question[question_variations_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to remove'
    param :form, 'dialogic_question[key_topics_attributes][][id]',
          :integer, :optional, 'Key topic id'
    param :form, 'dialogic_question[key_topics_attributes]
          [][asst_entity_id]', :string, :optional, 'Asst Entity Id'
    param :form, 'dialogic_question[key_topics_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to remove'
    response :unauthorized
  end

  swagger_api :show do
    summary 'Show dialogic question'
    notes 'Should be used to show a dialogic question'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'dialogic_learn_obj_id', :integer, :required, DIALOGIC_LO_ID
    param :path, 'id', :integer, :required, 'ID'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_dialogic_lo
    @dialogic_lo = DialogicLearnObj.find(params[:dialogic_learn_obj_id])
  end

  def set_dialogic_question
    @question = DialogicQuestion.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def dialogic_question_params
    params.require(:dialogic_question).permit(
      :concept, :question, :order, :dialogic_learn_obj_id,
      question_variations_attributes: %i[id question _destroy],
      key_topics_attributes: %i[id asst_entity_id _destroy]
    )
  end

  def serializer
    DialogicQuestionsSerializer
  end
end
