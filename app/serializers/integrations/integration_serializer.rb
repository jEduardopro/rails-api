module Integrations
  class IntegrationSerializer < BaseSerializer
    attr_reader :expansions

    def initialize(object, expand = []) # rubocop:todo Lint/MissingSuper
      instance_variable_set(source_instance_variable, object)
      @expansions = expand || []
    end

    def serialize_attributes
      default_attributes.merge(attributes_hash)
    end

    private

    def source
      instance_variable_get(source_instance_variable)
    end

    def default_attributes
      hash = { object: object_name(self.class) }

      if source.respond_to?('uuid')
        if use_uuid?
          hash.merge(uuid: source.uuid)
        else
          hash.merge(id: source.uuid)
        end
      else
        hash
      end
    end

    def use_uuid?
      false
    end

    def attributes_hash
      source.as_json(except: total_excluded_attributes).merge(additional_attributes)
    end

    def source_instance_variable
      "@#{self.class::SOURCE_CLASS.name.split('::').last.underscore}"
    end

    def append(serializer:, data:, nested_expansion: [])
      if data.respond_to?(:map)
        serialized_data = data.map { |instance| serializer.serialize(instance, nested_expansion) }
        object_type = 'list'
      else
        serialized_data = serializer.serialize(data, nested_expansion)
        object_type = object_name(serializer)
      end

      response = {}

      response[:object] = object_type
      response[:data] = serialized_data

      response
    end

    def object_name(klass)
      klass.name.demodulize.underscore.gsub('_serializer', '')
    end

    def total_excluded_attributes
      %i[id created_at updated_at].concat(excluded_attributes)
    end

    def excluded_attributes
      []
    end

    def additional_attributes
      {}
    end
  end
end