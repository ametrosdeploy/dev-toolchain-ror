# frozen_string_literal: true

# Controller for customer related requests
class Api::Admin::V1::AsstAssistantShellsController < Api::Admin::V1::BaseController
  include PaginateHsh
  before_action :set_asst_assistant_shell, only: %i[show update destroy]

  def index
    @asst_assistant_shells = AsstAssistantShell.all
    render json: @asst_assistant_shells
  end

  def show
    render json: @asst_assistant_shell
  end

  def create
    @asst_assistant_shell = AsstAssistantShell.new(asst_assistant_shell_params)

    if @asst_assistant_shell.save
      render json: @asst_assistant_shell, status: :created
    else
      render json: @asst_assistant_shell.errors, status: :unprocessable_entity
    end
  end

  def update
    if @asst_assistant_shell.update(asst_assistant_shell_params)
      render json: @asst_assistant_shell
    else
      render json: @asst_assistant_shell.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @asst_assistant_shell.destroy
  end

  # Needed to auto complete customer data
  def auto_comp_data
    @asst_assistant_shells = AsstAssistantShell.all
    if params[:search].present?
      @asst_assistant_shells = @asst_assistant_shells.where('name ilike ?', "%#{params[:search]}%")
    end
    @asst_assistant_shells = @asst_assistant_shells.paginate(page: params[:page], per_page: 5)
    render json: serialize_rec(@asst_assistant_shells).merge!(
      pagination_without_sort_hsh(@asst_assistant_shells, Customer)
    )
  end

  swagger_controller :asst_assistant_shells, 'Assistant Shells', resource_path:
    '/api/admin/v1/asst_assistant_shells'

  swagger_api :auto_comp_data do
    summary 'Assistant Shell auto complete data'
    notes 'Should be used to auto complete assistant shell data'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :query, 'page', :string, :optional, 'Page Number'
    param :query, 'search', :string, :optional, 'Search Parameter'
  end

  swagger_api :create do
    summary 'Creates a new assistant shell within a Watson assistant service instance'
    notes 'Should be used to create an assistant shell'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :form, 'asst_assistant_shell[name]', :string, :required, 'name'
    param :form, 'asst_assistant_shell[assistant_dialog_skill_id]', :integer, :optional, 'assistant_dialog_skill_id'
    param :form, 'asst_assistant_shell[guid]', :strig, :required, 'Assistant ID'
    param :form, 'asst_assistant_shell[url]', :text, :required, 'URL'
    param :form, 'asst_assistant_shell[api_key]', :text, :required, 'API key'
    param :form, 'asst_assistant_shell[credentials_name]', :string, :optional, 'Credentials name'
    response :unauthorized
  end

  swagger_api :update do
    summary 'Updates an assistant shell within a Watson assistant service instance'
    notes 'Should be used to create an assistant shell'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :form, 'asst_assistant_shell[name]', :string, :required, 'name'
    param :form, 'asst_assistant_shell[assistant_dialog_skill_id]', :integer, :optional, 'assistant_dialog_skill_id'
    param :form, 'asst_assistant_shell[guid]', :strig, :required, 'Assistant ID'
    param :form, 'asst_assistant_shell[url]', :text, :required, 'URL'
    param :form, 'asst_assistant_shell[api_key]', :text, :required, 'API key'
    param :form, 'asst_assistant_shell[credentials_name]', :string, :optional, 'Credentials name'
    response :unauthorized
  end

  swagger_api :show do
    summary 'Show assistant shell'
    notes 'Should be used to show assistant shell'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'Asst Assistant Shell ID'
  end

  swagger_api :destroy do
    summary 'Destroy assistant shell'
    notes 'Should be used to destroy an assistant shell'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'Asst Assistant Shell ID'
  end

    private

  # Use callbacks to share common setup or constraints between actions.
  def set_asst_assistant_shell
    @asst_assistant_shell = AsstAssistantShell.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def asst_assistant_shell_params
    params.require(:asst_assistant_shell).permit(:assistant_dialog_skill_id, :name, :guid, :url, :api_key, :credentials_name)
  end

  def serializer
    AsstAssistantShellSerializer
  end
  end
