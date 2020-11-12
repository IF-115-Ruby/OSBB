class BillingContractPolicy < AdminPolicy
  %w[index? show? create? new? update? edit? destroy? new_import? import?].each do |action|
    define_method(action) do
      user_admin
    end
  end
end
