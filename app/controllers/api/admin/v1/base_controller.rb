class Api::Admin::V1::BaseController < Api::ApplicationController
  # Generates a hash of pagination & sort data needed for pagination
  def pagination_hsh(data, class_name)
    {
      filtered_count: data.total_entries,
      total_count: class_name.count,
      total_pages: data.total_pages,
      limit_per_page: class_name::PER_PAGE,
      current_page: params[:page].presence || 1,
      sort_column: sort_column,
      sort_order: sort_order
    }
  end

  # Generates a hash of pagination data needed for pagination
  def pagination_without_sort_hsh(data, class_name)
    {
      filtered_count: data.total_entries,
      total_count: class_name.count,
      total_pages: data.total_pages,
      limit_per_page: class_name::PER_PAGE,
      current_page: params[:page].presence || 1
    }
  end
end
