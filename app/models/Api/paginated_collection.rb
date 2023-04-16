module Api
  class PaginatedCollection
    def initialize(collection:, page:, page_size:, total_items:)
      @collection = collection
      @page = page
      @page_size = page_size
      @total_items = total_items
    end

    attr_reader :collection, :page, :page_size

    def total_items_count
      return collection.total_count if collection.respond_to?(:total_count) && total_items.nil?

      total_items.to_i
    end

    def total_pages_count
      return collection.total_pages if collection.respond_to?(:total_pages)

      (total_items_count.to_f / page_size).ceil
    rescue Kaminari::ZeroPerPageOperation, FloatDomainError
      0
    end

    private

    attr_reader :total_items
  end
end