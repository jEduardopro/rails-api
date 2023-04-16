module HasUuid
  extend ActiveSupport::Concern

  included do
    before_validation :generate_uuid, on: :create
  end

  private

  def generate_uuid
    self.uuid = model_uuid unless uuid.present?
  end

  def model_uuid
    "#{uuid_prefix}_#{SecureRandom.uuid.gsub('-', '')}"
  end

  def uuid_prefix
    self.class::PREFIX
  end
end