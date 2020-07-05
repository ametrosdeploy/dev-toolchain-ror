# frozen_string_literal: true

class Api::Admin::V1::AsstIntentsController < Api::Admin::V1::BaseController
  before_action :set_learning_object, only: %i[index create upload_csv
                                               sync_with_assistant ]

  before_action :set_asst_intent, only: %i[show update destroy]
  before_action :set_intent_handler, only: %i[create update
                                              sync_with_assistant]
  LEARN_OBJ_ID = 'learning object ID'
  def index
    @asst_intents = @learning_object.asst_intents
    render json: serialize_rec(@asst_intents)
  end

  def create
    @asst_intent = @learning_object.asst_intents
                                   .new(asst_intent_params)
    @intent_hanlder.create_intent
    if @intent_hanlder.success? && @asst_intent.save
      render json: serialize_rec(@asst_intent), status: :created
    else
      render json: { error: errors }, status: :unprocessable_entity
    end
  end

  def update
    @intent_hanlder.update_intent(asst_intent_params)
    if @intent_hanlder.success? && @asst_intent.update(asst_intent_params)
      render json: serialize_rec(@asst_intent)
    else
      render json: { error: errors }, status: :unprocessable_entity
    end
  end

  def show
    render json: serialize_rec(@asst_intent)
  end

  def destroy
    @asst_intent.destroy
  end

  def upload_csv
    AsstIntent.import(params[:file], @learning_object.id)
    @asst_intents = @learning_object.asst_intents
    render json: serialize_rec(@asst_intents)
  end

  def sync_with_assistant
    @intent_hanlder.sync_with_assistant
    if @intent_hanlder.success?
      @asst_intents = @learning_object.asst_intents
      render json: serialize_rec(@asst_intents), status: :created
    else
      render json: { error: errors }, status: :unprocessable_entity
    end
  end

  def link_to_dialog_skill
    render json: { url: 'https://cloud.ibm.com/resources' }
  end

  swagger_controller :asst_intents, 'Assistant Intents'
  swagger_api :index do
    summary 'List Asst Intents'
    notes 'Should be used to list Asst intents'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'learning_object_id', :integer, :required, LEARN_OBJ_ID
  end

  swagger_api :show do
    summary 'Show Asst Intent'
    notes 'Should be used to show Asst Intent'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'Asst Intent id'
  end

  swagger_api :create do
    summary 'Creates an Assistant Intent'
    notes 'Should be used to create an Assistant Intent'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'learning_object_id', :integer, :required, LEARN_OBJ_ID
    param :form, 'asst_intent[name]', :string, :required, 'name'
  end

  swagger_api :update do
    summary 'Updates an Assistant Intent'
    notes 'Should be used to update an Assistant Intent'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'Asst Intent id'
    param :form, 'asst_intent[name]', :string, :required, 'name'
    param :form, 'asst_intent[description]', :string, :optional, 'description'
    param :form, 'asst_intent[asst_intent_examples_attributes][][id]',
          :integer, :optional, 'name'
    param :form, 'asst_intent[asst_intent_examples_attributes][][example]',
          :string, :optional, 'example'
    param :form, 'asst_intent[asst_intent_examples_attributes][][_destroy]',
          :boolean, :optional, 'Set true to delete'
  end

  swagger_api :destroy do
    summary 'Destroy an Assistant Intent'
    notes 'Should be used to destroy an Assistant Intent'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'Intent Id'
  end

  swagger_api :upload_csv do
    summary 'Upload CSV to add intents and examples'
    notes 'Should be used Upload intents and examples'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'learning_object_id', :integer, :required, LEARN_OBJ_ID
    param :form, 'file', :file, :required, 'Uploaded file'
  end

  swagger_api :sync_with_assistant do
    summary 'Sync with assistant intents in Watson'
    notes 'Should be used to Sync assistant intents with Watson'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'learning_object_id', :integer, :required, LEARN_OBJ_ID
  end

  swagger_api :link_to_dialog_skill do
    summary 'To navigate to IBM console'
    notes 'Used to navigate to IBM console'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'learning_object_id', :integer, :required, LEARN_OBJ_ID
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  def set_learning_object
    @learning_object = LearningObject.find(
      params[:learning_object_id]
    )
  end

  def set_asst_intent
    @asst_intent = AsstIntent.find(params[:id])
    @learning_object ||= @asst_intent.learning_object
  end

  def set_intent_handler
    @intent_hanlder = AsstElementHandler::Intent.new(create_hsh)
  end

  def create_hsh
    args = { learning_object: @learning_object,
             intent: @asst_intent }
    if params[:asst_intent]
      args.merge!(intent_name:
        asst_intent_params[:name])
    end
    args
  end

  def errors
    @intent_hanlder.full_messages || @asst_intent.errors
  end

  # Only allow a trusted parameter "white list" through.
  def asst_intent_params
    params.require(:asst_intent).permit(
      :name, :description, asst_intent_examples_attributes: %i[id example _destroy]
    )
  end

  def serializer
    AsstIntentSerializer
  end
end
