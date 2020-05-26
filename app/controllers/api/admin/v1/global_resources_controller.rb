# frozen_string_literal: true

# Controller for global resource related requests
class Api::Admin::V1::GlobalResourcesController < Api::Admin::V1::BaseController
  before_action :authenticate_user!
  before_action :set_global_resource, only: %i[show update destroy]
  GLOBAL_RESOURCE_ID = 'global resource Id'

  def index
    @list = Listing::GlobalResources.new({ params: params })
    render json: @list.data
  end

  def show
    render json: serialize_rec(@global_resource)
  end

  def create
    @global_resource = GlobalResource.new(global_resource_params)
    set_attachment
    if @global_resource.save
      render json: serialize_rec(@global_resource), status: :created
    else
      render json: @global_resource.errors, status: :unprocessable_entity
    end
  end

  def update
    set_attachment if params[:global_resource][:attachment].present?
    @global_resource.assign_attributes(global_resource_params)
    if @global_resource.save
      render json: serialize_rec(@global_resource)
    else
      render json: @global_resource.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @global_resource.destroy
  end

  swagger_controller :global_resources, 'GlobalResource', resource_path:
                                                '/api/admin/v1/global_resources'
  swagger_api :index do
    summary 'List global resources'
    notes 'Should be used to List global resources'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :query, 'resource_type', :string, :required, 'resource_type Options:
    "image", "document"'
    param :query, 'page', :string, :optional, 'Page Number'
    param :query, 'search', :string, :optional, 'Search Parameter'
    param :query, 'sort_column', :string, :optional, 'Options: "created_at",
    "active_storage_blobs.filename", "active_storage_blobs.byte_size"'
    param :query, 'sort_order', :string, :optional, 'Options: "asc", "desc"'
  end

  swagger_api :create do
    summary 'Creates a new global resource'
    notes 'Should be used to create global resource'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :form, 'global_resource[title]', :string, :optional, 'title'
    param :form, 'global_resource[description]', :string, :optional,
          'description'
    param :form, 'global_resource[resource_type]', :string, :required, '
    resource_type Options: "image", "document"'
    param :form, 'global_resource[private]', :boolean, :optional, 'private'
    param :form, 'global_resource[customer_id]', :integer, :optional,
          'customer_id'
    param :form, 'global_resource[tag_list]', :string, :optional, 'tag_list
                                                              (Comma seperated)'
    param :form, 'global_resource[attachment]', :string, :optional, 'attachment'
    response :unauthorized
  end

  swagger_api :show do
    summary 'Show global resource'
    notes 'Should be used to Show global resource'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, GLOBAL_RESOURCE_ID
  end

  swagger_api :update do
    summary 'Update global resource'
    notes 'Should be used to Update global resource'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, GLOBAL_RESOURCE_ID
    param :form, 'global_resource[title]', :string, :optional, 'title'
    param :form, 'global_resource[description]', :string, :optional,
          'description'
    param :form, 'global_resource[resource_type]', :string, :required,
          'resource_type Options: "image", "document"'
    param :form, 'global_resource[private]', :boolean, :optional, 'private'
    param :form, 'global_resource[customer_id]', :integer, :optional,
          'customer_id'
    param :form, 'global_resource[tag_list]', :string, :optional, 'tag_list
                                                              (Comma seperated)'
    param :form, 'global_resource[attachment]', :string, :optional, 'attachment'
    response :unauthorized
  end

  swagger_api :destroy do
    summary 'Destroys a global resource'
    notes 'Should be used to destroy a global resource'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, GLOBAL_RESOURCE_ID
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_global_resource
    @global_resource = GlobalResource.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def global_resource_params
    params.require(:global_resource).permit(:title, :description, :customer_id,
                                            :private, :tag_list, :resource_type)
  end

  def serializer
    GlobalResourceSerializer
  end

  def set_attachment
    attachment_file = params[:global_resource][:attachment]
    if attachment_file.tempfile.present?
      @global_resource.attachment = attachment_file
    else
      @global_resource.attachment.attach(data: attachment_file)
    end
  end
end
