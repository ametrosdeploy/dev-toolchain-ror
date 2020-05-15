class Api::Admin::V1::GlobalResourcesController < Api::Admin::V1::BaseController
  before_action :authenticate_user!
  before_action :set_global_resource, only: %i[show update destroy]

  def index
    @global_res = GlobalResource.joins(:attachment_blob).includes(:customer,
                                                   attachment_attachment: :blob)
    if params[:search].present?
      @global_res = @global_res.search(params[:search])
    end
    @global_res = @global_res.where(resource_type: params[:resource_type])
    @global_res = @global_res.paginate(page: params[:page],
                                       per_page: GlobalResource::PER_PAGE)
    @global_res = @global_res.order("#{sort_column} #{sort_order}")
    render json: serialize_rec(@global_res).merge!(paginate_hsh(@global_res))
  end

  def show
    render json: serialize_rec(@global_resource)
  end

  def create
    @global_resource = GlobalResource.new(global_resource_params)
    if @global_resource.save
      render json: serialize_rec(@global_resource), status: :created
    else
      render json: @global_resource.errors, status: :unprocessable_entity
    end
  end

  def update
    if @global_resource.update(global_resource_params)
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
    param :query, 'sort_column', :string, :optional, 'Options: '
    param :query, 'sort_order', :string, :optional, 'Options: "asc", "desc"'
  end

  swagger_api :create do
    summary 'Creates a new global resource'
    notes 'Should be used to create global resource'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :form, 'global_resource[title]', :string, :required, 'title'
    param :form, 'global_resource[description]', :string, :optional, 'description'
    param :form, 'global_resource[resource_type]', :string, :required, '
    resource_type Options: "image", "document"'
    param :form, 'global_resource[content_type]', :string, :required, '
    resource_type Options: "content", "plot_point", "module_intro"'
    param :form, 'global_resource[private]', :boolean, :optional, 'private'
    param :form, 'global_resource[customer_id]', :integer, :optional, 'customer_id'
    param :form, 'global_resource[tag_list]', :string, :required, 'tag_list
                                                              (Comma seperated)'
    param :form, 'global_resource[attachment]', :integer, :optional, 'attachment'
    response :unauthorized
  end

  swagger_api :show do
    summary 'Show global resource'
    notes 'Should be used to Show global resource'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'global resource Id'
  end

  swagger_api :update do
    summary 'Update global resource'
    notes 'Should be used to Update global resource'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'global resource Id'
    param :form, 'global_resource[title]', :string, :required, 'title'
    param :form, 'global_resource[description]', :string, :optional, 'description'
    param :form, 'global_resource[resource_type]', :string, :required,
          'resource_type Options: "image", "document"'
    param :form, 'global_resource[content_type]', :string, :required, '
    resource_type Options: "content", "plot_point", "module_intro"'
    param :form, 'global_resource[private]', :boolean, :optional, 'private'
    param :form, 'global_resource[customer_id]', :integer, :optional, 'customer_id'
    param :form, 'global_resource[tag_list]', :string, :optional, 'tag_list
                                                              (Comma seperated)'
    param :form, 'global_resource[attachment]', :integer, :optional, 'attachment'
    response :unauthorized
  end

  swagger_api :destroy do
    summary 'Destroys a global resource'
    notes 'Should be used to destroy a global resource'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'global resource Id'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_global_resource
    @global_resource = GlobalResource.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def global_resource_params
    params.require(:global_resource).permit(:title, :description, :content_type,
                                            :private, :customer_id, :tag_list, :resource_type, :attachment)
  end

  def serializer
    GlobalResourceSerializer
  end

  # This method is needed as we do not need sorting in case of image
  def paginate_hsh(records)
    if params[:resource_type] == 'image'
      custom_paginate_without_sort_hsh(records, GlobalResource.with_image)
    else
      pagination_hsh(records, GlobalResource)
    end
  end

  # Set default sort Column
  def sort_column
    valid_sort && params[:sort_column] || 'id'
  end

  # Validate sort key & set default sort type
  def sort_order
    sort_type = params[:sort_type]
    sort_type.present? && %w[asc desc].include?(sort_type) && sort_type || 'desc'
  end

  # Verify available sort options
  def valid_sort
    params[:sort_column].present? && %w[active_storage_blobs.filename created_at
                                        active_storage_blobs.byte_size].include?(params[:sort_column])
  end

  def doc_req?
    params[:resource_type] == 'document'
  end

  # Generates a hash of pagination & sort data needed for pagination
  def custom_paginate_hsh(data, class_name_with_scope)
    {
      filtered_count: data.total_entries,
      total_count: class_name_with_scope.count,
      total_pages: data.total_pages,
      limit_per_page: GlobalResource::PER_PAGE,
      current_page: params[:page].presence || 1,
      sort_column: sort_column,
      sort_order: sort_order
    }
  end

  # Generates a hash of pagination data needed for pagination
  def custom_paginate_without_sort_hsh(data, class_name_with_scope)
    {
      filtered_count: data.total_entries,
      total_count: class_name_with_scope.count,
      total_pages: data.total_pages,
      limit_per_page: GlobalResource::PER_PAGE,
      current_page: params[:page].presence || 1
    }
  end
end
