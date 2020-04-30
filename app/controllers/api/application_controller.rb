# frozen_string_literal: true

class Api::ApplicationController < ActionController::API
  Swagger::Docs::Generator.set_real_methods

  def serialize_rec(data)
    serializer.new(data).serializable_hash
  end
end
