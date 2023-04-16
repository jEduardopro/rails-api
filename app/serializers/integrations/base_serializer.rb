module Integrations
  class BaseSerializer
    def self.serialize(...)
      new(...).attributes
    end

    def attributes
      OpenStruct.new(serialize_attributes)
    end

    private

    def serialize_attributes
      raise NotImplementedError
    end
  end
end