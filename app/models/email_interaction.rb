# == Schema Information
#
# Table name: email_interactions
#
#  id            :bigint           not null, primary key
#  card_order    :integer
#  next_chain_id :bigint
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class EmailInteraction < ApplicationRecord
    has_one :learning_object, as: objectable
    has_one :learning_module, through: :learning_objects

    validates :name, :card_order, presence: true
    validates :card_order, numericality: { only_integer: true }
end
