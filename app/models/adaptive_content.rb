# frozen_string_literal: true

# == Schema Information
#
# Table name: adaptive_contents
#
#  id               :bigint           not null, primary key
#  title            :string
#  description      :text
#  adaptable_type   :string           not null
#  adaptable_id     :bigint           not null
#  contentable_type :string           not null
#  contentable_id   :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class AdaptiveContent < ApplicationRecord
  # Associations ...
  belongs_to :adaptable, polymorphic: true
  belongs_to :contentable, polymorphic: true

  # Need different serializer names for different contents
  def serializer_name
    "#{contentable_type}Serializer".constantize
  end
end
