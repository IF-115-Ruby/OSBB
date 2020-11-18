class AddAccountableToAccount < ActiveRecord::Migration[6.0]
  def change
    safety_assured { add_reference :accounts, :accountable, polymorphic: true }
  end
end
