class World < ApplicationRecord

  belongs_to :customer 
  before_create :set_uniq_token

  private

  # set unique world code to the world
  def set_uniq_token
    self.world_code = (1..9).sort_by{rand}.join.to_i
    set_uniq_token if World.exists?(world_code: self.world_code)
  end
end
