# == Schema Information
#
# Table name: test_email_qa_condition_hits
#
#  id                      :bigint           not null, primary key
#  test_email_iteration_id :bigint           not null
#  qa_condition_id         :bigint           not null
#  qa_formula_hits         :integer          default([]), is an Array
#  blank_response_hit      :boolean
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
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
