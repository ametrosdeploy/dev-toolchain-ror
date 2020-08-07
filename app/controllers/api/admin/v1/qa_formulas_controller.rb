# frozen_string_literal: true

class Api::Admin::V1::QaFormulasController < Api::Admin::V1::BaseController
  before_action :set_qa_condition, only: %i[index create]
  before_action :set_qa_formula, only: %i[show update destroy]

  # GET /qa_formulas
  def index
    @qa_formula = @qa_condition.qa_formulas
    render json: serialize_rec(@qa_formula)
  end

  # GET /qa_formulas/1
  def show
    render json: serialize_rec(@qa_formula)
  end

  # POST /qa_formulas
  def create
    @qa_formula = @qa_condition.qa_formulas.new(qa_formula_params)
    if @qa_formula.save
      render json: serialize_rec(@qa_formula), status: :created
    else
      render json: @qa_formula.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /qa_formulas/1
  def update
    if @qa_formula.update(qa_formula_params)
      render json: serialize_rec(@qa_formula)
    else
      render json: @qa_formula.errors, status: :unprocessable_entity
    end
  end

  # DELETE /qa_formulas/1
  def destroy
    @qa_formula.destroy
  end

  swagger_controller :qa_formulas, 'Qa Formulas'
  swagger_api :create do
    summary 'Creates a Qa Formula'
    notes 'Should be used to create a Qa Formula'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'qa_condition_id', :integer, :required, 'qa_condition_id'
    param :form, 'qa_formula[present_cond_keyword_min]', :integer,
          :optional, "Present condition's keyword min"
    param :form, 'qa_formula[absent_cond_keyword_min]', :integer,
          :optional, "Absent condition's keyword min"
    param :form, 'qa_formula[sentiment_enabled]', :boolean,
          :optional, 'sentiment enabled?'
    param :form, 'qa_formula[emotion_enabled]', :boolean,
          :optional, 'emotion enabled?'
    param :form, 'qa_formula[qa_formula_nlu_entities_attributes][][id]',
          :integer, :optional, 'id'
    param :form, 'qa_formula[qa_formula_nlu_entities_attributes]
          [][nlu_entity_id]', :integer, :optional, 'nlu_entity_id'
    param :form, 'qa_formula[qa_formula_nlu_entities_attributes]
          [][present]', :boolean, :optional,
          'Set true if a part of present condition'
    param :form, 'qa_formula[qa_formula_nlu_entities_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
    param :form, 'qa_formula[qa_formula_nlu_keywords_attributes][][id]',
          :integer, :optional, 'id'
    param :form, 'qa_formula[qa_formula_nlu_keywords_attributes]
          [][nlu_keyword_id]', :integer, :optional, 'nlu_keyword_id'
    param :form, 'qa_formula[qa_formula_nlu_keywords_attributes][][present]',
          :boolean, :optional, 'Set true if a part of present condition'
    param :form, 'qa_formula[qa_formula_nlu_keywords_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
    param :form, 'qa_formula[qa_formula_nlu_concepts_attributes][][id]',
          :integer, :optional, 'id'
    param :form, 'qa_formula[qa_formula_nlu_concepts_attributes]
          [][nlu_concept_id]', :integer, :optional, 'nlu_concept_id'
    param :form, 'qa_formula[qa_formula_nlu_concepts_attributes][][present]',
          :boolean, :optional, 'Set true if a part of present condition'
    param :form, 'qa_formula[qa_formula_nlu_concepts_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
    param :form, 'qa_formula[qa_formula_asst_intents_attributes][][id]',
          :integer, :optional, 'id'
    param :form, 'qa_formula[qa_formula_asst_intents_attributes]
          [][asst_intent_id]', :integer, :optional, 'asst_intent_id'
    param :form, 'qa_formula[qa_formula_asst_intents_attributes]
          [][present]', :boolean, :optional,
          'Set true if a part of present condition'
    param :form, 'qa_formula[qa_formula_asst_intents_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
    param :form, 'qa_formula[qa_formula_asst_entity_values_attributes]
          [][id]', :integer, :optional, 'id'
    param :form, 'qa_formula[qa_formula_asst_entity_values_attributes]
          [][asst_entity_value_id]', :integer, :optional, 'asst_entity_value_id'
    param :form, 'qa_formula[qa_formula_asst_entity_values_attributes]
          [][present]', :boolean, :optional,
          'Set true if a part of present condition'
    param :form, 'qa_formula[qa_formula_asst_entity_values_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
    param :form, 'qa_formula[qa_formula_emotions_attributes][][id]',
          :integer, :optional, 'id'
    param :form, 'qa_formula[qa_formula_emotions_attributes][][emotion]',
          :integer, :optional, 'emotion'
    param :form, 'qa_formula[qa_formula_emotions_attributes][][comparator]',
          :integer, :optional, 'comparator - lt, gt, range'
    param :form, 'qa_formula[qa_formula_emotions_attributes][][range_value]',
          :integer, :optional, 'range_value'
    param :form, 'qa_formula[qa_formula_emotions_attributes][][score]',
          :integer, :optional, 'score'
    param :form, 'qa_formula[qa_formula_emotions_attributes][][present]',
          :boolean, :optional, 'Set true if a part of present condition'
    param :form, 'qa_formula[qa_formula_emotions_attributes][][_destroy]',
          :boolean, :optional, 'Set true to destroy'
    param :form, 'qa_formula[qa_formula_sentiments_attributes][][id]',
          :integer, :optional, 'id'
    param :form, 'qa_formula[qa_formula_sentiments_attributes][][sentiment]',
          :integer, :optional, 'sentiment'
    param :form, 'qa_formula[qa_formula_sentiments_attributes]
          [][comparator]', :integer, :optional, 'comparator - lt, gt, range'
    param :form, 'qa_formula[formula_sentiments_attributes][][range_value]',
          :integer, :optional, 'range_value'
    param :form, 'qa_formula[qa_formula_sentiments_attributes][][score]',
          :integer, :optional, 'score'
    param :form, 'qa_formula[qa_formula_sentiments_attributes][][present]',
          :boolean, :optional, 'Set true if a part of present condition'
    param :form, 'qa_formula[qa_formula_sentiments_attributes][][_destroy]',
          :boolean, :optional, 'Set true to destroy'
  end

  swagger_api :update do
    summary 'Updates a Qa Formula'
    notes 'Should be used to update a Qa Formula'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'ID'
    param :form, 'qa_formula[present_cond_keyword_min]', :integer,
          :optional, "Present condition's keyword min"
    param :form, 'qa_formula[absent_cond_keyword_min]', :integer,
          :optional, "Absent condition's keyword min"
    param :form, 'qa_formula[sentiment_enabled]', :boolean,
          :optional, 'sentiment enabled?'
    param :form, 'qa_formula[emotion_enabled]', :boolean,
          :optional, 'emotion enabled?'
    param :form, 'qa_formula[qa_formula_nlu_entities_attributes][][id]',
          :integer, :optional, 'id'
    param :form, 'qa_formula[qa_formula_nlu_entities_attributes]
          [][nlu_entity_id]', :integer, :optional, 'nlu_entity_id'
    param :form, 'qa_formula[qa_formula_nlu_entities_attributes]
          [][present]',  :boolean, :optional,
          'Set true if a part of present condition'
    param :form, 'qa_formula[qa_formula_nlu_entities_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
    param :form, 'qa_formula[qa_formula_nlu_keywords_attributes][][id]',
          :integer, :optional, 'id'
    param :form, 'qa_formula[qa_formula_nlu_keywords_attributes]
          [][nlu_keyword_id]', :integer, :optional, 'nlu_keyword_id'
    param :form, 'qa_formula[qa_formula_nlu_keywords_attributes]
          [][present]', :boolean, :optional,
          'Set true if a part of present condition'
    param :form, 'qa_formula[qa_formula_nlu_keywords_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
    param :form, 'qa_formula[qa_formula_nlu_concepts_attributes]
          [][id]', :integer, :optional, 'id'
    param :form, 'qa_formula[qa_formula_nlu_concepts_attributes]
          [][nlu_concept_id]', :integer, :optional, 'nlu_concept_id'
    param :form, 'qa_formula[qa_formula_nlu_concepts_attributes]
          [][present]', :boolean, :optional,
          'Set true if a part of present condition'
    param :form, 'qa_formula[qa_formula_nlu_concepts_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
    param :form, 'qa_formula[qa_formula_asst_intents_attributes]
          [][id]', :integer, :optional, 'id'
    param :form, 'qa_formula[qa_formula_asst_intents_attributes]
          [][asst_intent_id]', :integer, :optional, 'asst_intent_id'
    param :form, 'qa_formula[qa_formula_asst_intents_attributes]
          [][present]', :boolean, :optional,
          'Set true if a part of present condition'
    param :form, 'qa_formula[qa_formula_asst_intents_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
    param :form, 'qa_formula[qa_formula_asst_entity_values_attributes]
          [][id]', :integer, :optional, 'id'
    param :form, 'qa_formula[qa_formula_asst_entity_values_attributes]
          [][asst_entity_value_id]', :integer, :optional, 'asst_entity_value_id'
    param :form, 'qa_formula[qa_formula_asst_entity_values_attributes]
          [][present]', :boolean, :optional,
          'Set true if a part of present condition'
    param :form, 'qa_formula[qa_formula_asst_entity_values_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
    param :form, 'qa_formula[qa_formula_emotions_attributes][][id]',
          :integer, :optional, 'id'
    param :form, 'qa_formula[qa_formula_emotions_attributes]
          [][emotion]', :integer, :optional, 'emotion'
    param :form, 'qa_formula[qa_formula_emotions_attributes][][comparator]',
          :integer, :optional, 'comparator - lt, gt, range'
    param :form, 'qa_formula[qa_formula_emotions_attributes][][range_value]',
          :integer, :optional, 'range_value'
    param :form, 'qa_formula[qa_formula_emotions_attributes]
          [][score]', :integer, :optional, 'score'
    param :form, 'qa_formula[qa_formula_emotions_attributes]
          [][present]', :boolean, :optional,
          'Set true if a part of present condition'
    param :form, 'qa_formula[qa_formula_emotions_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
    param :form, 'qa_formula[qa_formula_sentiments_attributes]
          [][id]', :integer, :optional, 'id'
    param :form, 'qa_formula[qa_formula_sentiments_attributes]
          [][sentiment]', :integer, :optional, 'sentiment'
    param :form, 'qa_formula[qa_formula_sentiments_attributes][][comparator]',
          :integer, :optional, 'comparator - lt, gt, range'
    param :form, 'qa_formula[formula_sentiments_attributes][][range_value]',
          :integer, :optional, 'range_value'
    param :form, 'qa_formula[qa_formula_sentiments_attributes]
          [][score]', :integer, :optional, 'score'
    param :form, 'qa_formula[qa_formula_sentiments_attributes]
          [][present]', :boolean, :optional,
          'Set true if a part of present condition'
    param :form, 'qa_formula[qa_formula_sentiments_attributes]
          [][_destroy]', :boolean, :optional, 'Set true to destroy'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_qa_condition
    @qa_condition = QaCondition.find(params[:qa_condition_id])
  end

  def set_qa_formula
    @qa_formula = QaFormula.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def qa_formula_params
    params.require(:qa_formula).permit(
      :present_cond_keyword_min, :absent_cond_keyword_min,
      :sentiment_enabled, :emotion_enabled,
      qa_formula_nlu_entities_attributes:
        %i[id nlu_entity_id present_cond _destroy],
      qa_formula_nlu_keywords_attributes:
        %i[id nlu_keyword_id present_cond _destroy],
      qa_formula_nlu_concepts_attributes:
        %i[id nlu_concept_id present_cond _destroy],
      qa_formula_asst_intents_attributes:
        %i[id asst_intent_id present_cond _destroy],
      qa_formula_asst_entity_values_attributes:
        %i[id asst_entity_value_id present_cond _destroy],
      qa_formula_emotions_attributes:
        %i[id emotion comparator range_value score present_cond _destroy],
      qa_formula_sentiments_attributes:
        %i[id sentiment comparator range_value score present_cond _destroy]
    )
  end

  def serializer
    QaFormulaSerializer
  end
end
