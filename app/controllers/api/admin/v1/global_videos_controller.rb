# frozen_string_literal: true

# Controller for global vidoes related requests
class Api::Admin::V1::GlobalVideosController < Api::Admin::V1::BaseController
  include PaginateHsh
  before_action :authenticate_user!
  before_action :set_global_video, only: %i[show update destroy]
  GLOBAL_VIDEO_ID = 'global video Id'

  def index
    @global_videos = GlobalVideo.includes(%i[customer taggings])
    if params[:search].present?
      @global_videos = @global_videos.search(params[:search])
    end
    @global_videos = @global_videos.paginate(page: params[:page],
                                             per_page: GlobalVideo::PER_PAGE)
                                   .order('id desc')
    render json: serialize_rec(@global_videos).merge!(
      pagination_without_sort_hsh(@global_videos, GlobalVideo)
    )
  end

  def show
    render json: serialize_rec(@global_video)
  end

  def create
    @global_video = GlobalVideo.new(global_video_params)
    if @global_video.save
      render json: serialize_rec(@global_video), status: :created
    else
      render json: @global_video.errors, status: :unprocessable_entity
    end
  end

  def update
    if @global_video.update(global_video_params)
      render json: serialize_rec(@global_video)
    else
      render json: @global_video.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @global_video.destroy
  end

  swagger_controller :global_videos, 'GlobalVideo', resource_path:
    '/api/admin/v1/global_videos'

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
    param :form, 'global_video[title]', :string, :optional, 'title'
    param :form, 'global_video[description]', :string, :optional, 'description'
    param :form, 'global_video[wistia_code]', :string, :required, 'wistia_code'
    param :form, 'global_video[duration]', :integer, :required, 'duration'
    param :form, 'global_video[private]', :boolean, :optional, 'private'
    param :form, 'global_video[transcript]', :string, :optional, 'transcript'
    param :form, 'global_video[customer_id]', :integer, :optional, 'customer_id'
    param :form, 'global_video[wistia_thumbnail]', :string, :optional,
          'wistia_thumbnail'
    param :form, 'global_video[tag_list]', :string, :optional,
          'tag_list(Comma seperated)'
    response :unauthorized
  end

  swagger_api :show do
    summary 'Show global video'
    notes 'Should be used to Show global video'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, GLOBAL_VIDEO_ID
  end

  swagger_api :update do
    summary 'Update global video'
    notes 'Should be used to Update global video'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, GLOBAL_VIDEO_ID
    param :form, 'global_video[title]', :string, :optional, 'title'
    param :form, 'global_video[description]', :string, :optional, 'description'
    param :form, 'global_video[wistia_code]', :string, :required, 'wistia_code'
    param :form, 'global_video[duration]', :integer, :required, 'duration'
    param :form, 'global_video[private]', :boolean, :optional, 'private'
    param :form, 'global_video[transcript]', :string, :optional, 'transcript'
    param :form, 'global_video[customer_id]', :integer, :optional, 'customer_id'
    param :form, 'global_video[wistia_thumbnail]', :string, :optional,
          'wistia_thumbnail'
    param :form, 'global_video[tag_list]', :string, :optional,
          'tag_list(Comma seperated)'
    response :unauthorized
  end

  swagger_api :destroy do
    summary 'Destroy a global video'
    notes 'Should be used to destroy a global video'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, GLOBAL_VIDEO_ID
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_global_video
    @global_video = GlobalVideo.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def global_video_params
    params.require(:global_video).permit(:title, :description, :wistia_code,
                                         :duration, :video_type, :private,
                                         :transcript, :wistia_thumbnail,
                                         :customer_id, :tag_list)
  end

  def serializer
    GlobalVideoSerializer
  end
end
