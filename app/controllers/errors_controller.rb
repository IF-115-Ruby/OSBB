class ErrorsController < ApplicationController
  layout 'errors'

  def not_found
    render head(:not_found)
  end

  def server_error
    render head(:internal_server_error)
  end

  def unacceptable
    render head(:unprocessable_entity)
  end
end
