class Api::Admin::V1::WorldVideosController < ApplicationController
  before_action :set_world_video, only: [:show, :update, :destroy]

  def index
    @world_videos = WorldVideo.all

    render json: @world_videos
  end

  def show
    render json: @world_video
  end

  def create
    @world_video = WorldVideo.new(world_video_params)

    if @world_video.save
      render json: @world_video, status: :created, location: @world_video
    else
      render json: @world_video.errors, status: :unprocessable_entity
    end
  end

  def update
    if @world_video.update(world_video_params)
      render json: @world_video
    else
      render json: @world_video.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @world_video.destroy
  end

  swagger_controller :worlds, 'World', resource_path: '/api/admin/v1/worlds'

  swagger_api :index do
    summary 'List worlds'
    notes 'Should be used to List worlds'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :query, 'page', :string, :optional, 'Page Number'
    param :query, 'search', :string, :optional, 'Search Parameter'
    param :query, 'sort_column', :string, :optional, 'Options: "name", "created_at",
     "is_private", "learn_mods_count"'
    param :query, 'sort_order', :string, :optional, 'Options: "asc", "desc"'
  end

  swagger_api :create do
    summary 'Creates a new World'
    notes 'Should be used to create World'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :form, 'world[name]', :string, :required, 'name'
    param :form, 'world[description]', :string, :optional, 'description'
    param :form, 'world[customer_id]', :integer, :optional, 'customer_id'
    param :form, 'world[is_private]', :boolean, :required, 'is_private'
    response :unauthorized
  end

  swagger_api :show do
    summary 'Show world'
    notes 'Should be used to Show world'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'World Id'
  end

  swagger_api :update do
    summary 'Update World'
    notes 'Should be used to Update World'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'World Id'
    param :form, 'world[name]', :string, :required, 'name'
    param :form, 'world[description]', :string, :optional, 'description'
    param :form, 'world[customer_id]', :integer, :optional, 'customer_id'
    response :unauthorized
  end

  swagger_api :destroy do
    summary 'Destroys a World'
    notes 'Should be used to destroy a World'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'World Id'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_world_video
      @world_video = WorldVideo.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def world_video_params
      params.fetch(:world_video, {})
    end
end
