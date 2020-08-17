# frozen_string_literal: true

# Handles NLU training inputs ...
class Api::Admin::V1::NluTrainingInputsController < Api::Admin::V1::BaseController
  before_action :set_learning_object, only: %i[index create]
  before_action :set_nlu_training_input, only: %i[show update destroy]
  LEARN_OBJ_ID = 'learning object ID'

  # GET /nlu_training_inputs
  def index
    @nlu_training_inputs = @lo.nlu_training_inputs.order(:order_num)
    render json: serialize_rec(@nlu_training_inputs)
  end

  # GET /nlu_training_inputs/1
  def show
    render json: serialize_rec(@nlu_training_input)
  end

  # POST /nlu_training_inputs
  def create
    @nlu_training_input = @lo.nlu_training_inputs.new(
      nlu_training_input_params
    )
    if @nlu_training_input.save
      render json: serialize_rec(@nlu_training_input), status: :created
    else
      render json: @nlu_training_input.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /nlu_training_inputs/1
  def update
    if @nlu_training_input.update(nlu_training_input_params)
      render json: serialize_rec(@nlu_training_input)
    else
      render json: @nlu_training_input.errors, status: :unprocessable_entity
    end
  end

  # DELETE /nlu_training_inputs/1
  def destroy
    @nlu_training_input.destroy
  end

  swagger_controller :nlu_training_inputs, 'NLU Training Inputs'

  swagger_api :index do
    summary 'List NLU Training Input'
    notes 'Should be used to list NLU Training Input'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'learning_object_id', :integer,
          :required, LEARN_OBJ_ID
  end

  # swagger_api :create do
  #   summary 'Creates NLU Training Input'
  #   notes 'Should be used to create an NLU Training Input'
  #   param :header, :Authorization, :string, :required, 'Authorization'
  #   param :path, 'learning_object_id', :integer,
  #         :required, LEARN_OBJ_ID
  #   param :form, 'nlu_training_input[message]',
  #         :string, :required, 'message'
  # end

  swagger_api :update do
    summary 'Updates NLU Training Input'
    notes 'Should be used to update NLU Training Input'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'ID'
    param :form, 'nlu_training_input[message]',
          :string, :required, 'message'
  end

  swagger_api :show do
    summary 'Show NLU Training Input'
    notes 'Should be used to show NLU Training Input'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'ID'
  end

  swagger_api :destroy do
    summary 'Destroys NLU Training Input'
    notes 'Should be used to destroy NLU Training Input'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'ID'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_nlu_training_input
    @nlu_training_input = NluTrainingInput.find(params[:id])
  end

  def set_learning_object
    @lo = LearningObject.find(params[:learning_object_id])
  end

  # Only allow a trusted parameter "white list" through.
  def nlu_training_input_params
    params.require(:nlu_training_input).permit(:message, :learning_object_id)
  end

  def serializer
    NluTrainingInputSerializer
  end
end
