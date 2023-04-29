# frozen_string_literal: true

module Integrations
	class UserSerializer < IntegrationSerializer
		SOURCE_CLASS = User

		private

		attr_reader :user

		delegate :cover_photo, to: :user

		def use_uuid?
			true
		end

		def additional_attributes
			hash = {}
			hash[:cover_photo] = cover_photo_data if cover_photo.present?
			hash
		end

		def excluded_attributes
			%i[password_digest password_salt cover_photo_data]
		end

		def cover_photo_data
			{
				small: cover_photo(:small).url,
				medium: cover_photo(:medium).url,
				large: cover_photo(:large).url
			}
		end
	end
end