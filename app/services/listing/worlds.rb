# frozen_string_literal: true

module Listing
  # Needed to filter characters
  class Worlds < Listing::Base
    def initialize(args)
      super
    end

    def data
      @worlds = @worlds.order("#{sort_column} #{sort_order}")
      @worlds = @worlds.paginate(page: params[:page], per_page: World::PER_PAGE)
      serialize_rec(@worlds).merge!(pagination_hsh(@worlds, World))
    end

    def base_record
      @worlds = World.includes(:customer, world_organizations:
        [:world_org_characters,
         organization: %i[photo_attachment industry],
         characters: [:photo_attachment]])
      @worlds = @worlds.search(params[:search]) if params[:search].present?
    end

    def serializer
      WorldSerializer
    end

    def sort_array
      %w[name created_at is_private learn_mods_count]
    end

    def default_col
      'id'
    end
  end
end
