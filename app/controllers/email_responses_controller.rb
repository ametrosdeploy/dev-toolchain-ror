class EmailResponsesController < ApplicationController
  before_action :set_email_response, only: [:show, :update, :destroy]

  # GET /email_responses
  def index
    @email_responses = EmailResponse.all

    render json: @email_responses
  end

  # GET /email_responses/1
  def show
    render json: @email_response
  end

  # POST /email_responses
  def create
    @email_response = EmailResponse.new(email_response_params)

    if @email_response.save
      render json: @email_response, status: :created, location: @email_response
    else
      render json: @email_response.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /email_responses/1
  def update
    if @email_response.update(email_response_params)
      render json: @email_response
    else
      render json: @email_response.errors, status: :unprocessable_entity
    end
  end

  # DELETE /email_responses/1
  def destroy
    @email_response.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email_response
      @email_response = EmailResponse.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def email_response_params
      params.require(:email_response).permit(:name)
    end
end
