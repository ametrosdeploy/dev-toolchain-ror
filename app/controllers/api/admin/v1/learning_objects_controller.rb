# frozen_string_literal: true

# Controller for learning object related requests
class Api::Admin::V1::LearningObjectsController < Api::Admin::V1::BaseController
  before_action :set_learn_mod
  before_action :set_learning_object, only: %i[show update update_status destroy
                                               remove_slider_image]
  CARD_TYPES = { email: 1, video: 2, text: 3, slide: 4, file: 5,
                 quiz: 6, dialogic: 7, chat: 8, submission: 9 }
               .with_indifferent_access.freeze
  LEARN_MOD_ID = 'learn_mod ID'
  LEARN_OBJ = 'learning_object[status]'
  OPTION_STR = 'Options: "drafted", "published", "archived"'
  LEARN_OBJ_ID = 'learning object ID'

  def index
    active_lo = @learn_mod.learning_objects.includes([:objectable]).active
    archived_lo = @learn_mod.learning_objects.includes([:objectable]).archived
    render json: { active: custom_serialize(active_lo),
                   archived: custom_serialize(archived_lo),
                   elm_name: @learn_mod.name, world_id: @learn_mod.world_id }
  end

  def show
    render json: custom_serialize(@learning_object)
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

  # Removed Slider Image
  def remove_slider_image
    @learning_object.objectable.slider_images.find(params[:slider_id]).destroy
  end

  swagger_controller :learning_objects, 'LearningObject', resource_path:
     '/api/admin/v1/learn_mods/:learn_mod_id/learning_objects'

  swagger_api :index do
    summary 'List Learning Object'
    notes 'Should be used to list Learning Object'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'learn_mod_id', :integer, :required, LEARN_MOD_ID
  end

  swagger_api :show do
      summary 'Show Learning Object'
      notes 'Should be used to Show Learning Object'
      param :header, :Authorization, :string, :required, 'Authorization'
      param :path, 'learn_mod_id', :integer, :required, LEARN_MOD_ID
      param :path, 'id', :integer, :required, LEARN_OBJ_ID
    end

  swagger_api :create do
    summary 'Creates a learning object'
    notes 'Should be used to create a learning object'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'learn_mod_id', :integer, :required, LEARN_MOD_ID
    param :form, 'card_type', :string, :required, 'Options: "email", "quiz",
          "video", "text", "slide", "file", "dialogic", "chat", "submission"'
    param :form, LEARN_OBJ, :string, :required, OPTION_STR
    param :form, 'learning_object[name]', :string, :required, 'name'
    param :form, 'learning_object[learning_object_type]', :string, :required,
          'Options: "content", "plot_point", "interaction"'
    param :form, 'learning_object[description]', :string, :optional,
          'description'
    param :form, 'learning_object[admin_notes]', :text, :optional,
          'Administrative Notes'
    param :form, 'learning_object[overall_assessment_required]', :boolean,
          :optional, 'Overall Assement Required? [required for Interaction LO]'
    param :form, 'learning_object[assessment_scheme_id]', :integer,
          :optional, 'Assessment scheme selected [required for Interaction LO]'
    param :form, 'card[title]', :string, :optional, 'title'
    param :form, 'card[email_body]', :string, :optional, 'email_body'
    param :form, 'card[to_character_ids][]', :integer, :optional,
          'to_character_ids'
    param :form, 'card[cc_character_ids][]', :integer, :optional,
          'cc_character_ids'
    param :form, 'card[mentor_character_id]', :integer, :optional,
          'mentor_character_id'
    param :form, 'card[chat_character_id]', :integer, :optional,
          'chat_character_id'
    param :form, 'card[global_video_id]', :integer, :optional, 'global_video_id'
    param :form, 'card[slider_images_attributes][][id]', :integer,
          :optional, 'slider_image id'
    param :form, 'card[slider_images_attributes][][caption]', :string,
          :optional, 'caption'
    param :form, 'card[slider_images_attributes][][][global_resource_id]',
          :integer, :optional, 'global_resource_id'
    param :form, 'card[slider_images_attributes][][_destroy]', :string,
          :optional, 'Set to true to remove slider_image'
    param :form, 'card[has_caption]', :boolean, :optional, 'has_caption'
    param :form, 'card[global_resource_id]', :integer, :optional,
          'global_resource_id'
    param :form, 'card[score_view_type]', :integer, :optional,
          'Options: "numeric", "percentage", "tally_correct_ans" [For Quiz]'
    param :form, 'card[overall_module_assessment_inclusion]', :boolean,
          :optional, 'Apply Quiz Assessment to Overall Module Score [For Quiz]'
    param :form, 'card[character_id]', :integer, :optional,
          'Character Id [For Dialogic]'
    param :form, 'card[has_text]', :boolean, :optional,
          'has_text [For Submission]'
    param :form, 'card[has_file_upload]', :boolean, :optional,
          'has_file_upload [For Submission]'
    param :form, 'card[iteration_enabled]', :boolean, :optional,
          'iteration_enabled [For Email]'
    param :form, 'card[iteration_level]', :integer, :optional,
          'iteration_level [For Email]'
    param :form, 'card[iteration_explanation]', :string, :optional,
          'iteration_explanation [For Email]'
    response :unauthorized
  end

  swagger_api :update do
    summary 'Update a learning object'
    notes 'Should be used to update a learning object'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'learn_mod_id', :integer, :required, LEARN_MOD_ID
    param :path, 'id', :integer, :required, LEARN_OBJ_ID
    param :form, 'card_type', :string, :required, 'Options: "email", "quiz",
          "video","text", "slide", "file", "dialogic", "chat"'
    param :form, LEARN_OBJ, :string, :required, OPTION_STR
    param :form, 'learning_object[name]', :string, :required, 'name'
    param :form, 'learning_object[learning_object_type]', :string, :required,
          'Options: "content", "plot_point", "interaction"'
    param :form, 'learning_object[description]', :text, :optional,
          'description'
    param :form, 'learning_object[admin_notes]', :text, :optional,
          'Administrative Notes'
    param :form, 'learning_object[overall_assessment_required]', :boolean,
          :optional, 'Overall Assement Required? [For Interaction LO]'
    param :form, 'learning_object[assessment_scheme_id]', :integer,
          :optional, 'Assessment scheme selected [required for Interaction LO]'
    param :form, 'card[title]', :string, :optional, 'title'
    param :form, 'card[email_body]', :string, :optional, 'email_body'
    param :form, 'card[to_character_ids][]', :integer, :optional,
          'to_character_ids'
    param :form, 'card[cc_character_ids][]', :integer, :optional,
          'cc_character_ids'
    param :form, 'card[mentor_character_id]', :integer, :optional,
          'mentor_character_id'
    param :form, 'card[chat_character_id]', :integer, :optional,
          'chat_character_id'
    param :form, 'card[global_video_id]', :integer, :optional, 'global_video_id'
    param :form, 'card[slider_images_attributes][][id]', :integer,
          :optional, 'slider_image id'
    param :form, 'card[slider_images_attributes][][caption]', :string,
          :optional, 'caption'
    param :form, 'card[slider_images_attributes][][][global_resource_id]',
          :integer, :optional, 'global_resource_id'
    param :form, 'card[slider_images_attributes][][_destroy]', :string,
          :optional, 'Set to true to remove slider_image'
    param :form, 'card[has_caption]', :boolean, :optional, 'has_caption'
    param :form, 'card[global_resource_id]', :integer, :optional,
          'global_resource_id'
    param :form, 'card[score_view_type]', :integer, :optional,
          'Options: "numeric", "percentage", "tally_correct_ans"[For Quiz]'
    param :form, 'card[overall_module_assessment_inclusion]',
          :boolean, :optional,
          'Apply Quiz Assessment to Overall Module Score [For Quiz]'
    param :form, 'card[character_id]', :integer, :optional,
          'Character Id [For Dialogic]'
    param :form, 'card[has_text]', :boolean, :optional,
          'has_text [For Submission]'
    param :form, 'card[has_file_upload]', :boolean, :optional,
          'has_file_upload [For Submission]'
    param :form, 'card[iteration_enabled]', :boolean, :optional,
          'iteration_enabled [For Email]'
    param :form, 'card[iteration_level]', :integer, :optional,
          'iteration_level [For Email]'
    param :form, 'card[iteration_explanation]', :string, :optional,
          'iteration_explanation [For Email]'
    response :unauthorized
  end

  swagger_api :update_status do
    summary 'Update Learning Object Card status'
    notes 'Should be used to Update Learning Object Card status'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'learn_mod_id', :integer, :required, LEARN_MOD_ID
    param :path, 'id', :string, :required, LEARN_OBJ_ID
    param :form, LEARN_OBJ, :string, :required, OPTION_STR
  end

  swagger_api :remove_slider_image do
    summary 'Remove Slider Image'
    notes 'Should be used to Remove Slider Image'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'learn_mod_id', :integer, :required, LEARN_MOD_ID
    param :path, 'id', :string, :required, LEARN_OBJ_ID
    param :query, 'slider_id', :string, :required, 'slider_id'
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
    params.require(:learning_object).permit(:name, :status, :description,
                                            :learning_object_type,
                                            :overall_assessment_required,
                                            :assessment_scheme_id, :admin_notes)
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
        create_dialog_skill(learn_obj) if need_dialog_skill_for?(learn_obj)
        if email_lo_without_training_inputs?(learn_obj)
          create_nlu_training_inputs(learn_obj)
        end
        render json: learn_obj.response, status: 200
      else
        render json: learn_obj && learn_obj.errors || invalid_card, status: 422
      end
    else
      render json: invalid_card, status: 422
    end
  end

  def create_dialog_skill(learn_obj)
    learn_obj_hsh = { learn_mod: @learn_mod,
                      learning_object: learn_obj.learning_object }
    dialog_skill = AsstElementHandler::DialogSkill.new(learn_obj_hsh)
    dialog_skill.create_dialog_skill
  end

  def need_dialog_skill_for?(learn_obj)
    learn_obj.interaction_obj? &&
      learn_obj.learning_object.assistant_dialog_skill.blank?
  end

  def email_lo_without_training_inputs?(handler)
    lo = handler.learning_object
    lo.objectable_type == 'EmailLearnObj' &&
      lo.nlu_training_inputs.blank?
  end

  def create_nlu_training_inputs(handler)
    lo = handler.learning_object
    (1..5).each do |i|
      lo.nlu_training_inputs.create(
        name: "Training Input #{i}", order_num: i
      )
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
