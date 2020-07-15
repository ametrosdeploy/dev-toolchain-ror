# frozen_string_literal: true

# == Schema Information
#
# Table name: file_learn_objs
#
#  id                 :bigint           not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  global_resource_id :bigint           not null
#
class FileLearnObjSerializer
  include FastJsonapi::ObjectSerializer
  attributes :global_resource_id

  attribute :resource_url do |file_learn_obj|
    file_learn_obj.global_resource.attachement_variations
  end

  attribute :resource_size do |file_learn_obj|
    file_learn_obj.global_resource.attachment_attachment.blob.byte_size
  end

  attribute :resource_file_name do |file_learn_obj|
    file_learn_obj.global_resource.attachment_attachment.blob.filename
  end
end
