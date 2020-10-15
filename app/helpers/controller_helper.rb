module ControllerHelper
  def successful_update(message)
    flash[:success] = message
  end
end
