module Application
  class NotFound < Error
    STATUS_CODE = :not_found
  end
end