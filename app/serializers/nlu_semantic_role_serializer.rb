# frozen_string_literal: true

class NluSemanticRoleSerializer
  include FastJsonapi::ObjectSerializer
  attributes :sentence, :subject, :action_verb_txt,
             :action_verb_tense, :action_txt, :action_txt_normalized,
             :object
end
