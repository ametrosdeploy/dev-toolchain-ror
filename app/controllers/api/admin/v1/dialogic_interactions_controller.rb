class Api::Admin::V1::DialogicInteractionsController < Api::Admin::V1::BaseController
  before_action :authenticate_user!
  before_action :set_dialogic_interaction, only: [:show, :update, :destroy]

  # GET /dialogic_interactions
  def index
    @dialogic_interactions = DialogicInteraction.all

    render json: @dialogic_interactions
  end

  # GET /dialogic_interactions/1
  def show
    render json: @dialogic_interaction
  end

  # POST /dialogic_interactions
  def create
    @dialogic_interaction = DialogicInteraction.new(dialogic_interaction_params)

    if @dialogic_interaction.save
      render json: @dialogic_interaction, status: :created, location: @dialogic_interaction
    else
      render json: @dialogic_interaction.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /dialogic_interactions/1
  def update
    if @dialogic_interaction.update(dialogic_interaction_params)
      render json: @dialogic_interaction
    else
      render json: @dialogic_interaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /dialogic_interactions/1
  def destroy
    @dialogic_interaction.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dialogic_interaction
      @dialogic_interaction = DialogicInteraction.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def dialogic_interaction_params
      params.require(:dialogic_interaction).permit(:name, :card_order)
    end
end
