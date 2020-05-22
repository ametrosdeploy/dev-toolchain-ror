# frozen_string_literal: true

# == Schema Information
#
# Table name: learn_mods
#
#  id                     :bigint           not null, primary key
#  name                   :string
#  time_to_complete       :integer
#  abstract               :text
#  world_id               :bigint           not null
#  intro_video_id         :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  unique_code            :integer          not null
#  learning_objects_count :integer          default(0)
#  description            :text
#  lead_designer_id       :integer
#  sme_id                 :integer
#  learning_objectives    :text
#  notes                  :text
#  cached_skill_list      :string
#  status                 :integer          default("drafted")
#
class LearnModSerializer
  include FastJsonapi::ObjectSerializer
  include DateHelper
  include ImageHelper
  attributes :name, :time_to_complete, :abstract, :world_id, :unique_code,
             :learning_objects_count, :description, :lead_designer_id,
             :sme_id, :notes, :learning_objectives, :status

  attribute :created_on do |learn_mod|
    format_to_ymd(learn_mod.created_at)
  end

  attribute :photo_url do |learn_mod|
    image_url(learn_mod.photo)
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
