class Api::Admin::V1::ConceptsController < Api::Admin::V1::BaseController
  before_action :authenticate_user!
  before_action :set_concept, only: [:show, :update, :destroy]

  # GET /concepts
  def index
    @concepts = Concept.all

    render json: @concepts
  end

  # GET /concepts/1
  def show
    render json: ConceptSerializer.new(@concept).serializable_hash
  end

  # POST /concepts
  def create
    @concept = Concept.new(concept_params)

    if @concept.save
      render json: @concept, status: :created, location: @concept
    else
      render json: @concept.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /concepts/1
  def update
    if @concept.update(concept_params)
      render json: @concept
    else
      render json: @concept.errors, status: :unprocessable_entity
    end
  end

  # DELETE /concepts/1
  def destroy
    @concept.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_concept
      @concept = Concept.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def concept_params
      params.require(:concept).permit(:label, :synonyms, :relevance, :mandatory)
    end
end
