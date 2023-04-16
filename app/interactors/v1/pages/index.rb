module V1
	module Pages
		class Index < Integrations::PaginatedIndex

			def index_query
        Page.all
      end

      delegate :params, to: :context
		end
	end
end