# frozen_string_literal: true

module Listing
  # Needed to filter Global Resources
  class GlobalResources < Listing::Base
    def initialize(args)
      super
    end

    def data
      @global_res = @global_res.where(resource_type: params[:resource_type])
      @global_res = @global_res.paginate(page: params[:page],
                                         per_page: GlobalResource::PER_PAGE)
      @global_res = @global_res.order("#{sort_column} #{sort_order}")
      serialize_rec(@global_res).merge!(paginate_hsh(@global_res))
    end

    def base_record
      @global_res = GlobalResource.joins(:attachment_blob)
                                  .includes(:customer,
                                            attachment_attachment: :blob)
      return unless params[:search].present?

      @global_res = @global_res.search(params[:search])
    end

    def serializer
      GlobalResourceSerializer
    end

    def sort_array
      %i[active_storage_blobs.filename created_at
         active_storage_blobs.byte_size]
    end

    # This method is needed as we do not need sorting in case of image
    def paginate_hsh(records)
      if params[:resource_type] == 'image'
        custom_paginate_without_sort_hsh(records, GlobalResource.with_image)
      else
        custom_paginate_hsh(records, GlobalResource.with_document)
      end
    end

    # Generates a hash of pagination & sort data needed for pagination
    def custom_paginate_hsh(data, class_name_with_scope)
      {
        filtered_count: data.total_entries,
        total_count: class_name_with_scope.count,
        total_pages: data.total_pages,
        limit_per_page: GlobalResource::PER_PAGE,
        current_page: params[:page].presence || 1,
        sort_column: sort_column,
        sort_order: sort_order
      }
    end

    # Generates a hash of pagination data needed for pagination
    def custom_paginate_without_sort_hsh(data, class_name_with_scope)
      {
        filtered_count: data.total_entries,
        total_count: class_name_with_scope.count,
        total_pages: data.total_pages,
        limit_per_page: GlobalResource::PER_PAGE,
        current_page: params[:page].presence || 1
      }
    end
  end
end
