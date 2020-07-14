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
#  content_type    :integer
#  is_pdf          :boolean          default(FALSE)
#
require 'rails_helper'

RSpec.describe GlobalResource, type: :model do
end
