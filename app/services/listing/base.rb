# frozen_string_literal: true

module Listing
  # common code for searching & sorting
  class Base
    # ComponentMissing = Class.new(StandardError)
    include PaginateHsh
    attr_reader :params

    def initialize(args)
      @params = args[:params]
      base_record
    end

    # Set default sort Column
    def sort_column
      srt_column = params[:sort_column]
      valid_srt && srt_column.split(',').join(" #{sort_order}, ") || default_col
    end

    # Validate sort key & set default sort type
    def sort_order
      sort_type = params[:sort_order].presence
      sort_type && %w[asc desc].include?(sort_type) && sort_type || 'desc'
    end

    # Verify available sort options
    def valid_srt
      params[:sort_column].present? && sort_array.include?(params[:sort_column])
    end

    def serialize_rec(data)
      serializer.new(data).serializable_hash
    end
  end
end
