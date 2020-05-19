# frozen_string_literal: true

class LearnModSerializer
  include FastJsonapi::ObjectSerializer
  include DateHelper
  attributes :name, :time_to_complete, :abstract, :world_id, :unique_code,
             :learning_objects_count, :description, :lead_designer_id,
             :sme_id, :notes, :learning_objectives

  attribute :created_on do |learn_mod|
    format_to_ymd(learn_mod.created_at)
  end

  attribute :world_name do |learn_mod|
    learn_mod.world.name
  end

  attribute :lead_designer do |learn_mod|
    UserSerializer.new(learn_mod.lead_designer).as_json['data']
  end

  attribute :sme do |learn_mod|
    UserSerializer.new(learn_mod.sme).as_json['data']
  end

  attribute :intro_video do |learn_mod|
    GlobalVideoSerializer.new(learn_mod.intro_video).as_json['data']
  end

  attribute :intro_documents do |learn_mod|
    GlobalResourceSerializer.new(learn_mod.global_resources).as_json['data']
  end

  attribute :skills do |learn_mod|
    GlobalSkillSerializer.new(learn_mod.global_skills).as_json['data']
  end

  attribute :learner_organization do |learn_mod|
    LearnModOrganizationSerializer.new(learn_mod.learn_mod_organizations)
                                  .as_json['data']
  end
end
