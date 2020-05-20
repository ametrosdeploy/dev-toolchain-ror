# frozen_string_literal: true

class Api::Admin::V1::LearningObjectsController < Api::Admin::V1::BaseController
  before_action :authenticate_user!
  before_action :set_learn_mod
  before_action :set_learning_object, only: %i[show update destroy]

  CARD_TYPES = { email: 1, video: 2, text: 3 }.with_indifferent_access.freeze

  def index
    @learning_objects = LearningObject.all
    render json: @learning_objects
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

  swagger_controller :learning_objects, 'LearningObject', resource_path:
     '/api/admin/v1/learn_mods/:learn_mod_id/learning_objects'
  swagger_api :create do
    summary 'Creates a learning object'
    notes 'Should be used to create a learning object'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'learn_mod_id', :integer, :required, 'learn_mod ID'
    param :form, 'card_type', :string, :required, 'Options: "email", "video", "text"'
    param :form, 'learning_object[name]', :string, :optional, 'name'
    param :form, 'learning_object[card_order]', :integer, :required, 'card_order'
    param :form, 'learning_object[learning_object_type]', :string, :required, 'Options: "content", "plot_point", "interaction"'
    param :form, 'card[title]', :required, :optional, 'title'
    param :form, 'card[description]', :string, :optional, 'description'
    param :form, 'card[to_character_ids][]', :integer, :optional, 'to_character_ids'
    param :form, 'card[cc_character_ids][]', :integer, :optional, 'cc_character_ids'
    param :form, 'card[global_video_id]', :integer, :optional, 'global_video_id'

    response :unauthorized
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
    params.require(:learning_object).permit(:name, :card_order, :status,
                                            :learning_object_type)
  end

  def card_type
    CARD_TYPES[params[:card_type]]
  end

  # Handles create/Update
  def create_learning_obj
    if card_type
      # Handles the creation process of all the diffent types of cards
      learning_obj = LearnObjHandler::CreateManager.for(create_hsh)
      if learning_obj.save_record
        render json: learning_obj.response, status: 200
      else
        render json: learning_obj.errors, status: 422
      end
    else
      render json: { message: "Invalid Card Type" }, status: 422
    end
  end

  def create_hsh
    {
      card_type:              card_type,
      learning_object_params: learning_object_params,
      params:                 params,
      learn_mod:              @learn_mod,
      learning_object:        @learning_object
    }
  end

end
