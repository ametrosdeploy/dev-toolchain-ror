# frozen_string_literal: true

# == Schema Information
#
# Table name: email_learn_objs
#
#  id                    :bigint           not null, primary key
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  title                 :string
#  to_character_ids      :integer          default([]), is an Array
#  cc_character_ids      :integer          default([]), is an Array
#  email_body            :text
#  iteration_enabled     :boolean          default(FALSE)
#  iteration_level       :integer
#  iteration_explanation :text
#  chained_to            :integer
#
module Learner
  class EmailLearnObjSerializer
    include FastJsonapi::ObjectSerializer
    attributes :title, :to_character_ids, :cc_character_ids, :email_body,
               :iteration_enabled, :iteration_level, :iteration_explanation,
               :chained_to

    attribute :to_characters do |email_learn_obj|
      WorldOrgCharacterTrimmedSerializer.new(email_learn_obj.to_characters)
                                        .as_json['data']
    end

    attribute :cc_characters do |email_learn_obj|
      WorldOrgCharacterTrimmedSerializer.new(email_learn_obj.cc_characters)
                                        .as_json['data']
    end

    attribute :interstitial_contents do |email_learn_obj|
      InterstitialContentSerializer.new(email_learn_obj.interstitial_contents)
                                        .as_json['data']
    end
  end
end
