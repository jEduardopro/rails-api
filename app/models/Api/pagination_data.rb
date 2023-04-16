module Api
  class PaginationData
    include ActiveModel::Model

    SORT_DIRECTION = {
      asc: 'asc',
      desc: 'desc'
    }.freeze
    DEFAULT_PAGE = 1
    DEFAULT_SORT_BY = 'created_at'
    DEFAULT_SORT_DIRECTION = SORT_DIRECTION[:asc]
    DEFAULT_PAGE_SIZE = 20
    MAX_PAGE_SIZE = 200

    # enum sort_direction: SORT_DIRECTION

    attr_accessor :page, :page_size, :sort_klass, :sort_by, :sort_direction

    validates :sort_by, presence: true
    validates :sort_direction, inclusion: { in: %w[asc desc] }, presence: true
    validates :sort_klass, presence: true
    validates :page, presence: true
    validates :page_size, presence: true
    validate :sort_klass_valid
    validate :sort_by_valid

    def initialize(sort_klass:, page: nil, page_size: nil, sort_by: nil, sort_direction: nil)
      @sort_klass = sort_klass
      @page = page || DEFAULT_PAGE
      @page_size = page_size || DEFAULT_PAGE_SIZE
      @sort_by = sort_by || DEFAULT_SORT_BY
      @sort_direction = SORT_DIRECTION[sort_direction&.downcase&.to_sym] || DEFAULT_SORT_DIRECTION
    end

    def order_clause
      "#{sort_klass.table_name}.#{sort_by} #{sort_direction}"
    end

    def error_message
      return nil if valid?

      errors.full_messages.join(', ')
    end

    private

    def sort_klass_valid
      errors.add(:sort_klass, 'is invalid') unless sort_klass.respond_to?(:column_names)
    end

    def sort_by_valid
      unless sort_klass.respond_to?(:column_names) && sort_klass.column_names.include?(sort_by)
        errors.add(:sort_by,
                   'is invalid')
      end
    end
  end
end