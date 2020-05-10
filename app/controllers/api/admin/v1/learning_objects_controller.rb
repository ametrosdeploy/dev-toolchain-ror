class Api::Admin::V1::LearningObjectsController < Api::Admin::V1::BaseController
  before_action :set_learning_object, only: [:show, :update, :destroy]

  # GET /learning_objects
  def index
    @learning_objects = LearningObject.all

    render json: @learning_objects
  end

  # GET /learning_objects/1
  def show
    render json: @learning_object
  end

  # POST /learning_objects
  def create
    @learning_object = LearningObject.new(learning_object_params)

    if @learning_object.save
      render json: @learning_object, status: :created, location: @learning_object
    else
      render json: @learning_object.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /learning_objects/1
  def update
    if @learning_object.update(learning_object_params)
      render json: @learning_object
    else
      render json: @learning_object.errors, status: :unprocessable_entity
    end
  end

  # DELETE /learning_objects/1
  def destroy
    @learning_object.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_learning_object
      @learning_object = LearningObject.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def learning_object_params
      params.require(:learning_object).permit(:learning_module_id, :learning_object_type)
    end
end
