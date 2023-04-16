module Pageable
  def pagination_data(klass)
    @pagination_data ||= ::Api::PaginationData.new(**pagination_data_params(klass))
  end

  def pagination_data_params(klass)
    {
      sort_by: params[:sort_by],
      sort_direction: params[:sort_direction],
      sort_klass: klass,
      page: params[:page],
      page_size: params[:page_size]
    }
  end
end