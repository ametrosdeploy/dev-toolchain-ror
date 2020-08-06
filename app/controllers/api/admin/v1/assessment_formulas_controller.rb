# frozen_string_literal: true

# This handle email Assessment formula related APIs ...
class Api::Admin::V1::AssessmentFormulasController < Api::Admin::V1::BaseController
  before_action :set_email_response, only: :create
  before_action :set_response_formula, only: :update

  # POST /email_responses
  def create
    @assessment_formula = @email_response.assessment_formulas
                                       .new(assessment_formula_params)
    if @assessment_formula.save
      render json: serialize_rec(@assessment_formula), status: :created
    else
      render json: @assessment_formula.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /email_responses/1
  def update
    if @assessment_formula.update(assessment_formula_params)
      render json: serialize_rec(@assessment_formula)
    else
      render json: @assessment_formula.errors, status: :unprocessable_entity
    end
  end

  swagger_controller :assessment_formulas, 'Assessment Formulas'

  swagger_api :create do
    summary 'Creates a response formula'
    notes 'Should be used to create a response formula'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'email_assessment_item_id', :integer, :required, 'Email Assessment Item ID'
    param :form, 'assessment_formula[present_cond_keyword_min]', :integer,
          :optional, "Present condition's keyword min"
    param :form, 'assessment_formula[absent_cond_keyword_min]', :integer,
          :optional, "Absent condition's keyword min"
    param :form, 'assessment_formula[sentiment_enabled]', :boolean,
          :optional, 'sentiment enabled?'
    param :form, 'assessment_formula[emotion_enabled]', :boolean,
          :optional, 'emotion enabled?'
    param :form, 'assessment_formula[assessment_formula_nlu_entities_attributes][][id]',
          :integer, :optional, 'id'
    param :form, 'assessment_formula[assessment_formula_nlu_entities_attributes]
          [][nlu_entity_id]', :integer, :optional, 'nlu_entity_id'
    param :form, 'assessment_formula[assessment_formula_nlu_entities_attributes]
          [][present]', :boolean, :optional,
          'Set true if a part of present condition'
    param :form, 'assessment_formula[assessment_formula_nlu_entities_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
    param :form, 'assessment_formula[assessment_formula_nlu_keywords_attributes][][id]',
          :integer, :optional, 'id'
    param :form, 'assessment_formula[assessment_formula_nlu_keywords_attributes]
          [][nlu_keyword_id]', :integer, :optional, 'nlu_keyword_id'
    param :form, 'assessment_formula[assessment_formula_nlu_keywords_attributes][][present]',
          :boolean, :optional, 'Set true if a part of present condition'
    param :form, 'assessment_formula[assessment_formula_nlu_keywords_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
    param :form, 'assessment_formula[assessment_formula_nlu_concepts_attributes][][id]',
          :integer, :optional, 'id'
    param :form, 'assessment_formula[assessment_formula_nlu_concepts_attributes]
          [][nlu_concept_id]', :integer, :optional, 'nlu_concept_id'
    param :form, 'assessment_formula[assessment_formula_nlu_concepts_attributes][][present]',
          :boolean, :optional, 'Set true if a part of present condition'
    param :form, 'assessment_formula[assessment_formula_nlu_concepts_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
    param :form, 'assessment_formula[assessment_formula_asst_intents_attributes][][id]',
          :integer, :optional, 'id'
    param :form, 'assessment_formula[assessment_formula_asst_intents_attributes]
          [][asst_intent_id]', :integer, :optional, 'asst_intent_id'
    param :form, 'assessment_formula[assessment_formula_asst_intents_attributes]
          [][present]', :boolean, :optional,
          'Set true if a part of present condition'
    param :form, 'assessment_formula[assessment_formula_asst_intents_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
    param :form, 'assessment_formula[assessment_formula_asst_entity_values_attributes]
          [][id]', :integer, :optional, 'id'
    param :form, 'assessment_formula[assessment_formula_asst_entity_values_attributes]
          [][asst_entity_value_id]', :integer, :optional, 'asst_entity_value_id'
    param :form, 'assessment_formula[assessment_formula_asst_entity_values_attributes]
          [][present]', :boolean, :optional,
          'Set true if a part of present condition'
    param :form, 'assessment_formula[assessment_formula_asst_entity_values_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
    param :form, 'assessment_formula[assessment_formula_emotions_attributes][][id]',
          :integer, :optional, 'id'
    param :form, 'assessment_formula[assessment_formula_emotions_attributes][][emotion]',
          :integer, :optional, 'emotion'
    param :form, 'assessment_formula[assessment_formula_emotions_attributes][][comparator]',
          :string, :optional, 'comparator - lt, gt, range'
    param :form, 'assessment_formula[assessment_formula_emotions_attributes][][range_value]',
          :integer, :optional, 'range_value'
    param :form, 'assessment_formula[assessment_formula_emotions_attributes][][score]',
          :integer, :optional, 'score'
    param :form, 'assessment_formula[assessment_formula_emotions_attributes][][present]',
          :boolean, :optional, 'Set true if a part of present condition'
    param :form, 'assessment_formula[assessment_formula_emotions_attributes][][_destroy]',
          :boolean, :optional, 'Set true to destroy'
    param :form, 'assessment_formula[assessment_formula_sentiments_attributes][][id]',
          :integer, :optional, 'id'
    param :form, 'assessment_formula[assessment_formula_sentiments_attributes][][sentiment]',
          :integer, :optional, 'sentiment'
    param :form, 'assessment_formula[assessment_formula_sentiments_attributes]
          [][comparator]', :string, :optional, 'comparator - lt, gt, range'
    param :form, 'assessment_formula[assessment_formula_sentiments_attributes][][range_value]',
          :integer, :optional, 'range_value'
    param :form, 'assessment_formula[assessment_formula_sentiments_attributes][][score]',
          :integer, :optional, 'score'
    param :form, 'assessment_formula[assessment_formula_sentiments_attributes][][present]',
          :boolean, :optional, 'Set true if a part of present condition'
    param :form, 'assessment_formula[assessment_formula_sentiments_attributes][][_destroy]',
          :boolean, :optional, 'Set true to destroy'
  end

  swagger_api :update do
    summary 'Updates a response formula'
    notes 'Should be used to update a response formula'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'ID'
    param :form, 'assessment_formula[present_cond_keyword_min]', :integer,
          :optional, "Present condition's keyword min"
    param :form, 'assessment_formula[absent_cond_keyword_min]', :integer,
          :optional, "Absent condition's keyword min"
    param :form, 'assessment_formula[sentiment_enabled]', :boolean,
          :optional, 'sentiment enabled?'
    param :form, 'assessment_formula[emotion_enabled]', :boolean,
          :optional, 'emotion enabled?'
    param :form, 'assessment_formula[assessment_formula_nlu_entities_attributes][][id]',
          :integer, :optional, 'id'
    param :form, 'assessment_formula[assessment_formula_nlu_entities_attributes]
          [][nlu_entity_id]', :integer, :optional, 'nlu_entity_id'
    param :form, 'assessment_formula[assessment_formula_nlu_entities_attributes]
          [][present]',  :boolean, :optional,
          'Set true if a part of present condition'
    param :form, 'assessment_formula[assessment_formula_nlu_entities_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
    param :form, 'assessment_formula[assessment_formula_nlu_keywords_attributes][][id]',
          :integer, :optional, 'id'
    param :form, 'assessment_formula[assessment_formula_nlu_keywords_attributes]
          [][nlu_keyword_id]', :integer, :optional, 'nlu_keyword_id'
    param :form, 'assessment_formula[assessment_formula_nlu_keywords_attributes]
          [][present]', :boolean, :optional,
          'Set true if a part of present condition'
    param :form, 'assessment_formula[assessment_formula_nlu_keywords_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
    param :form, 'assessment_formula[assessment_formula_nlu_concepts_attributes]
          [][id]', :integer, :optional, 'id'
    param :form, 'assessment_formula[assessment_formula_nlu_concepts_attributes]
          [][nlu_concept_id]', :integer, :optional, 'nlu_concept_id'
    param :form, 'assessment_formula[assessment_formula_nlu_concepts_attributes]
          [][present]', :boolean, :optional,
          'Set true if a part of present condition'
    param :form, 'assessment_formula[assessment_formula_nlu_concepts_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
    param :form, 'assessment_formula[assessment_formula_asst_intents_attributes]
          [][id]', :integer, :optional, 'id'
    param :form, 'assessment_formula[assessment_formula_asst_intents_attributes]
          [][asst_intent_id]', :integer, :optional, 'asst_intent_id'
    param :form, 'assessment_formula[assessment_formula_asst_intents_attributes]
          [][present]', :boolean, :optional,
          'Set true if a part of present condition'
    param :form, 'assessment_formula[assessment_formula_asst_intents_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
    param :form, 'assessment_formula[assessment_formula_asst_entity_values_attributes]
          [][id]', :integer, :optional, 'id'
    param :form, 'assessment_formula[assessment_formula_asst_entity_values_attributes]
          [][asst_entity_value_id]', :integer, :optional, 'asst_entity_value_id'
    param :form, 'assessment_formula[assessment_formula_asst_entity_values_attributes]
          [][present]', :boolean, :optional,
          'Set true if a part of present condition'
    param :form, 'assessment_formula[assessment_formula_asst_entity_values_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
    param :form, 'assessment_formula[assessment_formula_emotions_attributes][][id]',
          :integer, :optional, 'id'
    param :form, 'assessment_formula[assessment_formula_emotions_attributes]
          [][emotion]', :integer, :optional, 'emotion'
    param :form, 'assessment_formula[assessment_formula_emotions_attributes]
          [][comparator]', :string, :optional, 'comparator - lt, gt, range'
    param :form, 'assessment_formula[assessment_formula_emotions_attributes][][range_value]',
          :integer, :optional, 'range_value'
    param :form, 'assessment_formula[assessment_formula_emotions_attributes]
          [][score]', :integer, :optional, 'score'
    param :form, 'assessment_formula[assessment_formula_emotions_attributes]
          [][present]', :boolean, :optional,
          'Set true if a part of present condition'
    param :form, 'assessment_formula[assessment_formula_emotions_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
    param :form, 'assessment_formula[assessment_formula_sentiments_attributes]
          [][id]', :integer, :optional, 'id'
    param :form, 'assessment_formula[assessment_formula_sentiments_attributes]
          [][sentiment]', :integer, :optional, 'sentiment'
    param :form, 'assessment_formula[assessment_formula_sentiments_attributes]
           [][comparator]', :string, :optional, 'comparator - lt, gt, range'
    param :form, 'assessment_formula[assessment_formula_sentiments_attributes][][range_value]',
           :integer, :optional, 'range_value'
    param :form, 'assessment_formula[assessment_formula_sentiments_attributes]
          [][score]', :integer, :optional, 'score'
    param :form, 'assessment_formula[assessment_formula_sentiments_attributes]
          [][present]', :boolean, :optional,
          'Set true if a part of present condition'
    param :form, 'assessment_formula[assessment_formula_sentiments_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  def set_email_assessment_item
    @email_assessment_item = EmailAssessmentItem.find(params[:email_assessment_item_id])
  end

  def set_assessment_formula
    @assessment_formula = AssessmentFormula.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def assessment_formula_params
    params.require(:assessment_formula).permit(
      :present_cond_keyword_min, :absent_cond_keyword_min,
      :sentiment_enabled, :emotion_enabled,
      assessment_formula_nlu_entities_attributes:
        %i[id nlu_entity_id present_cond _destroy],
      assessment_formula_nlu_keywords_attributes:
        %i[id nlu_keyword_id present_cond _destroy],
      assessment_formula_nlu_concepts_attributes:
        %i[id nlu_concept_id present_cond _destroy],
      assessment_formula_asst_intents_attributes:
        %i[id asst_intent_id present_cond _destroy],
      assessment_formula_asst_entity_values_attributes:
        %i[id asst_entity_value_id present_cond _destroy],
      assessment_formula_emotions_attributes:
        %i[id emotion comparator score range_value present_cond _destroy],
      assessment_formula_sentiments_attributes:
        %i[id sentiment comparator score range_value present_cond _destroy]
    )
  end

  def serializer
    AssessmentFormulaSerializer
  end
end
