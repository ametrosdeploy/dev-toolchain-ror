# frozen_string_literal: true

# Here goes the code for Interstitial Contents setup ...
class Api::Admin::V1::InterstitialContentsController < Api::Admin::V1::BaseController
  before_action :set_email_learn_obj, only: %i[index create]
  before_action :set_interstitial_content, only: %i[destroy]

  CONTENT_TYPES = { video: 1, text: 2, slide: 3, file: 4 }
                  .with_indifferent_access.freeze

  def index
    @interstitial_contents = @email_learn_obj.interstitial_contents
    render json: serialize_rec(@interstitial_contents)
  end

  def create
    if content_type
      content = InterstitialContentHandler::CreateManager.for(create_hsh)
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
    @interstitial_content.destroy
  end

  swagger_controller :interstitial_content, 'Interstitial Content'

  swagger_api :index do
    summary 'List all interstitial contents in an Email LO'
    notes 'Should be used to List all interstitial content in an Email LO'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'email_learn_obj_id', :integer, :required, 'Email LO ID'
  end

  swagger_api :create do
    summary 'Creates an interstitial content'
    notes 'Should be used to create an interstitial content'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'email_learn_obj_id', :integer, :required, 'Email LO ID'
    param :form, 'content_type', :string, :required, 'Options: "video",
          "text", "slide", "file"'
    param :form, 'content[title]', :string, :optional, 'title'
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
    summary 'Destroy an interstitial content'
    notes 'Should be used to destroy an interstitial content'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'ID'
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  def set_email_learn_obj
    @email_learn_obj = EmailLearnObj.find(params[:email_learn_obj_id])
  end

  def set_interstitial_content
    @interstitial_content = InterstitialContent.find(params[:id])
  end

  def create_hsh
    {
      content_type: content_type,
      params: params,
      email_learn_obj: @email_learn_obj,
      content: @email_learn_obj.interstitial_contents.build
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
    InterstitialContentSerializer
  end
end
