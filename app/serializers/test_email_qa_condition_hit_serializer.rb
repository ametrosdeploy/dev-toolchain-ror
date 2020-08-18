class TestEmailQaConditionHitSerializer
  include FastJsonapi::ObjectSerializer

  attribute :qa_formula_hits, if: proc { |record|
    record.qa_formula_hits.present?
  } do |record|
    formulas = QaFormula.where(id: record.qa_formula_hits)
    QaFormulaSerializer.new(formulas).as_json['data']                              
  end

  attribute :hit_due_to_blank_response, if: proc { |record|
    record.blank_response_hit.present?
  } do |record|
    record.blank_response_hit                             
  end


end
