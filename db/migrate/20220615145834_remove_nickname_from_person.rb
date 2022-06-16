class RemoveNicknameFromPerson < ActiveRecord::Migration[7.0]
  def change
    remove_column :people, :nickname, :string
  end
end
