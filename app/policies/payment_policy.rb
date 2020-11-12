class PaymentPolicy < AdminPolicy
  def new_import?
    user_admin
  end

  def import?
    user_admin
  end
end
