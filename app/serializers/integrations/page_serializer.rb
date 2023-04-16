module Integrations
	class PageSerializer < IntegrationSerializer
		SOURCE_CLASS = Page

		attr_reader :page

		def use_uuid?
		  true
		end

		# def excluded_attributes
		# 	[]
		# end
	end
end