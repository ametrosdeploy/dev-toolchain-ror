class Api::Admin::V1::GlobalResourcesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_global_resource, only: [:show, :update, :destroy]

  def index
    @global_resources = GlobalResource.includes(:customer, :wistia_thumbnail_attachment, :taggings)
    @global_resources = @global_resources.search(params[:search]) if params[:search].present?
    @global_resources = @global_resources.paginate(page: params[:page], 
                                                   per_page: GlobalResource::PER_PAGE)
    render json: serialize_rec(@global_resources).merge!(
                              pagination_without_sort_hsh(@global_resources, GlobalResource))
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

  swagger_controller :global_videos, 'GlobalVideo', resource_path: '/api/admin/v1/global_videos'

  swagger_api :index do
    summary 'List global videos'
    notes 'Should be used to List global videos'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :query, 'page', :string, :optional, 'Page Number'
    param :query, 'search', :string, :optional, 'Search Parameter'
  end

  swagger_api :create do
    summary 'Creates a new global video'
    notes 'Should be used to create global video'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :form, 'global_video[title]', :string, :required, 'title'
    param :form, 'global_video[description]', :string, :optional, 'description'
    param :form, 'global_video[wistia_code]', :string, :required, 'wistia_code'
    param :form, 'global_video[duration]', :integer, :required, 'duration'
    param :form, 'global_video[video_type]', :string, :required, 'video_type Options:
     "content", "plot_point", "module_intro"'
    param :form, 'global_video[private]', :boolean, :optional, 'private'
    param :form, 'global_video[transcript]', :string, :required, 'transcript'
    param :form, 'global_video[customer_id]', :integer, :optional, 'customer_id'
    param :form, 'global_video[wistia_thumbnail]', :string, :optional, 'wistia_thumbnail'
    param :form, 'global_video[tag_list]', :string, :required, 'tag_list(Comma seperated)'
    response :unauthorized
  end

  swagger_api :show do
    summary 'Show global video'
    notes 'Should be used to Show global video'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'global video Id'
  end

  swagger_api :update do
    summary 'Update global video'
    notes 'Should be used to Update global video'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'global video Id'
    param :form, 'global_video[title]', :string, :required, 'title'
    param :form, 'global_video[description]', :string, :optional, 'description'
    param :form, 'global_video[wistia_code]', :string, :required, 'wistia_code'
    param :form, 'global_video[duration]', :integer, :required, 'duration'
    param :form, 'global_video[video_type]', :string, :required, 'video_type Options: '
    param :form, 'global_video[private]', :boolean, :optional, 'private'
    param :form, 'global_video[transcript]', :string, :required, 'transcript'
    param :form, 'global_video[customer_id]', :integer, :optional, 'customer_id'
    param :form, 'global_video[wistia_thumbnail]', :string, :optional, 'wistia_thumbnail'
    param :form, 'global_video[tag_list]', :string, :required, 'tag_list(Comma seperated)'
    response :unauthorized
  end

  swagger_api :destroy do
    summary 'Destroys a global video'
    notes 'Should be used to destroy a global video'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'global video Id'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_global_resource
      @global_resource = GlobalResource.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def global_resource_params
      params.require(:global_resource).permit(:title, :description, :content_type, 
        :private, :customer_id, :tag_list)
    end

    def serializer
      GlobalVideoSerializer
    end
end
