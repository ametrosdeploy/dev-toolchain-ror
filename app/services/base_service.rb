# frozen_string_literal: true

# Base service
class BaseService
  def initialize
    @errors = []
  end

  def valid?
    @errors.none?
  end

  def message
    @errors[0]
  end

  def full_messages
    @errors.join(', ')
  end

  def errors(msg)
    @errors << msg
  end
end
