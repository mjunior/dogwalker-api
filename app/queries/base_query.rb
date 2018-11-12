class BaseQuery
  def initialize params
    @page = params[:page] || 1
    @per_page = params[:per_page]
  end

  def paginate(scope, default_per_page = 10)
    collection = scope.page(@page).per((@per_page || default_per_page).to_i)
    current, total, per_page = collection.current_page, collection.total_pages, collection.limit_value
    return [{meta: {
      pagination: {
        current:  current,
        previous: (current > 1 ? (current - 1) : nil),
        next:     (current == total ? nil : (current + 1)),
        per_page: per_page,
        pages:    total,
        total:    collection.total_count
      }}
    },collection]
  end
end