class AddFirstToChips < ActiveRecord::Migration[7.0]
  def change
    add_column :chips, :first, :integer
  end
end
