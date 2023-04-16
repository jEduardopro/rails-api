module V1
  module Integrations
    class PaginatedIndex
      include Interactor

      def call
        context.paginated_collection = paginated_collection
      end

      def valid?
        add_bad_request_error('Missing pagination data') unless pagination_data.present?
      end

      def index_query
        raise NotImplementedError
      end

      private

      delegate :pagination_data, to: :context
      delegate :page, :page_size, to: :pagination_data

      def paginated_collection
        Api::PaginatedCollection.new(
          collection:,
          page:,
          page_size:,
          total_items: collection.total_count
        )
      end

      def collection
        ordered_query.page(page).per(page_size)
      end

      def ordered_query
        index_query.order(pagination_data.order_clause)
      end
    end
  end
end