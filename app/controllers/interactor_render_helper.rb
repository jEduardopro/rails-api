module InteractorRenderHelper
	def render_interactor_with_serializer(interactor:, params:, serializer:, expand: [])
		unless valid_expansion?(expand)
			return render_error(Application::BadRequest.new('Expand must be an array of strings'))
		end

		interactor = interactor.call(**params.merge(expand:))

		return render_error(interactor.error) if interactor.failure?

		serialized_data = serialize_interactor(interactor, serializer, expand)
		render_success(serialized_data, :ok)
	end

	def serialize_interactor(interactor, serializer, expand)
		return serializer.serialize(interactor.result, expand) unless interactor.respond_to?(:pagination_data)

		paginated_collection_serializer.serialize(interactor.paginated_collection, serializer, expand)
	end

	def paginated_collection_serializer
		Integrations::PaginatedCollectionSerializer
	end

	def render_error(error)
		render json: { error: }, status: error.status
	end

	def render_success(result, status)
		render json: result, status:
	end

	def valid_expansion?(expand)
		return true unless expand

		expand.is_a?(Array) && expand.all? { |a| a.is_a?(String) }
	end
end

