# frozen_string_literal: true

module Listing
  # Needed to filter characters
  class Characters < Listing::Base
    def initialize(args)
      super
    end

    def data
      @characters = @characters.order("#{sort_column} #{sort_order}")
      @characters = @characters.paginate(page: params[:page],
                                         per_page: Character::PER_PAGE)
      serialize_rec(@characters).merge!(pagination_hsh(@characters, Character))
    end

    def base_record
      @characters = Character.all.with_attached_photo
                             .includes %i[organization_characters organizations]
      return unless params[:search].present?

      @characters = @characters.search(params[:search])
    end

    def serializer
      CharacterWithOrganizationSerializer
    end

    def sort_array
      %i[first_name,last_name created_at age gender organizations_count]
    end
  end
end
