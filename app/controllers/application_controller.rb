class ApplicationController < ActionController::Base
  def error
  render status_code.to_s, status: (params[:code] || 500)
  end
end
