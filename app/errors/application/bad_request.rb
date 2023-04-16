module Application
  class BadRequest < Error
    STATUS_CODE = :bad_request
  end
end