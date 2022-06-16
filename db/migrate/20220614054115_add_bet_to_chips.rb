class AddBetToChips < ActiveRecord::Migration[7.0]
  def change
    add_column :chips, :bet, :integer
  end
end
