class LearnModOrganizationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :learn_mod_id, :world_organization_id, :is_learner_organization

  attribute :organization_name do |learn_mod_organization|
    learn_mod_organization.world_organization.try(:organization).try(:name)
  end
end
