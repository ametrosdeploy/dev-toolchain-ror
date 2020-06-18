# frozen_string_literal: true

# Learner Module detail controller
class Api::V1::ModuleDetailsController < Api::V1::BaseController
  before_action :set_user_section
  before_action :set_user_learn_obj, only: %w[update show]
  USER_SECTION_ID = 'user_section ID'

  def index
    user_learn_objs = @user_section.user_learn_objs
                                   .includes([:learning_object])
    args = { params: { next_step_id: @user_section.next_step.try(:id) } }
    render json: {
      user_learn_objs: serializer.new(user_learn_objs, args).serializable_hash,
      intro_data: Learner::LearnModIntroSerializer.new(@user_section.learn_mod)
                                                  .as_json['data']
    }
  end

  def show
    if @user_learn_obj.valid_step?
      render json: serialize_rec(@user_learn_obj)
    else
      render json: invalid_step, status: :unprocessable_entity
    end
  end

  def update
    if !@user_learn_obj.valid_step?
      render json: invalid_step, status: :unprocessable_entity
    elsif @user_learn_obj.update(user_learn_obj_params)
      render json: serialize_rec(@user_learn_obj)
    else
      render json: @user_learn_obj.errors, status: :unprocessable_entity
    end
  end

  swagger_controller :module_details, 'UserSection', resource_path:
    '/api/v1/module_details'

  swagger_api :index do
    summary 'Module details page'
    notes 'Should be used for Module details page content'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'module_id', :integer, :required, USER_SECTION_ID
  end
  swagger_api :show do
    summary 'Show user LO'
    notes 'Should be used to show user LO'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'module_id', :integer, :required, USER_SECTION_ID
    param :path, 'id', :integer, :required, 'user learning object ID'
  end
  swagger_api :update do
    summary 'Update user LO status'
    notes 'Should be used to update user LO status'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'module_id', :integer, :required, USER_SECTION_ID
    param :path, 'id', :integer, :required, 'user learning object ID'
    param :form, 'user_learn_obj[complete]', :boolean, :optional,
          'set this to true when complete'
    response :unauthorized
  end

  private

  def set_user_section
    @user_section = UserSection.find(params[:module_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user_learn_obj
    @user_learn_obj = @user_section.user_learn_objs.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_learn_obj_params
    params.require(:user_learn_obj).permit(:complete)
  end

  def serializer
    Learner::UserLearnObjSerializer
  end

  def invalid_step
    {
      message: I18n.t(:invalid_step)
    }
  end
end
