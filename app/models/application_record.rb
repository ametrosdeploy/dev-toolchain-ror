# frozen_string_literal: true

# Common code for model goes here
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
