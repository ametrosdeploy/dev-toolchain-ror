# frozen_string_literal: true

# Here goes the code for Admin email Response setup ...
class Api::Admin::V1::EmailResponsesController < Api::Admin::V1::BaseController
  before_action :set_email_learn_obj, only: %i[index create]
  before_action :set_email_response, only: %i[show update destroy]

  # GET /email_responses
  def index
    @email_responses = @email_learn_obj.email_responses
    render json: serialize_rec(@email_responses)
  end

  # GET /email_responses/1
  def show
    render json: serialize_rec(@email_response)
  end

  # POST /email_responses
  def create
    @email_response = @email_learn_obj.email_responses
                                      .new(email_response_params)
    if @email_response.save
      render json: serialize_rec(@email_response), status: :created
    else
      render json: @email_response.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /email_responses/1
  def update
    if @email_response.update(email_response_params)
      render json: serialize_rec(@email_response)
    else
      render json: @email_response.errors, status: :unprocessable_entity
    end
  end

  # DELETE /email_responses/1
  def destroy
    @email_response.destroy
  end

  swagger_controller :email_responses, 'Email Response'

  swagger_api :index do
    summary 'List all email responses in an Email LO'
    notes 'Should be used to List all email responses in an Email LO'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'email_learn_obj_id', :integer, :required, 'Email LO ID'
  end

  swagger_api :create do
    summary 'Creates an email responses'
    notes 'Should be used to create an email responses'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'email_learn_obj_id', :integer, :required, 'Email LO ID'
    param :form, 'email_response[name]', :string, :required, 'Name'
    param :form, 'email_response[character_id]', :integer,
          :required, 'character_id'

    response :unauthorized
  end

  swagger_api :update do
    summary 'Updates an email response'
    notes 'Should be used to update an email response'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'ID'
    param :form, 'email_response[name]', :string, :required, 'Name'
    param :form, 'email_response[char_response_variations_attributes][][id]',
          :integer, :optional, 'Char Response Variation ID'
    param :form, 'email_response[char_response_variations_attributes]
          [][response]', :string, :optional, 'Char Response'
    param :form, 'email_response[char_response_variations_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'

    response :unauthorized
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  def set_email_learn_obj
    @email_learn_obj = EmailLearnObj.find(params[:email_learn_obj_id])
  end

  def set_email_response
    @email_response = EmailResponse.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def email_response_params
    params.require(:email_response).permit(
      :name, :character_id, 
      char_response_variations_attributes: %i[id response _destroy]
    )
  end

  def serializer
    EmailResponseSerializer
  end
end
