class Api::V1::MyOsbbController < Api::ApiController
  def balance
    @user = current_user
  end
end
