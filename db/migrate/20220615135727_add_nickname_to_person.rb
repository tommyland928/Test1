class AddNicknameToPerson < ActiveRecord::Migration[7.0]
  def change
    add_column :people, :nickname, :string
  end
end
