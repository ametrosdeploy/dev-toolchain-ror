# frozen_string_literal: true

# Controller for creating assistant entities ...
class Api::Admin::V1::AsstEntitiesController < Api::Admin::V1::BaseController
  before_action :set_learn_mod, :set_learning_object
  before_action :set_asst_entity, only: %i[show update destroy
                                           add_value_and_synonyms]
  LEARN_MOD_ID = 'learn_mod ID'
  LEARN_OBJ_ID = 'learning object ID'

  # GET /asst_entities
  def index
    @asst_entities = AsstEntity.all

    render json: @asst_entities
  end

  # GET /asst_entities/1
  def show
    render json: @asst_entity
  end

  # POST /asst_entities
  def create
    hanlder = AsstElementHandler::Entity.new(create_hsh)
    entity = hanlder.create_entity
    if entity
      render json: entity, status: :created, location: @asst_entity
    else
      render json: entityy.errors, status: :unprocessable_entity
    end
  end

  def add_value_and_synonyms
    hanlder = AsstElementHandler::Entity.new(create_hsh)
    entity = hanlder.create_entity_val_and_synonyms(entity_value_param[:value],
                                                    synonyms_param)
    if entity
      render json: entity
    else
      render json: entityy.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /asst_entities/1
  def update
    if @asst_entity.update(asst_entity_params)
      render json: @asst_entity
    else
      render json: @asst_entity.errors, status: :unprocessable_entity
    end
  end

  # DELETE /asst_entities/1
  def destroy
    @asst_entity.destroy
  end

  swagger_controller :asst_entities, 'AsstEntity', resource_path:
     '/api/admin/v1/learn_mods/:learn_mod_id/learning_objects/:learning_object_id/asst_entities'

  swagger_api :create do
    summary 'Creates an Assistant Entity'
    notes 'Should be used to create an Assistant Entity'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'learn_mod_id', :integer, :required, LEARN_MOD_ID
    param :path, 'learning_object_id', :integer, :required, LEARN_OBJ_ID
    param :form, 'asst_entity[name]', :string, :required, 'name'
  end

  swagger_api :add_value_and_synonyms do
    summary 'Adds value and synonyms to an Asst Entity'
    notes 'Should be used to add value and synonyms to an Asst Entity'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'learn_mod_id', :integer, :required, LEARN_MOD_ID
    param :path, 'learning_object_id', :integer, :required, LEARN_OBJ_ID
    param :path, 'id', :integer, :required, 'Asst Entity id'
    param :form, 'asst_entity[asst_entity_values_attributes][value]',
          :string, :required, 'name'
    param :form,
          'asst_entity[asst_entity_values_attributes][asst_entity_val_synonyms_attributes][synonym][]',
          :string, :required, 'Synonyms'
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  def set_learning_object
    @learning_object = LearningObject.find(params[:learning_object_id])
  end

  def set_learn_mod
    @learn_mod = LearnMod.find(params[:learn_mod_id])
  end

  def set_asst_entity
    @asst_entity = AsstEntity.find(params[:id])
  end

  def create_hsh
    {
      learn_mod: @learn_mod,
      learning_object: @learning_object,
      entity_name: asst_entity_params[:name],
      entity: @asst_entity
    }
  end

  # Only allow a trusted parameter "white list" through.
  def asst_entity_params
    params.require(:asst_entity).permit(
      :name,
      asst_entity_values_attributes: [
        :value,
        asst_entity_val_synonyms_attributes: [synonym: []]
      ]
    )
  end

  def entity_value_param
    asst_entity_params[:asst_entity_values_attributes]
  end

  def synonyms_param
    entity_value_param[:asst_entity_val_synonyms_attributes][:synonym]
  end
end
