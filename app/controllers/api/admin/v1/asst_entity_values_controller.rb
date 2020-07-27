# frozen_string_literal: true

# Controller for assistant entity value and its synonyms...
class Api::Admin::V1::AsstEntityValuesController < Api::Admin::V1::BaseController
  before_action :set_asst_entity_value, only: %i[show update destroy]
  before_action :set_asst_entity, only: %i[index create update]
  before_action :set_entity_handler, only: %i[create update]

  ENTITY_ID = 'Assistant entity ID'

  # GET /asst_entity_values
  def index
    @asst_entity_values = @asst_entity.asst_entity_values
                                      .includes(:asst_entity_val_synonyms)
    render json: serialize_rec(@asst_entity_values)
  end

  # GET /asst_entity_values/1
  def show
    render json: serialize_rec(@asst_entity_value)
  end

  # POST /asst_entity_values
  def create
    asst_entity_value_params.merge!(in_watson: true)
    @asst_entity_value = @asst_entity.asst_entity_values
                                     .new(asst_entity_value_params)
    @entity_handler.add_value_and_synonym_in_watson(@asst_entity_value)
    if @entity_handler.success? && @asst_entity_value.save
      @asst_entity_value.record_synonyms_created_in_watson
      render json: serialize_rec(@asst_entity_value), status: :created
    else
      render json: { error: errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /asst_entity_values/1
  def update
    @entity_handler.update_value_and_synonym_in_watson(
      @asst_entity_value, asst_entity_value_params
    )
    if @entity_handler.success? &&
       @asst_entity_value.update(asst_entity_value_params)
      render json: serialize_rec(@asst_entity_value)
    else
      render json: { error: errors }, status: :unprocessable_entity
    end
  end

  # DELETE /asst_entity_values/1
  def destroy
    @asst_entity_value.destroy
  end

  swagger_controller :asst_entity_values, 'Assistant Entity Value'
  swagger_api :index do
    summary 'List Asst Entity Values'
    notes 'Should be used to list Entity Values'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'asst_entity_id', :integer, :required, ENTITY_ID
  end

  swagger_api :show do
    summary 'Show Asst Entity Value'
    notes 'Should be used to show Entity Value'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'Asst Entity value id'
  end

  swagger_api :create do
    summary 'Adds value and synonyms to an entity'
    notes 'Should be used to add value and synonyms to an entity'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'asst_entity_id', :integer, :required, ENTITY_ID
    param :form, 'asst_entity_value[value]', :string, :required, 'name'
    param :form, 'asst_entity_value[asst_entity_val_synonyms_attributes][][id]',
          :integer, :optional, 'Synonym ID'
    param :form, 'asst_entity_value[asst_entity_val_synonyms_attributes][][synonym]',
          :string, :optional, 'Synonym'
    param :form, 'asst_entity_value[asst_entity_val_synonyms_attributes][][_destroy]',
          :boolean, :optional, 'Set this to true to remove'
    response :unauthorized
  end

  swagger_api :update do
    summary 'Updates value / synonyms of an entity'
    notes 'Should be used to updates value / synonyms of an entity'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'asst_entity_id', :integer, :required, ENTITY_ID
    param :path, 'id', :integer, :required, 'ID'
    param :form, 'asst_entity_value[value]', :string, :required, 'name'
    param :form, 'asst_entity_value[asst_entity_val_synonyms_attributes][][id]',
          :integer, :optional, 'Synonym ID'
    param :form, 'asst_entity_value[asst_entity_val_synonyms_attributes][][synonym]',
          :string, :optional, 'Synonym'
    param :form, 'asst_entity_value[asst_entity_val_synonyms_attributes][][_destroy]',
          :boolean, :optional, 'Set this to true to remove'
    response :unauthorized
  end

  swagger_api :destroy do
    summary 'Destroy an Assistant Entity Value'
    notes 'Should be used to destroy an asst entity value'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'asst entity value ID'
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  def set_asst_entity
    @asst_entity = AsstEntity.find_by(id: params[:asst_entity_id])
    @asst_entity ||= @asst_entity_value&.asst_entity
  end

  def set_asst_entity_value
    @asst_entity_value = AsstEntityValue.find(params[:id])
  end

  def set_entity_handler
    @entity_handler = AsstElementHandler::Entity.new(obj_hsh)
  end

  def errors
    @entity_handler.full_messages || @asst_entity_value.errors
  end

  def obj_hsh
    {
      learning_object: @asst_entity.learning_object,
      entity: @asst_entity
    }
  end

  # Only allow a trusted parameter "white list" through.
  def asst_entity_value_params
    params.require(:asst_entity_value).permit(
      :value,
      asst_entity_val_synonyms_attributes: %i[id synonym _destroy]
    )
  end

  def serializer
    AsstEntityValueSerializer
  end
end
