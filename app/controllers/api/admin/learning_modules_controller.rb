class Api::Admin::V1::LearningModulesController < Api::Admin::V1::BaseController
  before_action :authenticate_user!
  before_action :set_learning_module, only: [:show, :update, :destroy]

  # GET /learning_modules
  def index
    @learning_modules = LearningModule.all

    render json: @learning_modules
  end

  # GET /learning_modules/1
  def show
    render json: @learning_module
  end

  # POST /learning_modules
  def create
    @learning_module = LearningModule.new(learning_module_params)

    if @learning_module.save
      render json: @learning_module, status: :created, location: @learning_module
    else
      render json: @learning_module.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /learning_modules/1
  def update
    if @learning_module.update(learning_module_params)
      render json: @learning_module
    else
      render json: @learning_module.errors, status: :unprocessable_entity
    end
  end

  # DELETE /learning_modules/1
  def destroy
    @learning_module.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_learning_module
      @learning_module = LearningModule.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def learning_module_params
      params.require(:learning_module).permit(:name, :time_to_complete, :abstract, :world_id)
    end
end
