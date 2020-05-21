# frozen_string_literal: true

# == Schema Information
#
# Table name: video_learn_objs
#
#  id              :bigint           not null, primary key
#  global_video_id :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  title           :string
#  description     :text
#
class VideoLearnObj < ApplicationRecord
  belongs_to :global_video
  has_one :learning_object, as: :objectable
  has_one :learn_mod, through: :learning_objects
end
