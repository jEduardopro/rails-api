module Application
  class UnprocessableEntity < Error
    STATUS_CODE = :unprocessable_entity
  end
end