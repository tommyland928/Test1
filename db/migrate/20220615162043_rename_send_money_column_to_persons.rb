class RenameSendMoneyColumnToPersons < ActiveRecord::Migration[7.0]
  def change
    rename_column :people, :sendMoney, :send
  end
end
