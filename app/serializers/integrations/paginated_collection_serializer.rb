module Integrations
	class PaginatedCollectionSerializer < IntegrationSerializer
		SOURCE_CLASS = Struct.new(:name).new('collection')

		def initialize(paginated_collection, child_serializer, expand = [])
			super(collection, expand)
			@paginated_collection = paginated_collection
			@collection = paginated_collection.collection
			@child_serializer = child_serializer
		end

		attr_reader :paginated_collection, :collection, :child_serializer

		def attributes_hash
			{
				data: collection.map { |record| child_serializer.serialize(record, expansions) }
			}
		end

		def default_attributes
			{
				object: 'collection',
				page: paginated_collection.page.to_i,
				page_size: paginated_collection.page_size.to_i,
				total_pages: paginated_collection.total_pages_count,
				total_items: paginated_collection.total_items_count
			}
		end
	end
end