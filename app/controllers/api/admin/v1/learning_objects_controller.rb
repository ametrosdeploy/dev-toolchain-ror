# frozen_string_literal: true

# Controller for learning object related requests
class Api::Admin::V1::LearningObjectsController < Api::Admin::V1::BaseController
  before_action :authenticate_user!
  before_action :set_learn_mod
  before_action :set_learning_object, only: %i[show update destroy
                                               update_status]
  CARD_TYPES = { email: 1, video: 2, text: 3, slide: 4, file: 5 }
               .with_indifferent_access.freeze
  LEARN_MOD_ID = 'learn_mod ID'

  def index
    active_lo = @learn_mod.learning_objects.includes([:objectable]).active
    archived_lo = @learn_mod.learning_objects.includes([:objectable]).archived
    render json: { active: custom_serialize(active_lo),
                   archived: custom_serialize(archived_lo),
                   elm_name: @learn_mod.name, world_id: @learn_mod.world_id }
  end

  def show
    render json: @learning_object
  end

  def create
    create_learning_obj
  end

  def update
    create_learning_obj
  end

  def destroy
    @learning_object.destroy
  end

  def update_status
    if @learning_object.update_status(params[:learning_object][:status])
      render json: {}, status: 200
    else
      render json: @learn_mod.errors, status: :unprocessable_entity
    end
  end

  swagger_controller :learning_objects, 'LearningObject', resource_path:
     '/api/admin/v1/learn_mods/:learn_mod_id/learning_objects'

  swagger_api :index do
    summary 'List Learning Object'
    notes 'Should be used to list Learning Object'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'learn_mod_id', :integer, :required, LEARN_MOD_ID
  end

  swagger_api :create do
    summary 'Creates a learning object'
    notes 'Should be used to create a learning object'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'learn_mod_id', :integer, :required, LEARN_MOD_ID
    param :form, 'card_type', :string, :required, 'Options: "email", "video",
          "text", "slide", "file"'
    param :form, 'learning_object[status]', :string, :required,
          'Options: "drafted", "published", "archived"'
    param :form, 'learning_object[name]', :string, :required, 'name'
    param :form, 'learning_object[learning_object_type]', :string, :required,
          'Options: "content", "plot_point", "interaction"'
    param :form, 'card[title]', :string, :optional, 'title'
    param :form, 'card[description]', :string, :optional, 'description'
    param :form, 'card[to_character_ids][]', :integer, :optional,
          'to_character_ids'
    param :form, 'card[cc_character_ids][]', :integer, :optional,
          'cc_character_ids'
    param :form, 'card[global_video_id]', :integer, :optional, 'global_video_id'
    param :form, 'card[slider_images_attributes][][id]', :integer,
          :optional, 'slider_image id'
    param :form, 'card[slider_images_attributes][][caption]', :string,
          :optional, 'caption'
    param :form, 'card[slider_images_attributes][][][global_resource_id]',
          :integer, :optional, 'global_resource_id'
    param :form, 'card[slider_images_attributes][][_destroy]', :string,
          :optional, 'Set to true to remove slider_image'
    param :form, 'card[global_resource_id]', :integer, :optional,
          'global_resource_id'
    response :unauthorized
  end

  swagger_api :update do
    summary 'Update a learning object'
    notes 'Should be used to update a learning object'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'learn_mod_id', :integer, :required, LEARN_MOD_ID
    param :path, 'id', :integer, :required, 'learning object ID'
    param :form, 'card_type', :string, :required, 'Options: "email", "video",
          "text", "slide", "file"'
    param :form, 'learning_object[status]', :string, :required,
          'Options: "drafted", "published", "archived"'
    param :form, 'learning_object[name]', :string, :required, 'name'
    param :form, 'learning_object[learning_object_type]', :string, :required,
          'Options: "content", "plot_point", "interaction"'
    param :form, 'card[title]', :string, :optional, 'title'
    param :form, 'card[description]', :string, :optional, 'description'
    param :form, 'card[to_character_ids][]', :integer, :optional,
          'to_character_ids'
    param :form, 'card[cc_character_ids][]', :integer, :optional,
          'cc_character_ids'
    param :form, 'card[global_video_id]', :integer, :optional, 'global_video_id'
    param :form, 'card[slider_images_attributes][][id]', :integer,
          :optional, 'slider_image id'
    param :form, 'card[slider_images_attributes][][caption]', :string,
          :optional, 'caption'
    param :form, 'card[slider_images_attributes][][][global_resource_id]',
          :integer, :optional, 'global_resource_id'
    param :form, 'card[slider_images_attributes][][_destroy]', :string,
          :optional, 'Set to true to remove slider_image'
    param :form, 'card[global_resource_id]', :integer, :optional,
          'global_resource_id'
    response :unauthorized
  end

  swagger_api :update_status do
    summary 'Update Learning Object Card status'
    notes 'Should be used to Update Learning Object Card status'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'learn_mod_id', :integer, :required, LEARN_MOD_ID
    param :path, 'id', :string, :required, 'LO ID'
    param :form, 'learning_object[status]', :string, :required,
          'Options: "drafted", "published", "archived"'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_learning_object
    @learning_object = @learn_mod.learning_objects.find(params[:id])
  end

  def set_learn_mod
    @learn_mod = LearnMod.find(params[:learn_mod_id])
  end

  # Only allow a trusted parameter "white list" through.
  def learning_object_params
    params.require(:learning_object).permit(:name, :status,
                                            :learning_object_type)
  end

  def card_type
    CARD_TYPES[params[:card_type]]
  end

  # Handles create/Update
  def create_learning_obj
    if card_type
      # Handles the creation process of all the diffent types of cards
      learn_obj = LearnObjHandler::CreateManager.for(create_hsh)
      if learn_obj&.save_record
        render json: learn_obj.response, status: 200
      else
        render json: learn_obj && learn_obj.errors || invalid_card, status: 422
      end
    else
      render json: invalid_card, status: 422
    end
  end

  def create_hsh
    {
      card_type: card_type,
      learning_object_params: learning_object_params,
      params: params,
      learn_mod: @learn_mod,
      learning_object: @learning_object || @learn_mod.learning_objects.build
    }
  end

  def custom_serialize(data)
    LearningObjectSerializer.new(data).as_json['data']
  end

  # Response when card type is invalid
  def invalid_card
    {
      message: 'Invalid Card Type'
    }
  end
end
