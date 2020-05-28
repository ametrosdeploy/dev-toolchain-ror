# frozen_string_literal: true

# == Schema Information
#
# Table name: global_videos
#
#  id                   :bigint           not null, primary key
#  title                :string           not null
#  description          :text
#  wistia_code          :string
#  duration             :integer
#  video_type           :integer
#  private              :boolean          default(FALSE)
#  transcript           :text
#  customer_id          :bigint
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  cached_tag_list      :string
#  wistia_thumbnail_url :string
#  file_name            :string
#
require 'rails_helper'

RSpec.describe GlobalVideo, type: :model do
end
