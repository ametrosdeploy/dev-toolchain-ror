# frozen_string_literal: true

# Here goes the code for Adaptive Content setup ...
class Api::Admin::V1::AdaptiveContentsController < Api::Admin::V1::BaseController
  before_action :set_adaptable_class, only: %i[create]
  before_action :set_adaptive_content, only: %i[destroy]

  CONTENT_TYPES = { video: 1, text: 2, slide: 3, file: 4 }
                  .with_indifferent_access.freeze

  def create
    if content_type
      content = AdaptiveContentHandler::CreateManager.for(create_hsh)
      if content&.save_record
        render json: content.response, status: 200
      else
        render json: content && content.errors || invalid_content, status: 422
      end
    else
      render json: invalid_content, status: 422
    end
  end

  def destroy
    @adaptive_content.destroy
  end

  swagger_controller :adaptive_content, 'Adaptive Content'

  swagger_api :create do
    summary 'Creates an adaptive content'
    notes 'Should be used to create an adaptive content'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :form, 'content_type', :string, :required, 'Options: "video",
          "text", "slide", "file"'
    param :form, 'adaptable_type', :string, :required, 'Options: "QuizQuestion",
          "DialogicAssmntItem", "MissedAssmntItem", "ChatSkillAssmntItem",
          "ChatSkillAssmntMissed", "EmailAssmntItem"'
    param :form, 'adaptable_id', :integer, :required, 'Adaptable ID'
    param :form, 'adaptive_content[title]', :string, :optional, 'title'
    param :form, 'adaptive_content[description]', :string, :optional,
          'Description'
    param :form, 'content[title]', :string, :optional, 'Rich Text'
    param :form, 'content[global_resource_id]', :integer, :optional,
          'global_resource_id'
    param :form, 'content[global_video_id]', :integer, :optional,
          'global_video_id'
    param :form, 'content[slider_images_attributes][][id]', :integer,
          :optional, 'slider_image id'
    param :form, 'content[slider_images_attributes][][caption]', :string,
          :optional, 'caption'
    param :form, 'content[slider_images_attributes][][][global_resource_id]',
          :integer, :optional, 'global_resource_id'
    param :form, 'content[slider_images_attributes][][_destroy]', :string,
          :optional, 'Set to true to remove slider_image'
    param :form, 'content[has_caption]', :boolean, :optional, 'has_caption'
    response :unauthorized
  end

  swagger_api :destroy do
    summary 'Destroy an adaptive content'
    notes 'Should be used to destroy an adaptive content'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'ID'
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  def set_adaptable_class
    @klass = params[:adaptable_type].constantize
    @adaptable = @klass.find(params[:adaptable_id])
  end

  def set_adaptive_content
    @adaptive_content = AdaptiveContent.find(params[:id])
  end

  def adaptive_content_params
    params.require(:adaptive_content).permit(:title, :description)
  end

  def create_hsh
    {
      content_type: content_type,
      params: params,
      adaptable_obj: @adaptable,
      adaptive_content_params: adaptive_content_params,
      content: @adaptable.adaptive_contents.build
    }
  end

  def invalid_content
    {
      message: 'Invalid Content Type'
    }
  end

  def content_type
    CONTENT_TYPES[params[:content_type]]
  end

  def serializer
    AdaptiveContentSerializer
  end
end
