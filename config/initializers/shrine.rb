# frozen_string_literal: true

require 'shrine'
require 'shrine/storage/s3'
require 'shrine/storage/memory'
require 'shrine/storage/file_system'

def build_store(name, setting)
  if Rails.env.test?
    Shrine::Storage::Memory.new
  elsif Rails.env.development?
    # Shrine::Storage::FileSystem.new('storage', prefix: name.to_s)
    Shrine::Storage::FileSystem.new('public', prefix: name.to_s)
  else
    Shrine::Storage::S3.new(
      bucket: setting[:bucket_name],
      region: setting[:region],
      prefix: setting[:file_prefix]
    )
  end
end

def build_cache_store
  if Rails.env.test?
    Shrine::Storage::Memory.new
  else
    Shrine::Storage::FileSystem.new('tmp', prefix: 'storage')
  end
end

Shrine.storages =
  Settings.shrine.to_h.map.to_h do |name, setting|
    [name, build_store(name, setting)]
  end.merge(cache: build_cache_store)

Shrine.plugin :activerecord
Shrine.plugin :determine_mime_type, analyzer_options: { filename_fallback: true }
Shrine.plugin :derivatives, create_on_promote: true
Shrine.plugin :validation
Shrine.plugin :validation_helpers
Shrine.plugin :remove_invalid
Shrine.plugin :presign_endpoint
Shrine.plugin :refresh_metadata
Shrine.plugin :backgrounding
Shrine.plugin :tempfile
Shrine.plugin :pretty_location