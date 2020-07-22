# frozen_string_literal: true

# == Schema Information
#
# Table name: nlu_semantic_roles
#
#  id                    :bigint           not null, primary key
#  learning_object_id    :bigint           not null
#  sentence              :text
#  subject               :string
#  action_verb_txt       :string
#  action_verb_tense     :string
#  action_txt            :string
#  action_txt_normalized :string
#  object                :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class NluSemanticRoleSerializer
  include FastJsonapi::ObjectSerializer
  attributes :sentence, :subject, :action_verb_txt,
             :action_verb_tense, :action_txt, :action_txt_normalized,
             :object
end
