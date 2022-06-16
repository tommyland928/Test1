class AddNameToChips < ActiveRecord::Migration[7.0]
  def change
    add_column :chips, :name, :string
  end
end
