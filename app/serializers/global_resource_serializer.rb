# frozen_string_literal: true

# == Schema Information
#
# Table name: global_resources
#
#  id              :bigint           not null, primary key
#  title           :string
#  description     :text
#  resource_type   :integer
#  customer_id     :bigint
#  private         :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  cached_tag_list :string
#  is_pdf          :boolean          default(FALSE)
#
class GlobalResourceSerializer
  include FastJsonapi::ObjectSerializer
  include DateHelper
  attributes :title, :description, :resource_type, :private

  attribute :resource_url, &:attachement_variations

  attribute :created_on do |global_resource|
    format_to_ymd(global_resource.created_at)
  end

  attribute :customer do |global_resource|
    CustomerSerializer.new(global_resource.customer).as_json['data']
  end

  attribute :resource_size do |global_resource|
    global_resource.attachment_attachment.blob.byte_size
  end

  attribute :file_name do |global_resource|
    global_resource.attachment_attachment.blob.filename
  end

  attribute :tag_list, &:cached_tag_list
end
