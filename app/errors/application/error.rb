module Application
  class Error < StandardError
    attr_accessor :message, :error_set

    # rubocop:disable Lint/MissingSuper
    def initialize(error)
      @error = error
      @error_set = {}
      @message = error

      set_active_model_error if active_model_error?
    end
    # rubocop:enable Lint/MissingSuper

    def status
      self.class::STATUS_CODE
    end

    def as_json(_options = {})
      error_set.merge({ message: })
    end

    private

    attr_reader :error

    def active_model_error?
      error.is_a?(ActiveModel::Errors)
    end

    def set_active_model_error
      @message = error.full_messages.join(' ')
      @error_set = error.messages
    end
  end
end