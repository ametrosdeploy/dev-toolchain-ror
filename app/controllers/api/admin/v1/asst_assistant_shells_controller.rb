# frozen_string_literal: true

# Controller for customer related requests
class Api::Admin::V1::AsstAssistantShellsController < Api::Admin::V1::BaseController
    include PaginateHsh
    before_action :set_asst_assistant_shell, only: %i[show update destroy]
    LEARN_OBJ_ID = 'learning object ID'

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

    def link_to_dialog_skill
      render json: { url: 'https://cloud.ibm.com/resources' }
    end



    swagger_controller :asst_assistant_shells, 'Assistant Shells', resource_path:
      '/api/admin/v1/asst_assistant_shells'

    swagger_api :index do
      summary 'List all Assistant Shells'
      notes 'Should be used to list all Assistant Shells'
      param :header, :Authorization, :string, :required, 'Authorization'
    end

    swagger_api :create do
        summary 'Creates a new assistant shell within a Watson assistant service instance'
        notes 'Should be used to create an assistant shell'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :form, 'asst_assistant_shell[name]', :string, :optional, 'name'
        param :form, 'asst_assistant_shell[assistant_dialog_skill_id]', :integer, :optional, 'assistant_dialog_skill_id'
        param :form, 'asst_assistant_shell[assistant_id]', :string, :required, 'Assistant ID'
        param :form, 'asst_assistant_shell[url]', :text, :required, 'URL'
        param :form, 'asst_assistant_shell[api_key]', :text, :required, 'API key'
        param :form, 'asst_assistant_shell[credentials_name]', :string, :optional, 'Credentials name'
        response :unauthorized
    end

    swagger_api :update do
        summary 'Updates an assistant shell within a Watson assistant service instance'
        notes 'Should be used to create an assistant shell'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :form, 'asst_assistant_shell[name]', :string, :optional, 'name'
        param :form, 'asst_assistant_shell[assistant_dialog_skill_id]', :integer, :optional, 'assistant_dialog_skill_id'
        param :form, 'asst_assistant_shell[assistant_id]', :string, :required, 'Assistant ID'
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

    swagger_api :link_to_dialog_skill do
      summary 'To navigate to IBM console'
      notes 'Used to navigate to IBM console'
      param :header, :Authorization, :string, :required, 'Authorization'
      param :path, 'learning_object_id', :integer, :required, LEARN_OBJ_ID
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_asst_assistant_shell
      @asst_assistant_shell = AsstAssistantShell.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def asst_assistant_shell_params
      params.require(:asst_assistant_shell).permit(:assistant_dialog_skill_id, :name, :assistant_id, :url, :api_key, :credentials_name)
    end

    def serializer
        AsstAssistantShellSerializer
    end
  end
