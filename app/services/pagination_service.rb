class PaginationService
  DEFAULT_PAGE = 1
  DEFAULT_PER_PAGE = 10

  def initialize(collection, page, per_page)
    @collection = collection
    @page       = page
    @per_page   = per_page
  end

  def execute
    @collection.page(@page).per(@per_page)
  end

  def paginate_array
    return nil if @collection.nil?
    Kaminari.paginate_array(@collection).page(@page).per(@per_page)
  end
end
