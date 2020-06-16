# frozen_string_literal: true

# This is the controller for Dialogic Lo ...
class Api::Admin::V1::DialogicLearnObjsController < Api::Admin::V1::BaseController
  before_action :set_dialogic_lo

  def show
    render json: serialize_rec(@dialogic_lo)
  end

  def reorder_questions
    if @dialogic_lo.update(question_reorder_params)
      render json: serialize_rec(@dialogic_lo), status: 200
    else
      render json: @dialogic_lo.errors, status: :unprocessable_entity
    end
  end

  def add_introduction
    if @dialogic_lo.update(dialogic_lo_params)
      render json: serialize_rec(@dialogic_lo), status: 200
    else
      render json: @dialogic_lo.errors, status: :unprocessable_entity
    end
  end

  def add_conclusion
    if @dialogic_lo.update(dialogic_lo_params)
      render json: serialize_rec(@dialogic_lo), status: 200
    else
      render json: @dialogic_lo.errors, status: :unprocessable_entity
    end
  end

  swagger_controller :dialogic_learn_objs, 'DialogicLearnObj', resource_path:
  '/api/admin/v1/dialogic_learn_objs/'

  swagger_api :show do
    summary 'Show a dialogic LO'
    notes 'Should be used to show a dialogic LO'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'ID'
  end

  swagger_api :reorder_questions do
    summary 'Reorder Questions'
    notes 'Should be used to Reorder questions'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'ID'
    param :form, 'dialogic_learn_obj[dialogic_questions_attributes][][id]', :string,
          :required, 'question ID'
    param :form, 'dialogic_learn_obj[dialogic_questions_attributes][][order]',
          :integer, :required, 'question order'
  end

  swagger_api :add_introduction do
    summary 'Adds mentor introduction to a dialogic LO'
    notes 'Should be used to add mentor introduction'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'ID'
    param :form, 'dialogic_learn_obj[introduction]', :string,
          :required, 'introduction'
  end
  swagger_api :add_conclusion do
    summary 'Adds mentor conclusion to a dialogic LO'
    notes 'Should be used to add mentor conclusion'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'ID'
    param :form, 'dialogic_learn_obj[conclusion]', :string,
          :required, 'conclusion'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_dialogic_lo
    @dialogic_lo = DialogicLearnObj.includes(
      dialogic_questions: :question_variations
    ).find(params[:id])
  end

  def question_reorder_params
    params.require(:dialogic_learn_obj).permit(dialogic_questions_attributes:
                                      %i[id order])
  end

  # Only allow a trusted parameter "white list" through.
  def dialogic_lo_params
    params.require(:dialogic_learn_obj).permit(
      :introduction, :conclusion
    )
  end

  def serializer
    DialogicLearnObjSerializer
  end
end
