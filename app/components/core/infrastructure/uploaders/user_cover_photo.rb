module Core
  module Infrastructure
    module Uploaders
      class UserCoverPhoto < Shrine
        plugin :store_dimensions, analyzer: :mini_magick, on_error: :ignore

        Attacher.derivatives do |original|
					# binding.pry
          magick = ImageProcessing::MiniMagick.source(original)
					
					# binding.pry
					
					
          {
            large: magick.resize_to_limit!(1000, nil),
            medium: magick.resize_to_limit!(500, nil),
            small: magick.resize_to_limit!(300, nil)
          }
        end

        Attacher.validate do
          validate_max_size 100.megabytes, message: 'is too large (max is 100 MB)'
          validate_mime_type_exclusion %w[text/html application/octet-stream]

          if data['metadata']['mime_type']&.start_with?('image/')
            validate_max_width 16_384
            validate_max_height 16_384
          end
        end
      end
    end
  end
end
