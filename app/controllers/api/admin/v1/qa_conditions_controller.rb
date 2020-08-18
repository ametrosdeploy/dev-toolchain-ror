# frozen_string_literal: true

# To handle QA conditions ...
class Api::Admin::V1::QaConditionsController < Api::Admin::V1::BaseController
  before_action :set_email_learn_obj, only: %i[index create
                                               character_qa_condition]
  before_action :set_qa_condition, only: %i[show update destroy]

  # GET /qa_conditions
  def index
    @qa_conditions = @email_learn_obj.qa_conditions
    render json: serialize_rec(@qa_conditions)
  end

  # GET /qa_conditions/1
  def show
    render json: serialize_rec(@qa_condition)
  end

  def character_qa_condition
    qa_condition = @email_learn_obj.qa_conditions.where(
      character_id: params[:qa_condition][:character_id]
    )
    render json: serialize_rec(qa_condition)
  end

  # POST /qa_conditions
  # def create
  #   @qa_condition = QaCondition.new(qa_condition_params)

  #   if @qa_condition.save
  #     render json: @qa_condition, status: :created, location: @qa_condition
  #   else
  #     render json: @qa_condition.errors, status: :unprocessable_entity
  #   end
  # end

  # PATCH/PUT /qa_conditions/1
  def update
    if @qa_condition.update(qa_condition_params)
      render json: serialize_rec(@qa_condition)
    else
      render json: @qa_condition.errors, status: :unprocessable_entity
    end
  end

  # DELETE /qa_conditions/1
  def destroy
    @qa_condition.destroy
  end

  swagger_controller :qa_conditions, 'Qa Conditions'

  swagger_api :index do
    summary 'List all qa_conditions in an Email LO'
    notes 'Should be used to List all qa_conditions in an Email LO'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'email_learn_obj_id', :integer, :required, 'Email LO ID'
  end

  swagger_api :show do
    summary 'Show all qa_condition'
    notes 'Should be used to show a qa_condition'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'ID'
  end

  swagger_api :update do
    summary 'Updates out of office response of a qa_condition'
    notes 'Should be used to update out of office response of a qa_condition'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'ID'
    param :form, 'qa_condition[ooto_response]', :string,
          :optional, 'ooto_response'
    response :unauthorized
  end

  swagger_api :character_qa_condition do
    summary 'Get qa condition for a character'
    notes 'Should be used to get a qa_condition for a character'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'email_learn_obj_id', :integer, :required, 'Email LO ID'
    param :query, 'qa_condition[character_id]', :integer,
          :required, 'character ID'
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  def set_email_learn_obj
    @email_learn_obj = EmailLearnObj.find(params[:email_learn_obj_id])
  end

  def set_qa_condition
    @qa_condition = QaCondition.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def qa_condition_params
    params.require(:qa_condition).permit(:ooto_response, :character_id)
  end

  def serializer
    QaConditionSerializer
  end
end
