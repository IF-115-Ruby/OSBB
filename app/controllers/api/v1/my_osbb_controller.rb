class Api::V1::MyOsbbController < ApplicationController
  def balance
    @balance = {
      last_payment: current_user.last_payment_date&.strftime("%d-%m-%Y"),
      balance_total: current_user.balance_total&.ceil(2)
    }
  end
end
