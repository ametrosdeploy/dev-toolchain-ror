class Api::Admin::V1::ChatLearnObjsController < Api::Admin::V1::BaseController
  before_action :authenticate_user!
  before_action :set_chat_learn_obj, only: [:show, :update, :destroy]

  # GET /chat_learn_objs
  def index
    @chat_learn_objs = ChatLearnObj.all
    render json: serialize_rec(@chat_learn_objs)
  end

  # GET /chat_learn_objs/1
  def show
    render json: serialize_rec(@chat_learn_obj)
  end

  # POST /chat_learn_objs
  def create
    @chat_learn_obj = ChatLearnObj.new(chat_learn_obj_params)

    if @chat_learn_obj.save
      render json: serialize_rec(@chat_learn_obj), status: :created, location: @chat_learn_obj
    else
      render json: @chat_learn_obj.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /chat_learn_objs/1
  def update
    if @chat_learn_obj.update(chat_learn_obj_params)
      render json: serialize_rec(@chat_learn_obj)
    else
      render json: @chat_learn_obj.errors, status: :unprocessable_entity
    end
  end

  # DELETE /chat_learn_objs/1
  def destroy
    @chat_learn_obj.destroy
  end

  swagger_controller :chat_learn_objs, 'ChatLearnObj', resource_path: '/api/admin/v1/worlds/:world_id/world_organizations'


  private
    # Use callbacks to share common setup or constraints between actions.

    def set_learning_module
      @learning_module  =  LearningModule.find(params[:learning_module_id])
    end

    def set_chat_learn_obj
      @chat_learn_obj = ChatLearnObj.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def chat_learn_obj_params
      params.require(:chat_learn_obj).permit(:administrative_notes, :chat_character_id, :mentor_character_id)
    end

    def serializer
      ChatLearnObjSerializer
    end
end
