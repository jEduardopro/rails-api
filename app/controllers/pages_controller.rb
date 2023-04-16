class PagesController < AuthenticatedController
	include Pageable

	def index
		pages = Page.all

		render_interactor_with_serializer(
			interactor: V1::Pages::Index,
			params: { params: index_params, pagination_data: pagination_data(Page) },
			serializer: Integrations::PageSerializer
		)
	end

	def index_params
		params.permit(:template)
	end
end