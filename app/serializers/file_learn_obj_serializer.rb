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
  include ImageHelper
  attributes :global_resource_id

  attribute :resource_url do |file_learn_obj|
    image_url(file_learn_obj.global_resource.attachment)
  end
end
