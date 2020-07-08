# frozen_string_literal: true

# This handle email Response formula related APIs ...
class Api::Admin::V1::ResponseFormulasController < Api::Admin::V1::BaseController
  before_action :set_email_response, only: :create
  before_action :set_response_formula, only: :update
  # POST /email_responses

  def create
    @response_formula = @email_response.response_formulas
                                       .new(response_formula_params)
    if @response_formula.save
      render json: serialize_rec(@response_formula), status: :created
    else
      render json: @response_formula.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /email_responses/1
  def update
    if @response_formula.update(response_formula_params)
      render json: serialize_rec(@response_formula)
    else
      render json: @response_formula.errors, status: :unprocessable_entity
    end
  end

  swagger_controller :response_formulas, 'Response Formulas'
  swagger_api :create do
    summary 'Creates a response formula'
    notes 'Should be used to create a response formula'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'email_response_id', :integer, :required, 'email_response_id'
    param :form, 'response_formula[present_cond_keyword_min]', :integer,
          :optional, "Present condition's keyword min"
    param :form, 'response_formula[absent_cond_keyword_min]', :integer,
          :optional, "Absent condition's keyword min"
    param :form, 'response_formula[formula_nlu_entities_attributes][][id]',
          :integer, :optional, 'id'
    param :form, 'response_formula[formula_nlu_entities_attributes]
          [][nlu_entity_id]', :integer, :optional, 'nlu_entity_id'
    param :form, 'response_formula[formula_nlu_entities_attributes]
          [][present]', :boolean, :optional,
          'Set true if a part of present condition'
    param :form, 'response_formula[formula_nlu_entities_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
    param :form, 'response_formula[formula_nlu_keywords_attributes][][id]',
          :integer, :optional, 'id'
    param :form, 'response_formula[formula_nlu_keywords_attributes]
          [][nlu_keyword_id]', :integer, :optional, 'nlu_keyword_id'
    param :form, 'response_formula[formula_nlu_keywords_attributes][][present]',
          :boolean, :optional, 'Set true if a part of present condition'
    param :form, 'response_formula[formula_nlu_keywords_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
    param :form, 'response_formula[formula_nlu_concepts_attributes][][id]',
          :integer, :optional, 'id'
    param :form, 'response_formula[formula_nlu_concepts_attributes]
          [][nlu_concept_id]', :integer, :optional, 'nlu_concept_id'
    param :form, 'response_formula[formula_nlu_concepts_attributes][][present]',
          :boolean, :optional, 'Set true if a part of present condition'
    param :form, 'response_formula[formula_nlu_concepts_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
    param :form, 'response_formula[formula_asst_intents_attributes][][id]',
          :integer, :optional, 'id'
    param :form, 'response_formula[formula_asst_intents_attributes]
          [][asst_intent_id]', :integer, :optional, 'asst_intent_id'
    param :form, 'response_formula[formula_asst_intents_attributes]
          [][present]', :boolean, :optional,
          'Set true if a part of present condition'
    param :form, 'response_formula[formula_asst_intents_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
    param :form, 'response_formula[formula_asst_entity_values_attributes]
          [][id]', :integer, :optional, 'id'
    param :form, 'response_formula[formula_asst_entity_values_attributes]
          [][asst_entity_value_id]', :integer, :optional, 'asst_entity_value_id'
    param :form, 'response_formula[formula_asst_entity_values_attributes]
          [][present]', :boolean, :optional,
          'Set true if a part of present condition'
    param :form, 'response_formula[formula_asst_entity_values_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
    param :form, 'response_formula[formula_emotions_attributes][][id]',
          :integer, :optional, 'id'
    param :form, 'response_formula[formula_emotions_attributes][][emotion]',
          :integer, :optional, 'emotion'
    param :form, 'response_formula[formula_emotions_attributes][][comparator]',
          :integer, :optional, 'comparator'
    param :form, 'response_formula[formula_emotions_attributes][][score]',
          :integer, :optional, 'score'
    param :form, 'response_formula[formula_emotions_attributes][][present]',
          :boolean, :optional, 'Set true if a part of present condition'
    param :form, 'response_formula[formula_emotions_attributes][][_destroy]',
          :boolean, :optional, 'Set true to destroy'
    param :form, 'response_formula[formula_sentiments_attributes][][id]',
          :integer, :optional, 'id'
    param :form, 'response_formula[formula_sentiments_attributes][][sentiment]',
          :integer, :optional, 'sentiment'
    param :form, 'response_formula[formula_sentiments_attributes]
          [][comparator]', :integer, :optional, 'comparator'
    param :form, 'response_formula[formula_sentiments_attributes][][score]',
          :integer, :optional, 'score'
    param :form, 'response_formula[formula_sentiments_attributes][][present]',
          :boolean, :optional, 'Set true if a part of present condition'
    param :form, 'response_formula[formula_sentiments_attributes][][_destroy]',
          :boolean, :optional, 'Set true to destroy'
  end

  swagger_api :update do
    summary 'Updates a response formula'
    notes 'Should be used to update a response formula'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'ID'
    param :form, 'response_formula[present_cond_keyword_min]', :integer,
          :optional, "Present condition's keyword min"
    param :form, 'response_formula[absent_cond_keyword_min]', :integer,
          :optional, "Absent condition's keyword min"
    param :form, 'response_formula[formula_nlu_entities_attributes][][id]',
          :integer, :optional, 'id'
    param :form, 'response_formula[formula_nlu_entities_attributes]
          [][nlu_entity_id]', :integer, :optional, 'nlu_entity_id'
    param :form, 'response_formula[formula_nlu_entities_attributes]
          [][present]',  :boolean, :optional,
          'Set true if a part of present condition'
    param :form, 'response_formula[formula_nlu_entities_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
    param :form, 'response_formula[formula_nlu_keywords_attributes][][id]',
          :integer, :optional, 'id'
    param :form, 'response_formula[formula_nlu_keywords_attributes]
          [][nlu_keyword_id]', :integer, :optional, 'nlu_keyword_id'
    param :form, 'response_formula[formula_nlu_keywords_attributes]
          [][present]', :boolean, :optional,
          'Set true if a part of present condition'
    param :form, 'response_formula[formula_nlu_keywords_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
    param :form, 'response_formula[formula_nlu_concepts_attributes]
          [][id]', :integer, :optional, 'id'
    param :form, 'response_formula[formula_nlu_concepts_attributes]
          [][nlu_concept_id]', :integer, :optional, 'nlu_concept_id'
    param :form, 'response_formula[formula_nlu_concepts_attributes]
          [][present]', :boolean, :optional,
          'Set true if a part of present condition'
    param :form, 'response_formula[formula_nlu_concepts_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
    param :form, 'response_formula[formula_asst_intents_attributes]
          [][id]', :integer, :optional, 'id'
    param :form, 'response_formula[formula_asst_intents_attributes]
          [][asst_intent_id]', :integer, :optional, 'asst_intent_id'
    param :form, 'response_formula[formula_asst_intents_attributes]
          [][present]', :boolean, :optional,
          'Set true if a part of present condition'
    param :form, 'response_formula[formula_asst_intents_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
    param :form, 'response_formula[formula_asst_entity_values_attributes]
          [][id]', :integer, :optional, 'id'
    param :form, 'response_formula[formula_asst_entity_values_attributes]
          [][asst_entity_value_id]', :integer, :optional, 'asst_entity_value_id'
    param :form, 'response_formula[formula_asst_entity_values_attributes]
          [][present]', :boolean, :optional,
          'Set true if a part of present condition'
    param :form, 'response_formula[formula_asst_entity_values_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
    param :form, 'response_formula[formula_emotions_attributes][][id]',
          :integer, :optional, 'id'
    param :form, 'response_formula[formula_emotions_attributes]
          [][emotion]', :integer, :optional, 'emotion'
    param :form, 'response_formula[formula_emotions_attributes]
          [][comparator]', :integer, :optional, 'comparator'
    param :form, 'response_formula[formula_emotions_attributes]
          [][score]', :integer, :optional, 'score'
    param :form, 'response_formula[formula_emotions_attributes]
          [][present]', :boolean, :optional,
          'Set true if a part of present condition'
    param :form, 'response_formula[formula_emotions_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
    param :form, 'response_formula[formula_sentiments_attributes]
          [][id]', :integer, :optional, 'id'
    param :form, 'response_formula[formula_sentiments_attributes]
          [][sentiment]', :integer, :optional, 'sentiment'
    param :form, 'response_formula[formula_sentiments_attributes]
           [][comparator]', :integer, :optional, 'comparator'
    param :form, 'response_formula[formula_sentiments_attributes]
          [][score]', :integer, :optional, 'score'
    param :form, 'response_formula[formula_sentiments_attributes]
          [][present]', :boolean, :optional,
          'Set true if a part of present condition'
    param :form, 'response_formula[formula_sentiments_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
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
<<<<<<< HEAD
      :present_cond_keyword_min, :absent_cond_keyword_min,
      formula_nlu_entities_attributes:
        %i[id nlu_entity_id present_cond _destroy],
      formula_nlu_keywords_attributes:
        %i[id nlu_keyword_id present_cond _destroy],
      formula_nlu_concepts_attributes:
        %i[id nlu_concept_id present_cond _destroy],
      formula_asst_intents_attributes:
        %i[id asst_intent_id present_cond _destroy],
      formula_asst_entity_values_attributes:
        %i[id asst_entity_value_id present_cond _destroy],
      formula_emotions_attributes:
        %i[id emotion comparator score present_cond _destroy],
      formula_sentiments_attributes:
        %i[id sentiment comparator score present_cond _destroy]
=======
      :present_cond_keyword_min, :absent_cond_keyword_min
>>>>>>> response formula changes
    )
  end

  def serializer
    ResponseFormulaSerializer
  end
end
