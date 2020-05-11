# == Schema Information
#
# Table name: dialogic_interactions
#
#  id         :bigint           not null, primary key
#  name       :string
#  card_order :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class DialogicInteraction < ApplicationRecord
    has_one :learning_object, as: objectable
    has_one :learning_module, through: :learning_objects

    validates :name, :card_order, presence: true
    validates :card_order, numericality: { only_integer: true }
end
