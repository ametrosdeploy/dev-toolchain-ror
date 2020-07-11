# frozen_string_literal: true

# Controller for creating assistant entities ...
class Api::Admin::V1::AsstEntitiesController < Api::Admin::V1::BaseController
  before_action :set_learning_object, only: %i[index create upload_csv
                                               sync_with_assistant ]

  before_action :set_asst_entity, only: %i[show update destroy
                                           add_value_and_synonyms
                                           update_value_and_synonyms]

  before_action :set_entity_handler, only: %i[create update
                                              sync_with_assistant]
  LEARN_OBJ_ID = 'learning object ID'

  # GET /asst_entities
  def index
    @asst_entities = @learning_object.asst_entities
    render json: serialize_rec(@asst_entities)
  end

  # GET /asst_entities/1
  def show
    render json: serialize_rec(@asst_entity)
  end

  # POST /asst_entities
  def create
    asst_entity_params.merge(in_watson: true)
    @asst_entity = @learning_object.asst_entities
                                   .new(asst_entity_params)                           
    @entity_hanlder.create_entity
    if @entity_hanlder.success? && @asst_entity.save
      render json: serialize_rec(@asst_entity), status: :created
    else
      render json: { error: errors }, status: :unprocessable_entity
    end
  end

  # POST /asst_entities
  def update
    @entity_hanlder.update_entity(@asst_entity.name)
    if @entity_hanlder.success? && @asst_entity.update(asst_entity_params)
      render json: serialize_rec(@asst_entity)
    else
      render json: { error: errors }, status: :unprocessable_entity
    end
  end

  def upload_csv
    AsstEntity.import(params[:file], @learning_object)
    @asst_entities = @learning_object.asst_entities
    render json: serialize_rec(@asst_entities)
  end

  def sync_with_assistant
    @entity_hanlder.sync_with_assistant
    if @entity_hanlder.success?
      @asst_entities = @learning_object.asst_entities
      render json: serialize_rec(@asst_entities), status: :created
    else
      render json: { error: errors }, status: :unprocessable_entity
    end
  end

  def link_to_dialog_skill
    render json: { url: 'https://cloud.ibm.com/resources' }
  end

  # def update
  #   @entity_hanlder.update_entity()
  #   if @entity_hanlder.success? && @asst_entity.save
  #     render json: serialize_rec(@asst_entity), status: :created
  #   else
  #     render json: { error: errors }, status: :unprocessable_entity
  #   end
  # end

  # DELETE /asst_entities/1
  def destroy
    @asst_entity.destroy
    rescue ActiveRecord::InvalidForeignKey
      err = 'Sorry! This Assistant entity is being referenced from other places.'
      render json: { error: err }
  end

  swagger_controller :asst_entities, 'Assistant Entity'
  swagger_api :index do
    summary 'List Asst Entities'
    notes 'Should be used to list Asst Entities'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'learning_object_id', :integer, :required, LEARN_OBJ_ID
  end

  swagger_api :show do
    summary 'Show Asst Entities'
    notes 'Should be used to show Asst Entities'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'Asst Entity id'
  end

  swagger_api :create do
    summary 'Creates an Assistant Entity'
    notes 'Should be used to create an Assistant Entity'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'learning_object_id', :integer, :required, LEARN_OBJ_ID
    param :form, 'asst_entity[name]', :string, :required, 'name'
  end

  swagger_api :update do
    summary 'Updates an Assistant Entity'
    notes 'Should be used to update an Assistant Entity'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'Asst Entity id'
    param :form, 'asst_entity[name]', :string, :required, 'name'
  end

  swagger_api :upload_csv do
    summary 'Upload CSV to add entities, values and synonyms'
    notes 'Should be used Upload entities, values and synonyms CSV'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'learning_object_id', :integer, :required, LEARN_OBJ_ID
    param :form, 'file', :file, :required, 'Uploaded file'
  end

  swagger_api :sync_with_assistant do
    summary 'Sync with assistant entities in Watson'
    notes 'Should be used to Sync assistant entities with Watson'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'learning_object_id', :integer, :required, LEARN_OBJ_ID
  end

  swagger_api :link_to_dialog_skill do
    summary 'To navigate to IBM console'
    notes 'Used to navigate to IBM console'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'learning_object_id', :integer, :required, LEARN_OBJ_ID
  end

  swagger_api :destroy do
    summary 'Destroy an Assistant Entity'
    notes 'Should be used to destroy an asst entity'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'asst entity ID'
  end

  # swagger_api :update do
  #   summary 'Updates assistant entity value'
  #   notes 'Should be used to create an Assistant entity value'
  #   param :header, :Authorization, :string, :required, 'Authorization'
  #   param :path, 'learning_object_id', :integer, :required, LEARN_OBJ_ID
  #   param :path, 'id', :integer, :required, 'ID'
  #   param :form, 'asst_entity[name]', :string, :required, 'name'
  # end

  private

  # Use callbacks to share common setup or constraints between actions.

  def set_learning_object
    @learning_object = LearningObject.find(
      params[:learning_object_id]
    )
  end

  def set_asst_entity
    @asst_entity = AsstEntity.find(params[:id])
    @learning_object ||= @asst_entity.learning_object
  end

  def set_entity_handler
    @entity_hanlder = AsstElementHandler::Entity.new(create_hsh)
  end

  def create_hsh
    args = { learning_object: @learning_object,
             entity: @asst_entity }
    if params[:asst_entity]
      args.merge!(entity_name:
        asst_entity_params[:name])
    end
    args
  end

  def errors
    @entity_hanlder.full_messages || @asst_entity.errors
  end

  # Only allow a trusted parameter "white list" through.
  def asst_entity_params
    params.require(:asst_entity).permit(:name)
  end

  def serializer
    AsstEntitySerializer
  end
end
