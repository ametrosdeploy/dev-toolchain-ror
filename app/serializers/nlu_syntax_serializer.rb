# frozen_string_literal: true

# == Schema Information
#
# Table name: nlu_syntaxes
#
#  id                 :bigint           not null, primary key
#  learning_object_id :bigint           not null
#  token              :string
#  part_of_speech     :string
#  lemma              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class NluSyntaxSerializer
  include FastJsonapi::ObjectSerializer
  attributes :token, :part_of_speech, :lemma
end
