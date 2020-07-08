# frozen_string_literal: true

class Api::Admin::V1::ResponseFormulasController < Api::Admin::V1::BaseController
  before_action :set_email_response, only: :create
  before_action :set_response_formula, only: :update
  # POST /email_responses
  
  def create
    @response_formula = @email_response.response_formulas.new(email_response_params)
    
    if @response_formula.save
      render json: serialize_rec(@response_formula), status: :created
    else
      render json: @response_formula.errors, status: :unprocessable_entity
    end
 end

  # PATCH/PUT /email_responses/1
  def update
    if @response_formula.update(response_formula_params)
      render json: @email_response
    else
      render json: @email_response.errors, status: :unprocessable_entity
    end
  end

  swagger_controller :response_formulas, 'Response Formulas'
  swagger_api :create do
    summary 'Creates a response formula'
    notes 'Should be used to create a response formula'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'email_response_id', :integer, :required, 'email_response_id'
    param :form, 'card_type', :string, :required, 'Options: "email", "quiz",
          "video", "text", "slide", "file", "dialogic", "chat"'
    param :form, LEARN_OBJ, :string, :required, OPTION_STR
    param :form, 'response_formulas[present_cond_keyword_min]', :integer,
          :optional, "Present condition's keyword min"
    param :form, 'response_formulas[absent_cond_keyword_min]', :integer,
          :optional, "Absent condition's keyword min"

    param :form, 'response_formulas[present_formula][enrichment_items][][enrichment_item_id]',
          :integer, :optional, 'enrichment_item_id'
    param :form, 'response_formulas[present_formula][enrichment_items][][enrichment_item_type]',
          :string, :optional, 'NluEntity|NluKeyword|NluConcept|AsstIntent|AsstEntityValue'

    param :form, 'response_formulas[present_formula][sentiment_attr][sentiment]',
          :string, :optional, 'Positive|Negative'
    param :form, 'response_formulas[present_formula][sentiment_attr][comparator]',
          :string, :optional, 'comparator'
    param :form, 'response_formulas[present_formula][sentiment_attr][score]',
          :integer, :optional, 'score'

    param :form, 'response_formulas[present_formula][emotion][sadness][score]',
          :integer, :optional, 'sadness score'
    param :form, 'response_formulas[present_formula][emotion][sadness][comparator]',
          :integer, :optional, 'sadness comparator'
    param :form, 'response_formulas[present_formula][emotion][joy][comparator]',
          :integer, :optional, 'joy comparator'
    param :form, 'response_formulas[present_formula][emotion][joy][score]',
          :integer, :optional, 'joy score'
    param :form, 'response_formulas[present_formula][emotion][fear][comparator]',
          :integer, :optional, 'fear comparator'
    param :form, 'response_formulas[present_formula][emotion][fear][score]',
          :integer, :optional, 'fear score'
    param :form, 'response_formulas[present_formula][emotion][disgust][comparator]',
          :integer, :optional, 'disgust comparator'
    param :form, 'response_formulas[present_formula][emotion][disgust][score]',
          :integer, :optional, 'disgust score'
    param :form, 'response_formulas[present_formula][emotion][anger][comparator]',
          :integer, :optional, 'anger comparator'
    param :form, 'response_formulas[present_formula][emotion][anger][score]',
          :integer, :optional, 'anger score'

    param :form, 'response_formulas[absent_formula][enrichment_items][][enrichment_item_id]',
          :integer, :optional, 'enrichment_item_id'
    param :form, 'response_formulas[absent_formula][enrichment_items][][enrichment_item_type]',
          :string, :optional, 'NluEntity|NluKeyword|NluConcept|AsstIntent|AsstEntityValue'

    param :form, 'response_formulas[absent_formula][sentiment_attr][sentiment]',
          :string, :optional, 'Positive|Negative'
    param :form, 'response_formulas[absent_formula][sentiment_attr][comparator]',
          :string, :optional, 'comparator'
    param :form, 'response_formulas[absent_formula][sentiment_attr][score]',
          :integer, :optional, 'score'

    param :form, 'response_formulas[absent_formula][emotion][sadness][score]',
          :integer, :optional, 'sadness score'
    param :form, 'response_formulas[absent_formula][emotion][sadness][comparator]',
          :integer, :optional, 'sadness comparator'
    param :form, 'response_formulas[absent_formula][emotion][joy][comparator]',
          :integer, :optional, 'joy comparator'
    param :form, 'response_formulas[absent_formula][emotion][joy][score]',
          :integer, :optional, 'joy score'
    param :form, 'response_formulas[absent_formula][emotion][fear][comparator]',
          :integer, :optional, 'fear comparator'
    param :form, 'response_formulas[absent_formula][emotion][fear][score]',
          :integer, :optional, 'fear score'
    param :form, 'response_formulas[absent_formula][emotion][disgust][comparator]',
          :integer, :optional, 'disgust comparator'
    param :form, 'response_formulas[absent_formula][emotion][disgust][score]',
          :integer, :optional, 'disgust score'
    param :form, 'response_formulas[absent_formula][emotion][anger][comparator]',
          :integer, :optional, 'anger comparator'
    param :form, 'response_formulas[absent_formula][emotion][anger][score]',
          :integer, :optional, 'anger score'
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  def set_email_response
    @email_response = EmailResponse.find(params[:email_response_id])
  end

  def set_response_formula
    @response_formula = ResponseFormula.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def response_formula_params
    params.require(:response_formula).permit(
      :present_cond_keyword_min, :absent_cond_keyword_min
    )
  end

  def serializer
    ResponseFormulaSerializer
  end
end
