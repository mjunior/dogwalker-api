class ApplicationController < ActionController::API

  def errors object
    {
      errors: object.errors
    }
  end
end
