class PagesController < AuthenticatedController

	def index
		pages = Page.all

		render json: {pages: pages}, status: :ok
	end
	
end