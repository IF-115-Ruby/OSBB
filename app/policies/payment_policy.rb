class PaymentPolicy < AdminPolicy
  ["new_import?", "import?"].each do |action|
    define_method(action) do
      user_admin
    end
  end
end
