class AddSendMoneyToPerson < ActiveRecord::Migration[7.0]
  def change
    add_column :people, :sendMoney, :integer
  end
end
