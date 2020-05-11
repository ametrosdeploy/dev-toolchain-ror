class EmailInteractionsController < ApplicationController
  before_action :set_email_interaction, only: [:show, :update, :destroy]

  # GET /email_interactions
  def index
    @email_interactions = EmailInteraction.all

    render json: @email_interactions
  end

  # GET /email_interactions/1
  def show
    render json: @email_interaction
  end

  # POST /email_interactions
  def create
    @email_interaction = EmailInteraction.new(email_interaction_params)

    if @email_interaction.save
      render json: @email_interaction, status: :created, location: @email_interaction
    else
      render json: @email_interaction.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /email_interactions/1
  def update
    if @email_interaction.update(email_interaction_params)
      render json: @email_interaction
    else
      render json: @email_interaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /email_interactions/1
  def destroy
    @email_interaction.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email_interaction
      @email_interaction = EmailInteraction.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def email_interaction_params
      params.require(:email_interaction).permit(:card_order, :next_chain_id, :name)
    end
end
