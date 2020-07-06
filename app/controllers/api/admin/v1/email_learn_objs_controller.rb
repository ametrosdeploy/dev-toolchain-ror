# frozen_string_literal: true

class Api::Admin::V1::EmailLearnObjsController < Api::Admin::V1::BaseController
  before_action :set_email_learn_obj, only: %i[nlu_analysis nlu_enrichment_items]
  EMAIL_LO_ID = 'Email Learn Obj ID'

  def nlu_analysis
    nlu_handler = NluElementHandler::EnrichmentItem.new(nlu_hsh)
    if nlu_handler.save_enrichment_items
      render json: LearningObjectNluSerializer.new(@lo).serializable_hash
    else
      render json: { errors: nlu_handler.errors }
    end
  end

  def nlu_enrichment_items
    render json: LearningObjectNluSerializer.new(@lo).serializable_hash
  end

  swagger_controller :email_learn_obj, 'Email Learn Obj'

  swagger_api :nlu_analysis do
    summary 'Analyse NLU Training Inputs'
    notes 'Should be used to analyse NLU Training Inputs'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer,
          :required, EMAIL_LO_ID
  end

  swagger_api :nlu_enrichment_items do
    summary 'Get all NLU enrichment items'
    notes 'Should be used to get NLU enrichment items'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer,
          :required, EMAIL_LO_ID
  end

  private

  def set_email_learn_obj
    @email_lo = EmailLearnObj.find(params[:id])
    @lo = @email_lo.learning_object
  end

  def nlu_hsh
    {
      learning_object: @lo
    }
  end
end
