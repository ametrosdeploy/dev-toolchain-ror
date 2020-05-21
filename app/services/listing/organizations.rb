# frozen_string_literal: true

module Listing
  # Needed to filter characters
  class Organizations < Listing::Base
    def initialize(args)
      super
    end

    def data
      @organizations = @organizations.order("#{sort_column} #{sort_order}")
      @organizations = @organizations.paginate(page: params[:page],
                                               per_page: Organization::PER_PAGE)
      serialize_rec(@organizations).merge!(
        pagination_hsh(@organizations, Organization)
      )
    end

    def base_record
      @organizations = Organization.joins(:industry).with_attached_photo
                                   .includes(organization_characters:
                                             [:world_role, character:
                                             [:photo_attachment]])
      return unless params[:search].present?

      @organizations = @organizations.search(params[:search])
    end

    def serializer
      OrganizationWithCharacterSerializer
    end

    def sort_array
      %i[organizations.name created_at industries.name characters_count]
    end

    def default_col
      'organizations.id'
    end
  end
end
