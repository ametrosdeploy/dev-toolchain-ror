# frozen_string_literal: true

class NluSyntaxSerializer
  include FastJsonapi::ObjectSerializer
  attributes :token, :part_of_speech, :lemma
end
